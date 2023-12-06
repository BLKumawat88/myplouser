// ignore_for_file: avoid_print
import 'dart:convert';
import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../controller/all_in_controller.dart';

class APICall {
  // final apiBaseUrl = 'http://myplo.itworkshop.in:4000/graphql';
  final apiBaseUrl = 'https://myplo.com/graphql';
  Map<String, String> headers = {
    'Content-Type': 'application/json',
    'Cookie': '',
  };

  Future<dynamic> getRequest(String endPoint) async {
    var apiUrl = Uri.parse(apiBaseUrl + endPoint);
    log("apiUrl $apiUrl");
    try {
      final apiResponse = await http.get(apiUrl);
      if (apiResponse.statusCode == 200) {
        final finalResponse = json.decode(apiResponse.body);
        return finalResponse;
      }
    } catch (error) {
      print("Error show in catch getrequest() method $error");
      rethrow;
    }
  }

  Future<dynamic> postRequest(dynamic postData) async {
    var apiUrl = Uri.parse(apiBaseUrl);
    try {
      final apiResponse = await http.post(apiUrl,
          headers: {
            'Content-Type': 'application/json',
            'currency': 'USD',
          },
          body: json.encode(postData));
      final finalResponse = json.decode(apiResponse.body);
      updateCookie(apiResponse);

      return finalResponse;
    } catch (error) {
      print("Error show in catch postrequest() method $error");
      rethrow;
    }
  }

  Future<dynamic> postRequestWithToken(dynamic postData, token) async {
    var apiUrl = Uri.parse(apiBaseUrl);
    log("URL $apiUrl");
    try {
      final apiResponse = await http.post(apiUrl,
          headers: {
            'Content-Type': 'application/json',
            'Cookie': token,
            'currency': 'USD'
          },
          body: json.encode(postData));
      // log("apiResponse $apiResponse");
      log("decode1234 ${json.decode(apiResponse.body)} ");
      final finalResponse = json.decode(apiResponse.body);
      updateCookie(apiResponse);
      return finalResponse;
    } catch (error) {
      print("Error show in catch postrequest() method $error");
      rethrow;
    }
  }

  void updateCookie(http.Response response) {
    if (response.headers['set-cookie'] != null) {
      String rawCookie = response.headers['set-cookie'] as String;
      int index = rawCookie.indexOf(';');
      print('index $index');

      AllInProvider obj = AllInProvider();
      headers['Cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
      print('Header cookie ${headers['Cookie']}');
    }
  }
}
