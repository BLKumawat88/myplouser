import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myplo/services/services.dart';
import 'package:myplo/theme/common_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:myplo/views/add_address/add_address_screen.dart';

class AllInProvider with ChangeNotifier {
  // final apiBaseUrl = 'http://myplo.itworkshop.in:4000/graphql';
  final apiBaseUrl = 'https://myplo.com/graphql';
  String email = "";
  String name = "";
  late String userId;
  String authToken = '';
  late String groupName;

  List homeScreenProductData = [
    {
      "id": 1,
      "image": "assets/images/a.png",
      "product_name": "Baby Shower",
      "price": "899",
      "hours": "22 Hour Ago",
      "location": "Karnataka,India",
      "is_fav": false,
    },
    {
      "id": 2,
      "image": "assets/images/b.png",
      "product_name": "Baby Shower",
      "price": "899",
      "hours": "22 Hour Ago",
      "location": "Karnataka,India",
      "is_fav": false,
    },
    {
      "id": 3,
      "image": "assets/images/c.png",
      "product_name": "Baby Shower",
      "price": "899",
      "hours": "22 Hour Ago",
      "location": "Karnataka,India",
      "is_fav": false,
    },
    {
      "id": 4,
      "image": "assets/images/d.png",
      "product_name": "Baby Shower",
      "price": "899",
      "hours": "22 Hour Ago",
      "location": "Karnataka,India",
      "is_fav": false,
    },
    {
      "id": 5,
      "image": "assets/images/e.png",
      "product_name": "Baby Shower",
      "price": "899",
      "hours": "22 Hour Ago",
      "location": "Karnataka,India",
      "is_fav": false,
    },
    {
      "id": 6,
      "image": "assets/images/f.png",
      "product_name": "Baby Shower",
      "price": "899",
      "hours": "22 Hour Ago",
      "location": "Karnataka,India",
      "is_fav": false,
    },
    {
      "id": 7,
      "image": "assets/images/f.png",
      "product_name": "Baby Shower",
      "price": "899",
      "hours": "22 Hour Ago",
      "location": "Karnataka,India",
      "is_fav": false,
    },
  ];

  Map userProfileData = {
    'userName': '',
    'email': '',
    'phoneNumber': '',
    'delivery_address': '',
    'pickup_address': '',
    'profileImage': '',
  };

  Map onlineLinks = {
    'facebook': '',
    'twitter': '',
    'instagram': '',
    'youtube': '',
    'copyright': '',
  };

  Map addAddress = {
    'name': '',
    'address1': '',
    'address2': '',
    'city': '',
    'state': '',
    'selectCountry': '',
    'mobileNumber': '',
    'zipCode': '',
  };

  double? latitude;
  double? longitude;
  String? city;
  String? state;
  String? country;
  String? postcode;
  String address = 'Your address is...';

  void showSnackbar(context, {String title = 'Invalid password'}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          title,
          style: GoogleFonts.archivo(
            color: Colors.white,
            fontSize: 18,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Color(0xFFF157A9),
        dismissDirection: DismissDirection.down,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  addToFav(int id, context) {
    print('Product id is $id');

    var index =
        homeScreenProductData.indexWhere((element) => element['id'] == id);
    if (homeScreenProductData[index]['is_fav'] =
        !homeScreenProductData[index]['is_fav']) {
      showSnackbar(context, title: 'Product added to favorite');
    } else {
      showSnackbar(context, title: 'Product remove from favorite');
    }
    // if (homeScreenProductData[index]['is_fav']) {
    //   homeScreenProductData[index]['is_fav'] = true;
    // } else {
    //   homeScreenProductData[index]['is_fav'] = false;
    // }

    notifyListeners();
  }

  void login(Map userLoginData, context) async {
    Map userLogin = {
      "query":
          "mutation signin(\$email: String!,\$password: String!,\$code: String) {signin(email:\$email, password:\$password, code:\$code) {result {userId userName profileImage status location {lat_lon state country pincode city}currencyCode currencySymbol}noEmail}}",
      "variables": userLoginData
    };

    try {
      CommanDialog.showLoading(context, title: 'Please wait...');
      Map response = await postRequest(userLogin);
      if (response.containsKey('data')) {
        if (response['data']['signin'] != null) {
          CommanDialog.hideLoading(context);
          userId = response['data']['signin']['result']['userId'];

          Map userInfo = {"user_id": "$userId", "authToken": authToken};

          final _storage = const FlutterSecureStorage();
          final userDataLocal = json.encode(userInfo);
          await _storage.write(key: 'isuser_myplo', value: userDataLocal);
          getCategoryDetails(context);
        }
      }

      if (response.containsKey('errors')) {
        CommanDialog.hideLoading(context);
        print(
          'User login response status 400 :- ${response['errors'][0]['message']}',
        );
        showSnackbar(context, title: 'Invalid Password');
      }
    } catch (e) {
      print('Error login :- $e');
    }
  }

  void signup(Map userSignupData, context) async {
    // print('User signup data :- $userSignupData');
    Map userSignup = {
      "query":
          "mutation signup(\$data: SignupInput) {signup(data: \$data) {result {userId token userName profileImage status location {lat_lon state country pincode city}currencyCode currencySymbol}noEmail }}",
      "variables": {
        "data": userSignupData,
      },
    };

    try {
      CommanDialog.showLoading(context, title: 'Please wait...');

      Map response = await APICall().postRequest(userSignup);

      if (response.containsKey('data')) {
        if (response['data']['signup'] != null) {
          CommanDialog.hideLoading(context);
          print('User signup response status 200 :- $response');
          print(
            'Response data success user id :- ${response['data']['signup']['result']['userId']}',
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/',
            (route) => false,
          );
        }
      }

      if (response.containsKey('errors')) {
        CommanDialog.hideLoading(context);
        print(
          'User signup response status 400 :- ${response['errors'][0]['message']}',
        );
        showSnackbar(context, title: response['errors'][0]['message']);
      }
    } catch (e) {
      print('Error signup :- $e');
      CommanDialog.hideLoading(context);
      CommanDialog.showErrorDialog(context);
    }
  }

  void forgotPassword(Map userForgotPassword, context) async {
    print('User forgot password recovery email $userForgotPassword');
    Map forgotPassword = {
      "query":
          "mutation forgotPassword(\$email:String!){forgotPassword(email: \$email){result}}",
      "variables": userForgotPassword,
    };

    try {
      CommanDialog.showLoading(context, title: 'Please wait...');

      Map response = await APICall().postRequest(forgotPassword);
      print('User forgot password recovery email response :- $response');

      if (response.containsKey('data')) {
        CommanDialog.hideLoading(context);
        if (response['data']['forgotPassword'] != null) {
          print(
            'Recovery email status 200 :- ${response['data']['forgotPassword']['result']}',
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/',
            (route) => false,
          );
          showSnackbar(
            context,
            title: '${response['data']['forgotPassword']['result']}',
          );
        }
      }

      if (response.containsKey('errors')) {
        showSnackbar(context, title: '${response['errors'][0]['message']}');
      }
    } catch (e) {
      print('User forgot password recovery email error :- $e');
    }
  }

  List categories = [];
  List categoriesForHomeScreen = [];
  void getCategoryDetails(context) async {
    CommanDialog.showLoading(context, title: 'Please wait...');
    categories.clear();
    categoriesForHomeScreen.clear();
    Map categoryDetails = {
      "query":
          "query getCategoryDetails(\$fetch: String) {getCategoryDetails(fetch: \$fetch) {category{id name description image createdAt updatedAt status isFeatured instantBuy fields{filterId name values{ valueParentId valueParent valueChild{valueChildId valueChildData valueChildSelected}}min max inputTag isMandatory}}frequency currencyCode currencySymbol unreadMessage adBannerDetails{id name webBannerImage mobileBannerImage bannerUrl status updatedAt createdAt}}}",
      "variables": {}
    };
    try {
      Map response = await APICall().postRequest(categoryDetails);
      CommanDialog.hideLoading(context);
      if (response.containsKey('data')) {
        if (response['data']['getCategoryDetails'] != null) {
          categories.addAll(response['data']['getCategoryDetails']['category']);

          if (categories.length > 4) {
            for (int i = 0; i < 4; i++) {
              categoriesForHomeScreen.add(categories[i]);
            }
          } else {
            categoriesForHomeScreen
                .addAll(response['data']['getCategoryDetails']['category']);
          }
          print("getCategoryDetails Success 2");
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/bottom_navigation',
            (route) => false,
          );
          getAllProductOfCategoryRecentListing(context);
          getAllRecentProducts(context);
        } else {
          CommanDialog.showErrorDialog(context);
        }
      }
    } catch (e) {
      CommanDialog.hideLoading(context);
      print('Get category detail error :- $e');
    }
  }

  List recentProductsList = [];
  void getAllRecentProducts(context) async {
    recentProductsList.clear();
    Map recentProducts = {
      "query":
          "query (\$id: Int, \$type: Int, \$pageNumber: Int) {getUserDetails(id: \$id, type: \$type, pageNumber: \$pageNumber) {foundUser {id recentProducts {id image price name address}}}}",
      "variables": {"id": int.parse(userId)}
    };
    try {
      Map response =
          await APICall().postRequestWithToken(recentProducts, authToken);
      if (response.containsKey('data')) {
        if (response['data']['getUserDetails'] != null) {
          recentProductsList.addAll(response['data']['getUserDetails']
              ['foundUser']['recentProducts']);
          print("Recent Browse success");
          notifyListeners();
        } else {
          CommanDialog.showErrorDialog(context);
        }
      }
    } catch (e) {
      print('Get recent product error :- $e');
    }
  }

  List notificationList = [];
  void getAllNotification(context) async {
    CommanDialog.showLoading(context, title: 'Please wait...');
    Map allNotifications = {
      "query":
          " query getNotifications {getNotifications {id type message timeAgo imageUrl}}",
      "variables": {}
    };

    try {
      Map response =
          await APICall().postRequestWithToken(allNotifications, authToken);
      CommanDialog.hideLoading(context);
      if (response.containsKey('data')) {
        if (response['data']['getNotifications'] != null) {
          notificationList.addAll(response['data']['getNotifications']);
          Navigator.pushNamed(context, '/notification_screen');
        } else {
          CommanDialog.showErrorDialog(context);
        }
      }
    } catch (e) {
      print('Get recent product error :- $e');
    }
  }

  List soldoutData = [];
  List reviewsdata = [];
  List sellingData = [];
  List myOrderData = [];

  void getUser(context) async {
    soldoutData.clear();
    reviewsdata.clear();
    sellingData.clear();
    myOrderData.clear();
    Map currentUser = {
      "query":
          "query (\$id: Int, \$type: Int, \$pageNumber: Int) {getUserDetails(id: \$id, type: \$type, pageNumber: \$pageNumber) {foundUser {id googleId faceBookId email userName phoneNumber amount status createdAt updatedAt userRating profileImage isBlocked blocked googleVerified userRating verifications {google faceBook email apple}recentProducts {id image price name address}location {city}buyerShippingAddress{_id Name country address1 address2 city state zipCode phoneNumber}payOutMethod {_id type address1 address2 city state postal_code country stripeCountry paypal_email currency_code routing_number account_number account_holder_name holder_type document_images image source phone_number address_kanji address_kana bank_name branch_name branch_code ssn_last_4_digits default IBAN_Number transit_Number institution_Number clearing_Code IFSC_code personal_Id bank_Code sort_Code stripeAccountCreatedNumber}}ForSale {status sellingStatus sellingTimeStamp updatedAt viewers createdAt rate id title description images isFree featured}SoldOut { status sellingStatus sellingTimeStamp updatedAt viewers createdAt rate id title description images isFree featured}favourites {id title description images isFree featured rate currencySymbol location {state pincode}}review {id userFrom imageUrl fromName userTo toName ratings comment feedBack updatedAt createdAt timeAgo}myOrders {_id productId buyerUserId sellerUserId status createdAt updatedAt userFrom imageUrl fromName orderDetails {productId productName productImage productFee shippingRate totalFee currency currencySymbol transactionId buyerName sellerName paymentStatus paymentType serviceFeeBuyerRate}buyerShippingAddress {_id Name country address1 address2 city state zipCode phoneNumber}shippingDetails {shippmentDate shippmentMethod shippementService trackingId notes}}mySales {_id productId buyerUserId sellerUserId status createdAt updatedAt userFrom imageUrl fromName orderDetails { productId productName productImage productFee shippingRate totalFee currency currencySymbol transactionId buyerName sellerName paymentStatus paymentType serviceFeeBuyerRate}buyerShippingAddress {_id Name country address1 address2 city state zipCode phoneNumber}shippingDetails {shippmentDate shippmentMethod shippementService trackingId notes}}}}",
      "variables": {"id": int.parse(userId)}
    };

    try {
      CommanDialog.showLoading(context, title: 'Please wait...');
      Map response =
          await APICall().postRequestWithToken(currentUser, authToken);
      if (response.containsKey('data')) {
        CommanDialog.hideLoading(context);
        if (response['data']['getUserDetails'] != null) {
          userProfileData['userName'] =
              response['data']['getUserDetails']['foundUser']['userName'];
          userProfileData['email'] =
              response['data']['getUserDetails']['foundUser']['email'];
          userProfileData['phoneNumber'] =
              response['data']['getUserDetails']['foundUser']['phoneNumber'];
          userProfileData['profileImage'] =
              response['data']['getUserDetails']['foundUser']['profileImage'];
          soldoutData.addAll(response['data']['getUserDetails']['SoldOut']);
          reviewsdata.addAll(response['data']['getUserDetails']['review']);
          sellingData.addAll(response['data']['getUserDetails']['ForSale']);
          myOrderData.addAll(response['data']['getUserDetails']['myOrders']);
          notifyListeners();
        } else {
          CommanDialog.showErrorDialog(context);
        }
      }

      if (response.containsKey('errors')) {
        CommanDialog.hideLoading(context);
        print(
          'User login response status 400 :- ${response['errors'][0]['message']}',
        );
        showSnackbar(context, title: '${response['errors'][0]['message']}');
      }
    } catch (e) {
      CommanDialog.hideLoading(context);
      print('Get current user error :- $e');
    }
  }

  List alreadyAddedAddress = [];
  void buyerShippingAddress(context, bool status) async {
    CommanDialog.showLoading(context, title: 'Please wait...');
    alreadyAddedAddress.clear();
    Map buyerShippingAddress = {
      "query":
          "query (\$id: Int, \$type: Int, \$pageNumber: Int) {getUserDetails(id: \$id, type: \$type, pageNumber: \$pageNumber) {foundUser {id googleId faceBookId email userName phoneNumber amount status createdAt updatedAt userRating profileImage isBlocked blocked googleVerified userRating verifications {google faceBook email apple}recentProducts {id image price name address}location {city}buyerShippingAddress{_id Name country address1 address2 city state zipCode phoneNumber}payOutMethod {_id type address1 address2 city state postal_code country stripeCountry paypal_email currency_code routing_number account_number account_holder_name holder_type document_images image source phone_number address_kanji address_kana bank_name branch_name branch_code ssn_last_4_digits default IBAN_Number transit_Number institution_Number clearing_Code IFSC_code personal_Id bank_Code sort_Code stripeAccountCreatedNumber}}ForSale {status sellingStatus sellingTimeStamp updatedAt viewers createdAt rate id title description images isFree featured}SoldOut { status sellingStatus sellingTimeStamp updatedAt viewers createdAt rate id title description images isFree featured}favourites {id title description images isFree featured rate currencySymbol location {state pincode}}review {id userFrom imageUrl fromName userTo toName ratings comment feedBack updatedAt createdAt timeAgo}myOrders {_id productId buyerUserId sellerUserId status createdAt updatedAt userFrom imageUrl fromName orderDetails {productId productName productImage productFee shippingRate totalFee currency currencySymbol transactionId buyerName sellerName paymentStatus paymentType serviceFeeBuyerRate}buyerShippingAddress {_id Name country address1 address2 city state zipCode phoneNumber}shippingDetails {shippmentDate shippmentMethod shippementService trackingId notes}}mySales {_id productId buyerUserId sellerUserId status createdAt updatedAt userFrom imageUrl fromName orderDetails { productId productName productImage productFee shippingRate totalFee currency currencySymbol transactionId buyerName sellerName paymentStatus paymentType serviceFeeBuyerRate}buyerShippingAddress {_id Name country address1 address2 city state zipCode phoneNumber}shippingDetails {shippmentDate shippmentMethod shippementService trackingId notes}}}}",
      "variables": {"id": int.parse(userId)}
    };

    try {
      Map response = await APICall().postRequest(buyerShippingAddress);
      CommanDialog.hideLoading(context);
      if (response.containsKey('data')) {
        if (response['data']['getUserDetails'] != null) {
          if (response['data']['getUserDetails']['foundUser']
                  ['buyerShippingAddress']
              .isNotEmpty) {
            alreadyAddedAddress.addAll(response['data']['getUserDetails']
                ['foundUser']['buyerShippingAddress']);
            notifyListeners();
            if (status) {
              Navigator.pushNamed(context, '/show_address_screen');
            }
          } else {
            print('Address empty');
            notifyListeners();
            if (status == false) {
              Navigator.pop(context);
            }
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return AddAddressScreen(
                    addressType: false,
                  );
                },
              ),
            );
          }
        }
      }
    } catch (e) {
      CommanDialog.hideLoading(context);
      print('Buyer shipping address error $e');
    }
  }

  String editAddressId = '';
  void getDataToEditAddress(context, Map selectedAddress) {
    addAddress['name'] = selectedAddress['Name'];
    addAddress['address1'] = selectedAddress['address1'];
    addAddress['address2'] = '';
    addAddress['city'] = selectedAddress['city'];
    addAddress['state'] = selectedAddress['state'];
    // addAddress['selectCountry'] = selectedAddress['country'];
    addAddress['mobileNumber'] = selectedAddress['phoneNumber'];
    addAddress['zipCode'] = selectedAddress['zipCode'];
    editAddressId = selectedAddress['_id'];
    print('data $selectedAddress');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return AddAddressScreen(
            addressType: true,
          );
        },
      ),
    );
  }

  int productIdToBuy = 1000;
  dynamic shippingFee = 12;

  dynamic totalAmount = 0;

  void getShippingRate(context, indexvalue) async {
    print("ZIP CODE $indexvalue");

    // print(int.parse(addAddress['zipCode']));
    Map updateShippingAddress = {
      "query":
          "query getShipping(\$pid: Int,\$address: AddressInput){getShipping(pid:\$pid,address:\$address)}",
      "variables": {
        "pid": productIdToBuy,
        "address": {
          "name": "${alreadyAddedAddress[indexvalue]['Name']}",
          "address1": "${alreadyAddedAddress[indexvalue]['address1']}",
          "address2": "${alreadyAddedAddress[indexvalue]['address2']}",
          "city": "${alreadyAddedAddress[indexvalue]['city']}",
          "country": "${alreadyAddedAddress[indexvalue]['selectCountry']}",
          "phonenumber":
              int.parse(alreadyAddedAddress[indexvalue]['phoneNumber']),
          "state": "${alreadyAddedAddress[indexvalue]['state']}",
          "zipcode": int.parse(alreadyAddedAddress[indexvalue]['zipCode']),
        }
      }
    };

    try {
      print("TOKENN $authToken");
      CommanDialog.showLoading(context);
      Map response = await APICall()
          .postRequestWithToken(updateShippingAddress, authToken);
      CommanDialog.hideLoading(context);
      print("$response RESPONSEEE");
      if (response.containsKey('data')) {
        shippingFee = response['data']['getShipping'];

        totalAmount =
            response['data']['getShipping'] + 5.99 + productDetail['rate'];
        print("Shipping Fee $productDetail");
        Navigator.pushNamed(
          context,
          '/proceed_to_payment_screen',
          arguments: alreadyAddedAddress[indexvalue],
        );
      }
      if (response.containsKey('errors')) {
        showSnackbar(context, title: '${response['errors']['0']['message']}');
      }
    } catch (e) {
      print('Update shipping address error $e');
    }
  }

  void updateShippingAddress(context, title) async {
    Map updateShippingAddress = {
      "query":
          " mutation updateShippingAddress(\$id: ID, \$data: [buyerShippingAddress]) {updateShippingAddress(id: \$id data: \$data)}",
      "variables": {
        "id": editAddressId,
        "data": [
          {
            "Name": addAddress['name'],
            "address1": addAddress['address1'],
            "address2": addAddress['address2'],
            "city": addAddress['city'],
            "country": addAddress['selectCountry'],
            "phoneNumber": addAddress['mobileNumber'],
            "state": addAddress['state'],
            "zipCode": addAddress['zipCode'],
          }
        ]
      }
    };

    try {
      print("TOKENN $authToken");
      CommanDialog.showLoading(context);
      Map response = await APICall()
          .postRequestWithToken(updateShippingAddress, authToken);
      CommanDialog.hideLoading(context);
      if (response.containsKey('data')) {
        if (response['data']['updateShippingAddress'] != null) {
          print("response $response");
          Navigator.pop(context);
          if (title == "Address Updated Successfully") {
            Navigator.pop(context);
          }

          CommanDialog.showErrorDialog(context, description: "$title");
          print(
            'Update shipping address status 200 ${response['data']['updateShippingAddress']}',
          );
        }
      }
      if (response.containsKey('errors')) {
        showSnackbar(context, title: '${response['errors']['0']['message']}');
      }
    } catch (e) {
      print('Update shipping address error $e');
    }
  }

  void deleteShippingAddress(context, String id) async {
    print('Delete id $id');
    CommanDialog.showLoading(context, title: 'Please wait...');
    Map deleteShippingAddress = {
      "query":
          "mutation deleteShippingAddress(\$id: ID) {deleteShippingAddress(id: \$id)}",
      "variables": {"id": id}
    };

    try {
      Map response = await APICall()
          .postRequestWithToken(deleteShippingAddress, authToken);
      CommanDialog.hideLoading(context);
      if (response.containsKey('data')) {
        if (response['data']['deleteShippingAddress'] != null) {
          buyerShippingAddress(context, false);
        }
      }
    } catch (e) {
      CommanDialog.hideLoading(context);
      print('Delete shipping address error $e');
    }
  }

  void editUser(context) async {
    CommanDialog.showLoading(context);
    Map editUser = {
      "query":
          "mutation (\$id: Int \$email: String \$phoneNumber: String \$password: String \$newPassword: String \$oldPassword: String \$userName: String \$status: String \$profileImage: Upload \$type: String) {editProfile(data: {id: \$id email: \$email phoneNumber: \$phoneNumber password: \$password newPassword: \$newPassword oldPassword: \$oldPassword userName: \$userName status: \$status profileImage: \$profileImage type: \$type}) {userName phoneNumber status password oldPassword newPassword email profileImage}}",
      "variables": {
        "id": int.parse(userId),
        "userName": userProfileData['userName'],
        // "profileImage": userProfileData['profileImage'],
        "email": userProfileData['email'],
        "phoneNumber": userProfileData['phoneNumber']
      }
    };

    print('Edit user 111 $editUser');

    try {
      Map response = await APICall().postRequestWithToken(editUser, authToken);
      if (response.containsKey('data')) {
        if (response['data']['editProfile'] != null) {
          print('Edit user ${response['data']['editProfile']}');

          // userProfileData.addEntries({'id': 10000}.entries);

          // userProfileData.addAll({'userName': 10000});

          // var name = userProfileData.putIfAbsent('userName', () => '10000');
          // print('User profile name ${name}');
          CommanDialog.hideLoading(context);
          CommanDialog.hideLoading(context);
          CommanDialog.hideLoading(context);
          CommanDialog.showErrorDialog(context, description: "Profile Updated");

          print('User profile data ${userProfileData}');
        }
      }

      if (response.containsKey('errors')) {
        print(
          'User login response status 400 :- ${response['errors'][0]['message']}',
        );
        showSnackbar(context, title: '${response['errors'][0]['message']}');
      }
    } catch (e) {
      print('Edit user error $e');
    }
  }

  void getCurrentUser(context) async {
    Map getCurrentUser = {
      "query":
          "query {getCurrentUser {id userName email profileImage unreadMessage verifications {google faceBook email apple}}}",
      "variables": {}
    };

    try {
      CommanDialog.showLoading(context, title: 'Please wait...');
      Map response = await APICall().postRequest(getCurrentUser);

      print('Get current user response status :- $response');

      if (response.containsKey('data')) {
        CommanDialog.hideLoading(context);
        if (response['data']['getCurrentUser'] != null) {
          print(
            'Get current user response status 200 :- ${response['data']['getCurrentUser']}',
          );
        } else {
          CommanDialog.showErrorDialog(context);
        }
      }
    } catch (e) {
      CommanDialog.hideLoading(context);
      print('Get current user error :- $e');
    }
  }

  List favoritesItems = [];
  void getFavoritesdata(context) async {
    favoritesItems.clear();
    Map currentUser = {
      "query":
          "query (\$id: Int, \$type: Int, \$pageNumber: Int) {getUserDetails(id: \$id, type: \$type, pageNumber: \$pageNumber) {foundUser {id googleId faceBookId email userName phoneNumber amount status createdAt updatedAt userRating profileImage isBlocked blocked googleVerified userRating verifications {google faceBook email apple}recentProducts {id image price name address}location {city}buyerShippingAddress{_id Name country address1 address2 city state zipCode phoneNumber}payOutMethod {_id type address1 address2 city state postal_code country stripeCountry paypal_email currency_code routing_number account_number account_holder_name holder_type document_images image source phone_number address_kanji address_kana bank_name branch_name branch_code ssn_last_4_digits default IBAN_Number transit_Number institution_Number clearing_Code IFSC_code personal_Id bank_Code sort_Code stripeAccountCreatedNumber}}ForSale {id title description images isFree featured}SoldOut {id title description images isFree featured}favourites {id title description images isFree featured rate currencySymbol location {state pincode}}review {id userFrom imageUrl fromName userTo toName ratings comment feedBack updatedAt createdAt timeAgo}myOrders {_id productId buyerUserId sellerUserId status createdAt updatedAt userFrom imageUrl fromName orderDetails {productId productName productImage productFee shippingRate totalFee currency currencySymbol transactionId buyerName sellerName paymentStatus paymentType serviceFeeBuyerRate}buyerShippingAddress {_id Name country address1 address2 city state zipCode phoneNumber}shippingDetails {shippmentDate shippmentMethod shippementService trackingId notes}}mySales {_id productId buyerUserId sellerUserId status createdAt updatedAt userFrom imageUrl fromName orderDetails { productId productName productImage productFee shippingRate totalFee currency currencySymbol transactionId buyerName sellerName paymentStatus paymentType serviceFeeBuyerRate}buyerShippingAddress {_id Name country address1 address2 city state zipCode phoneNumber}shippingDetails {shippmentDate shippmentMethod shippementService trackingId notes}}}}",
      "variables": {"id": int.parse(userId)}
    };

    try {
      CommanDialog.showLoading(context, title: 'Please wait...');
      Map response = await postRequest(currentUser);
      if (response.containsKey('data')) {
        CommanDialog.hideLoading(context);
        if (response['data']['getUserDetails'] != null) {
          if (response['data']['getUserDetails']['favourites'] != null) {
            favoritesItems
                .addAll(response['data']['getUserDetails']['favourites']);
          }

          Navigator.pushNamed(context, '/favorite_screen');
        } else {
          CommanDialog.showErrorDialog(context);
        }
      }

      if (response.containsKey('errors')) {
        CommanDialog.hideLoading(context);
        print(
          'User login response status 400 :- ${response['errors'][0]['message']}',
        );
        showSnackbar(context, title: '${response['errors'][0]['message']}');
      }
    } catch (e) {
      CommanDialog.hideLoading(context);
      print('Get current user error :- $e');
    }
  }

  Future<dynamic> postRequest(dynamic postData) async {
    print("authToken $authToken");
    var apiUrl = Uri.parse(apiBaseUrl);
    try {
      final apiResponse = await http.post(apiUrl,
          headers: {
            'Content-Type': 'application/json',
            'currency': 'USD',
            'Cookie': authToken,
          },
          body: json.encode(postData));

      final finalResponse = json.decode(apiResponse.body);

      log("APIII $finalResponse");

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

      authToken = (index == -1) ? rawCookie : rawCookie.substring(0, index);

      print('Header cookie $authToken');
    }
  }

  Map productDetail = {};
  List relatedProducts = [];
  void getProductDetailsWithRelatedProduct(context, int id) async {
    relatedProducts.clear();
    productDetail.clear();
    Map products = {
      "query":
          "query getProduct(\$id: Int) {getProduct(id: \$id) {id title description userName userProfile userId status sellingStatus sellingTimeStamp updatedAt viewers createdAt images likedUsers groupsId groupsName isFree isDeleted deletedAt categoryId category rate currencyCode currencySymbol userProfile timeAgo viewersCount isFav viewed speedImage frequency chatType isNew isBlocked type featured featuredTransactionId featuredExpiry featuredName featuredValidation featuredDescription instantBuy shippingRate usdProductRate usdShippingRate serviceFeeBuyerRate usdServiceFeeBuyerRate }}",
      "variables": {"id": id}
    };

    try {
      CommanDialog.showLoading(context);
      Map response = await APICall().postRequest(products);
      CommanDialog.hideLoading(context);

      if (response.containsKey('data')) {
        if (response['data']['getProduct'] != null) {
          relatedProducts.addAll(response['data']['getProduct']);
          productDetail =
              relatedProducts.firstWhere((data) => data['id'] == id.toString());
          log("productDetail $productDetail");
          Navigator.pushNamed(context, '/product_detail_screen');
        }
      }

      print(
          "Image video extension ${relatedProducts[0]['images'][0].split('.').last}");

      if (response.containsKey('errors')) {
        showSnackbar(context, title: '${response['errors'][0]['message']}');
      }
    } catch (e) {
      print('Get product error $e');
    }
  }

  List allProductOfcategory = [];
  String searchProductTitle = "";
  void getAllProductOfCategory(
      Map requiredData, context, arg, screenTypeStatus) async {
    CommanDialog.showLoading(context, title: 'Please wait...');
    allProductOfcategory.clear();
    print('Required data 123 $requiredData');

    Map allProducts = {
      "query":
          "query getAllProducts(\$filter: FilterInput, \$pageNumber: String) {getAllProducts(filter: \$filter, pageNumber: \$pageNumber) {id title userName userId status sellingStatus sellingTimeStamp updatedAt viewers createdAt images likedUsers groupsId groupsName isFree description isDeleted deletedAt categoryId category rate currencyCode currencySymbol userProfile timeAgo viewersCount isFav viewed speedImage frequency chatType isNew isBlocked type featured featuredTransactionId featuredExpiry featuredName featuredValidation instantBuy shippingRate usdProductRate usdShippingRate serviceFeeBuyerRate usdServiceFeeBuyerRate location{city state country lat_lon pincode address} }}",
      "variables": {"filter": requiredData}
    };

    try {
      Map response = await APICall().postRequest(allProducts);
      CommanDialog.hideLoading(context);
      if (response.containsKey('data')) {
        print("${response['data']['getAllProducts'].length}");
        allProductOfcategory.addAll(response['data']['getAllProducts']);
        if (screenTypeStatus) {
          Navigator.pushNamed(
            context,
            '/categories_product_screen',
            arguments: arg,
          );
        } else {
          Navigator.pushNamed(
            context,
            '/category_search_product',
          );
        }

        notifyListeners();
      }
    } catch (e) {
      CommanDialog.hideLoading(context);
      print('Get product error $e');
    }
  }

  List allProductOfcategoryRecentListing = [];
  List allProductOfcategoryRecentListingDummy = [];
  void getAllProductOfCategoryRecentListing(context) async {
    // CommanDialog.showLoading(context, title: 'Please wait...');
    allProductOfcategoryRecentListing.clear();
    allProductOfcategoryRecentListingDummy.clear();

    Map allProducts = {
      "query":
          "query getAllProducts(\$filter: FilterInput, \$pageNumber: String) {getAllProducts(filter: \$filter, pageNumber: \$pageNumber) {id title userName userId status sellingStatus sellingTimeStamp updatedAt viewers createdAt images likedUsers groupsId groupsName isFree description isDeleted deletedAt categoryId category rate currencyCode currencySymbol userProfile timeAgo viewersCount isFav viewed speedImage frequency chatType isNew isBlocked type featured featuredTransactionId featuredExpiry featuredName featuredValidation instantBuy shippingRate usdProductRate usdShippingRate serviceFeeBuyerRate usdServiceFeeBuyerRate location{city state country lat_lon pincode address} }}",
      "variables": {"filter": {}}
    };

    try {
      Map response =
          await APICall().postRequestWithToken(allProducts, authToken);
      // CommanDialog.hideLoading(context);
      if (response.containsKey('data')) {
        allProductOfcategoryRecentListing
            .addAll(response['data']['getAllProducts']);
        allProductOfcategoryRecentListingDummy
            .addAll(response['data']['getAllProducts']);
        log("Recent Listing success $allProductOfcategoryRecentListing");

        notifyListeners();
      }
    } catch (e) {
      CommanDialog.hideLoading(context);
      print('Get product error $e');
    }
  }

  void addItemsToFav(int id, int index, context) async {
    print('Id $id, Index $index');

    if (allProductOfcategoryRecentListing[index]['isFav'] == null) {
      print("TRUE");
      allProductOfcategoryRecentListing[index]['isFav'] = true;
      notifyListeners();
    } else {
      print("FA:S");
      allProductOfcategoryRecentListing[index]['isFav'] = null;
      notifyListeners();
    }
    Map addItemsToFav = {
      "query":
          "mutation likeUpdate(\$id: Int!) {likesUpdate(id: \$id) {result}}",
      "variables": {"id": id}
    };
    try {
      Map response =
          await APICall().postRequestWithToken(addItemsToFav, authToken);
      print('Get like update response :- $response');
      if (response.containsKey('data')) {
        // print(
        //   'Get like update response status 200 :- ${response['data']['likesUpdate']['result']}',
        // );
        if (response['data']['likesUpdate'] != null) {
          print("ggggg");
          // if (allProductOfcategory[index]['isFav'] != null) {
          //   if (allProductOfcategory[index]['isFav']) {
          //     allProductOfcategory[index]['isFav'] = false;
          //   } else {
          //     allProductOfcategory[index]['isFav'] = true;
          //   }
          // }
        }
      }

      if (response.containsKey('errors')) {
        print(
            'Get like update response status 400 ${response['data']['errors'][0]['message']}');
      }
    } catch (e) {
      print('Get like update error :- $e');
    }
  }

  List getAllCountries = [];
  void getCountries() async {
    getAllCountries.clear();
    Map getCountries = {
      "query":
          " query {getCountries {id shortName longName iso3 phoneCode numberCode createdAt updatedAt}}",
      "variables": {}
    };

    try {
      Map response = await APICall().postRequest(getCountries);

      if (response.containsKey('data')) {
        getAllCountries.clear();
        getAllCountries.addAll(response['data']['getCountries']);
        notifyListeners();
      }
    } catch (e) {
      print('Get countries error :- $e');
    }
  }

  List makeFeature = [];
  void getMakeFeaturedDetails(context) async {
    makeFeature.clear();
    Map makeFeatureDetails = {
      "query":
          "query {getFeaturedDetails {featuredInfo {id name image description price currencyCode status validationPeriod updatedAt createdAt currencySymbol beforeconversionMsg afterconversionMsg}paymentInfo {payment_type value icon key mode}}}",
      "variables": {}
    };

    try {
      Map response = await APICall().postRequest(makeFeatureDetails);
      if (response.containsKey('data')) {
        if (response['data']['getFeaturedDetails'] != null) {
          makeFeature
              .addAll(response['data']['getFeaturedDetails']['featuredInfo']);
          notifyListeners();
          print('Make feature details $makeFeature');
        }
      }
    } catch (e) {
      print('Make feature details error $e');
    }
  }

  List getstaticPageDetails = [];
  void getStaticPageDetails(context) async {
    CommanDialog.showLoading(context, title: 'Please wait...');
    getstaticPageDetails.clear();

    Map staticPageDetails = {
      "query":
          "query getstaticPageDetails {getstaticPageDetails {id title content url status updatedAt createdAt}}",
      "variables": {}
    };

    try {
      Map response = await APICall().postRequest(staticPageDetails);
      CommanDialog.hideLoading(context);
      if (response.containsKey('data')) {
        getstaticPageDetails.addAll(response['data']['getstaticPageDetails']);
        notifyListeners();
        print(
            'Get static page details status 200 ${response['data']['getstaticPageDetails']}');
      }
    } catch (e) {
      CommanDialog.hideLoading(context);
      print('Get static page details error $e');
    }
  }

  void getAddContactUs(Map contactUsDetails, context) async {
    CommanDialog.showLoading(context, title: 'Please wait...');
    print('Contact us details 123 $contactUsDetails');
    Map addContactUs = {
      "query":
          "mutation addContactUs(\$name: String!, \$email: String!, \$feedback: String!) {addContactUs(name: \$name, email: \$email, feedback: \$feedback) {name email feedback}}",
      "variables":
          // "email": "nikhil@mailinator.com",
          // "feedback": "test",
          // "name": "Nikhil Singhal"
          contactUsDetails,
    };

    try {
      Map response = await APICall().postRequest(addContactUs);
      CommanDialog.hideLoading(context);
      CommanDialog.hideLoading(context);
      if (response.containsKey('data')) {
        CommanDialog.showErrorDialog(context,
            description: "Your query has been sent");
        print('Add contact us data ${response['data']['addContactUs']}');
        // if (response['data']['addContactUs'] != null) {
        // }
      }
    } catch (e) {
      print('Add contact us data error $e');
    }
  }

  List salesData = [];
  void getSalesData() {
    salesData.clear();

    List dummySalesData = [
      [
        {
          'id': '1',
          'buyer': 'Vicky',
          'status_completed': 'Status Completed',
          'orderId': '10000s',
          'orderDate': '12 oct ,2022',
          'amount': '2.32',
          'status': 'Completed',
          'payoutStatus': 'Paid',
          'shipmentDate': '02/13/2022',
          'shipmentFee': '0.2',
          'transactionId': 'hjwkdc6',
          'deliveryConfirmedDate': '02/13/2022',
          'shipmentAddress': 'KK Nager Anna Tower ,302003,Banglore',
          'phoneNo': '8585858580'
        },
        {
          'shipmentDate': '02/13/2022',
          'shipmentMethod': 'glx',
          'trackingID': 'tx 123456',
          'Note': 'Note',
        },
      ],
      [
        {
          'id': '2',
          'buyer': 'Anurag',
          'status_completed': 'Status Completed',
          'orderId': '10000',
          'orderDate': '12 oct ,2022',
          'amount': '2.32',
          'status': 'Completed',
          'payoutStatus': 'Paid',
          'shipmentDate': '03/13/2022',
          'shipmentFee': '0.2',
          'transactionId': 'hjwkdc6',
          'deliveryConfirmedDate': '02/13/2022',
          'shipmentAddress': 'KK Nager Anna Tower ,302003,Banglore',
          'phoneNo': '8585858580'
        },
        {
          'shipmentDate': '03/13/2022',
          'shipmentMethod': 'glx',
          'trackingID': 'tx 123456',
          'Note': 'Note',
        },
      ],
      [
        {
          'id': '3',
          'buyer': 'Mily',
          'status_completed': 'Status Completed',
          'orderId': '10000',
          'orderDate': '12 oct ,2022',
          'amount': '2.32',
          'status': 'Completed',
          'payoutStatus': 'Paid',
          'shipmentDate': '04/13/2022',
          'shipmentFee': '0.2',
          'transactionId': 'hjwkdc6',
          'deliveryConfirmedDate': '02/13/2022',
          'shipmentAddress': 'KK Nager Anna Tower ,302003,Banglore',
          'phoneNo': '8585858580'
        },
        {
          'shipmentDate': '04/13/2022',
          'shipmentMethod': 'glx',
          'trackingID': 'tx 123456',
          'Note': 'Note',
        },
      ]
    ];
    salesData.addAll(dummySalesData);
    notifyListeners();
  }

  List chatUserListData = [];
  void getChatUserList(context) async {
    CommanDialog.showLoading(context, title: 'Please wait...');
    chatUserListData.clear();

    Map chatUserList = {
      "query":
          "query getRoster(\$type: String) {getRoster(type: \$type) {userId groupId groupName isBlocked isDeleted blockedBy userName profileImage role productName sellingStatus image productId currencyCode currencySymbol rate unreadMessage shippingRate}}",
      "variables": {}
    };

    try {
      Map response =
          await APICall().postRequestWithToken(chatUserList, authToken);
      print('Response $response');
      CommanDialog.hideLoading(context);
      if (response.containsKey('data')) {
        if (response['data']['getRoster'] != null) {
          // print('Roster data ${response['data']['getRoster'][0]['userId']}');

          chatUserListData.addAll(response['data']['getRoster']);
          notifyListeners();
        }
      }
    } catch (e) {
      CommanDialog.hideLoading(context);
      print('Chat user list data error $e');
    }
  }

  String makeOfferValue = "";
  void createRoom(createRoomRequiredData, context, status) async {
    log("$createRoomRequiredData");
    CommanDialog.showLoading(context, title: 'Please Wait...');
    Map createRoom = {
      "query":
          "mutation createRoom(\$userId: Int!, \$productId: Int!, \$productuserId: Int!) {createRoom( userId: \$userId productId: \$productId productuserId: \$productuserId) {userId productId groupName productuserId id imageUrl profileUrl sellingStatus currencyCode currencySymbol rate}}",
      "variables": createRoomRequiredData
    };
    print('create room12345 $createRoom');

    try {
      Map response =
          await APICall().postRequestWithToken(createRoom, authToken);
      log("Create room $response");
      CommanDialog.hideLoading(context);
      if (response.containsKey('data')) {
        if (response['data']['createRoom'] != null) {
          print(
            'Create room response ${response['data']['createRoom']}',
          );
          roomId = response['data']['createRoom']['id'];
          Map productDataWithRoomId = {
            'productData': productDetail,
            'roomId': response['data']['createRoom']['id'],
          };
          if (status) {
            getMessagesAfterCreatingRoom(productDataWithRoomId, context);
          } else {
            //send offer msg
            Map requiredDataSendMessage = {
              "message": makeOfferValue,
              "room": int.parse(response['data']['createRoom']['id'])
            };
            sendMessage(requiredDataSendMessage, context, false);
            print("Room Has created $makeOfferValue");
          }
        }
      }

      if (response.containsKey('errors')) {
        print(
          'Create room response ${response['errors'][0]['message']}',
        );
      }
    } catch (e) {
      print('Create room error $e');
    }
  }

  Map chatMessageData = {};
  String roomId = "";

  dynamic userProfile = "";
  dynamic userName = "";
  void getMessagesAfterCreatingRoom(Map productDataWithRoomId, context) async {
    CommanDialog.showLoading(context, title: 'Please wait...');
    chatMessageData.clear();
    Map getMessage = {
      "query":
          "query getMessages(\$id: Int!) {getMessages(id: \$id) {productId productuserId productuserName title rate sellingStatus productuserImage isFree isBlocked blockedBy message {id message createdAt userId profileImage readMessage groupId}}}",
      "variables": {"id": int.parse(productDataWithRoomId['roomId'])}
    };

    try {
      Map response =
          await APICall().postRequestWithToken(getMessage, authToken);
      CommanDialog.hideLoading(context);
      if (response.containsKey('data')) {
        if (response['data']['getMessages'] != null) {
          chatMessageData.addAll(response['data']['getMessages']);
          print(
            'Get message response $chatMessageData',
          );
          if (productDataWithRoomId['productData']['userProfile'] != null &&
              productDataWithRoomId['productData']['userName'] != null) {
            userProfile = productDataWithRoomId['productData']['userProfile'];
            userName = productDataWithRoomId['productData']['userName'];
          }

          Navigator.pushNamed(
            context,
            '/user_chat_screen_test',
            arguments: productDataWithRoomId,
          );
        }
      }

      if (response.containsKey('errors')) {
        print(
          'Get message response ${response['errors'][0]['message']}',
        );
      }
    } catch (e) {
      print('Get message error $e');
    }
  }

  void getMessagesAfterSendingMessage(context) async {
    CommanDialog.showLoading(context, title: 'Please wait...');
    Map getMessage = {
      "query":
          "query getMessages(\$id: Int!) {getMessages(id: \$id) {productId productuserId productuserName title rate sellingStatus productuserImage isFree isBlocked blockedBy message {id message createdAt userId profileImage readMessage groupId}}}",
      "variables": {"id": int.parse(roomId)}
    };
    try {
      Map response =
          await APICall().postRequestWithToken(getMessage, authToken);
      CommanDialog.hideLoading(context);
      if (response.containsKey('data')) {
        if (response['data']['getMessages'] != null) {
          print(
            'Get message response ${response['data']['getMessages']}',
          );
          chatMessageData.addAll(response['data']['getMessages']);
          notifyListeners();
        }
      }

      if (response.containsKey('errors')) {
        print(
          'Get message response ${response['errors'][0]['message']}',
        );
      }
    } catch (e) {
      print('Get message error $e');
    }
  }

  void sendMessage(requiredDataSendMessage, context, status) async {
    CommanDialog.showLoading(context, title: 'Please wait...');
    Map sendMessage = {
      "query":
          "mutation sendMessage(\$message: String!, \$room: Int!) {sendMessage(message: \$message, room: \$room) {id message profileImage userId createdAt readMessage groupId}}",
      "variables": requiredDataSendMessage
    };

    try {
      Map response =
          await APICall().postRequestWithToken(sendMessage, authToken);
      CommanDialog.hideLoading(context);
      if (response.containsKey('data')) {
        if (response['data']['sendMessage'] != null) {
          print(
            'Send message response status 200 ${response['data']['sendMessage']}',
          );
          if (status) {
            getMessagesAfterSendingMessage(context);
          } else {
            CommanDialog.showErrorDialog(context, description: "Offer Sent");
          }
        }
      }

      if (response.containsKey('errors')) {
        print(
          'Send message response status 400 ${response['errors'][0]['message']}',
        );
      }
    } catch (e) {
      print('Send message error $e');
    }
  }

  List userChatData = [];
  void getUserChatData() {
    userChatData.clear();

    List dummyUserChatData = [
      {
        'chat': 0,
        'avatar': 'assets/images/paul.png',
        'text': 'Does it come with an additional box?',
        'time': '9:03 AM',
      },
      {
        'chat': 1,
        'avatar': 'assets/images/paul.png',
        'text': 'Yes, it come with an additional box.',
        'time': '9:08 AM',
      },
      {
        'chat': 0,
        'avatar': 'assets/images/paul.png',
        'text': 'I think you should go with Mavic Mini',
        'time': '9:03 AM',
      },
      {
        'chat': 1,
        'avatar': 'assets/images/paul.png',
        'text': 'First i try this product',
        'time': '9:08 AM',
      },
    ];
    userChatData.addAll(dummyUserChatData);
    notifyListeners();
  }

  void blockUser(context, int id) async {
    print('id block $id');
    Map blockUser = {
      "query":
          "mutation blockUser(\$id: Int) {blockUser(id: \$id) {status groupIds groupNames}}",
      "variables": {"id": id}
    };

    print('blockUser $blockUser');

    try {
      Map response = await APICall().postRequestWithToken(blockUser, authToken);
      print('Response $response');

      if (response.containsKey('data')) {
        // print(
        //   'Block user status 200 ${response['data']['blockUser']['status']}',
        // );
        showSnackbar(
          context,
          title: 'User ${response['data']['blockUser']['status']}',
        );
      }
    } catch (e) {
      print('Block user error $e');
    }
  }

  void deleteChat(String groupName) async {
    Map deleteChat = {
      "query":
          "mutation deleteChat(\$groupName: String!) {deleteChat(groupName: \$groupName) {id userFrom userTo chatroomId timeStamp}}",
      "variables": {"groupName": groupName}
    };

    try {
      Map response =
          await APICall().postRequestWithToken(deleteChat, authToken);

      print('Response $response');
      if (response.containsKey('data')) {
        if (response['data']['deleteChat'] != null) {
          print('Delete user status 200 ${response['data']['deleteChat']}');
        }
      }

      if (response.containsKey('errors')) {
        print('Delete user status 400 ${response['errors'][0]['message']}');
      }
    } catch (e) {}
  }

  Map requiredData = {
    "channel": "null",
    "featuredId": "",
    "paymentMode": "Stripe",
    "paymentUserId": "",
    "productId": "",
    "status": "succeeded",
    "tokenId": "",
    "type": "featured"
  };

  void updateItems(context, imagesAndVideoData, addProductRequiredData) async {
    CommanDialog.showLoading(context, title: 'Please wait...');
    var request = http.MultipartRequest('POST', Uri.parse(apiBaseUrl));
    Map mapData = {};
    int indexValueForSelectedImageAndVideoTOSendBackend = 0;

    if (imagesAndVideoData[0]['value'] != "") {
      mapData['$indexValueForSelectedImageAndVideoTOSendBackend'] = [
        "variables.data.images.$indexValueForSelectedImageAndVideoTOSendBackend"
      ];

      request.files.add(
        await http.MultipartFile.fromPath(
          '$indexValueForSelectedImageAndVideoTOSendBackend',
          '${imagesAndVideoData[0]['value']}',
        ),
      );
      indexValueForSelectedImageAndVideoTOSendBackend++;
    }

    if (imagesAndVideoData[1]['value'] != "") {
      mapData['$indexValueForSelectedImageAndVideoTOSendBackend'] = [
        "variables.data.images.$indexValueForSelectedImageAndVideoTOSendBackend"
      ];
      request.files.add(
        await http.MultipartFile.fromPath(
          '$indexValueForSelectedImageAndVideoTOSendBackend',
          '${imagesAndVideoData[1]['value']}',
        ),
      );
      indexValueForSelectedImageAndVideoTOSendBackend++;
    }
    if (imagesAndVideoData[2]['value'] != "") {
      mapData['$indexValueForSelectedImageAndVideoTOSendBackend'] = [
        "variables.data.images.$indexValueForSelectedImageAndVideoTOSendBackend"
      ];
      request.files.add(
        await http.MultipartFile.fromPath(
          '$indexValueForSelectedImageAndVideoTOSendBackend',
          '${imagesAndVideoData[2]['value']}',
        ),
      );
      indexValueForSelectedImageAndVideoTOSendBackend++;
    }
    if (imagesAndVideoData[3]['value'] != "") {
      mapData['$indexValueForSelectedImageAndVideoTOSendBackend'] = [
        "variables.data.images.$indexValueForSelectedImageAndVideoTOSendBackend"
      ];
      request.files.add(
        await http.MultipartFile.fromPath(
          '$indexValueForSelectedImageAndVideoTOSendBackend',
          '${imagesAndVideoData[3]['value']}',
        ),
      );
      indexValueForSelectedImageAndVideoTOSendBackend++;
    }
    if (imagesAndVideoData[4]['value'] != "") {
      mapData['$indexValueForSelectedImageAndVideoTOSendBackend'] = [
        "variables.data.images.$indexValueForSelectedImageAndVideoTOSendBackend"
      ];
      request.files.add(
        await http.MultipartFile.fromPath(
          '$indexValueForSelectedImageAndVideoTOSendBackend',
          '${imagesAndVideoData[4]['value']}',
        ),
      );
      indexValueForSelectedImageAndVideoTOSendBackend++;
    }

    if (imagesAndVideoData[5]['value'] != "") {
      mapData['$indexValueForSelectedImageAndVideoTOSendBackend'] = [
        "variables.data.images.$indexValueForSelectedImageAndVideoTOSendBackend"
      ];
      request.files.add(
        await http.MultipartFile.fromPath(
          '$indexValueForSelectedImageAndVideoTOSendBackend',
          '${imagesAndVideoData[5]['value']}',
        ),
      );
    }
    print(
        "indexValueForSelectedImageAndVideoTOSendBackend $indexValueForSelectedImageAndVideoTOSendBackend");

    request.fields.addAll({
      'operations': addProductRequiredData['operations'],
      'map': json.encode(mapData),
    });
    request.headers.addAll({
      'Content-Type': 'application/json',
      'Cookie': authToken,
      'currency': 'USD'
    });

    log("request.files ${request.files}");

    http.StreamedResponse response = await request.send();
    CommanDialog.hideLoading(context);

    if (response.statusCode == 200) {
      try {
        Map data = json.decode(await response.stream.bytesToString());

        print("data12345 $data");
        if (data['data']['updateProduct'] != null) {
          print("Data $data");
          requiredData['productId'] = data['data']['updateProduct']['id'];
        }
      } catch (error) {}

      Navigator.pushNamed(context, '/cong_screen');
      getCongratulationsScreenDataAfterAddingProductToBoost(context);

      // showSnackbar(context, title: 'Product has been update');
    } else {
      print('Response ${await response.stream.bytesToString()}');
      print('Response else ${response.reasonPhrase}');
    }
  }

  void sendFeedback(double rating) async {
    Map feedback = {
      "query":
          " mutation sendFeedBack(\$data: FeedBackData) {sendFeedBack(data: \$data)}",
      "variables": {
        "data": {
          "name": userProfileData['userName'],
          "email": userProfileData['email'],
          "feedBack": rating.toString(),
        }
      }
    };

    try {
      Map response = await APICall().postRequest(feedback);
      if (response.containsKey('data')) {
        if (response['data']['sendFeedBack'] != null) {
          print('Response status 200 ${response['data']['sendFeedBack']}');
        }
      }
    } catch (e) {
      print('Feedback error $e');
    }
  }

  void getLongitudeLatitude(context) async {
    bool serviceEnabled;
    LocationPermission permission;

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Padding(
            padding: const EdgeInsets.all(0.0),
            child: SizedBox(
              height: 35,
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Center(
                    child: CircularProgressIndicator.adaptive(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Color(0xFFF903E3)),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Please wait...',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    var result = await Geolocator.getCurrentPosition();
    print('Result $result');

    latitude = result.latitude;
    print('Latitude is $latitude');

    longitude = result.longitude;
    print('Longitude is $longitude');

    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude!, longitude!);

    city = placemarks[0].locality;
    state = placemarks[0].administrativeArea;
    country = placemarks[0].country;
    postcode = placemarks[0].postalCode;

    address = '$city, $state, $country';
    Navigator.pop(context);
    notifyListeners();
  }

  void getSiteInfo() async {
    Map siteInfo = {
      "query":
          "query {getSiteInfo {name,version,defaultCurrency,copyrightsText,defaultUnit,contactNo,contactUs image,favicon,footerLogo,footerBatch,loginImage,adminloginImage,footerBackground, utubeLink,twLink,fbLink,androidLink,iosLink,instagramLink,googleAnalyticKey googleAdSenseId productPageSlotId,productDetailPageSlotId,sellerDetailsPageSlotId,editProfilePageSlotId,chatPageSlotId,Environment,MerchantId,PublicKey,PrivateKey,fromAddress,fromName,uName,password,paymentApi,admob,admobBanner,googleApi,facebookAppId,googleAppId,firebaseJson,stripeSecretKey,stripePublishKey,paypalEnvironment,paypalAppId,braintree,stripe,paypal,appleClientId,appleTeamId,appleKeyIdentifier,appleP8File,hideOrderCancelStatus,facebookLogin,googleLogin, appleLogin,googleAdsence,colorCode,subcolorCode,serviceFeeBuyer,serviceFeeSeller,paypalClientId,paypalSecretKey,adminSupportMail,imageHost,paymentSDKMode,cloudName,cloudApiKey,cloudApiSecret}}",
      "variables": {}
    };

    try {
      Map response = await APICall().postRequest(siteInfo);

      print('Get site info response status :- $response');

      if (response.containsKey('data')) {
        if (response['data']['getSiteInfo'] != null) {
          // print(
          //   'Get site info response status 200 :- ${response['data']['getSiteInfo']['name']}',
          // );

          onlineLinks['facebook'] = response['data']['getSiteInfo']['fbLink'];
          onlineLinks['twitter'] = response['data']['getSiteInfo']['twLink'];
          onlineLinks['instagram'] =
              response['data']['getSiteInfo']['instagramLink'];
          onlineLinks['youtube'] = response['data']['getSiteInfo']['utubeLink'];
          onlineLinks['copyright'] =
              response['data']['getSiteInfo']['copyrightsText'];
          print('Link facebook ${onlineLinks['facebook']}');
        }
      }
    } catch (e) {
      print('Get site info error :- $e');
    }
  }

  late RangeValues currentRangeValues = RangeValues(1000, 100000);

  RangeValues returnRangeValue(min, max) {
    print('returnRangeValue');
    currentRangeValues = RangeValues(
      min.toDouble(),
      max.toDouble(),
    );
    return currentRangeValues;
  }

  updateRangeValue(value) {
    currentRangeValues = value;
    notifyListeners();
  }
  // add Item

  double min = 0;
  double max = 0;
  List itemConditions = [];
  int conditionID = 0;
  int rangeSliderID = 0;

  List listOfFeatured = [];

  String activatedButtonStatus = "2x";
  int feeToPay = 0;
  String payId = "0";
  getCongratulationsScreenDataAfterAddingProductToBoost(context) async {
    CommanDialog.showLoading(context, title: 'Please wait...');
    listOfFeatured.clear();
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(apiBaseUrl));
    request.body =
        '''{"query":" query {\\r\\ngetFeaturedDetails {\\r\\nfeaturedInfo {\\r\\n        id\\r\\n                name\\r\\n                image\\r\\n                description\\r\\n                price\\r\\n                currencyCode\\r\\n                status\\r\\n                validationPeriod\\r\\n                updatedAt\\r\\n                createdAt\\r\\n                currencySymbol\\r\\n                beforeconversionMsg\\r\\n                afterconversionMsg\\r\\n            }\\r\\n            paymentInfo {\\r\\n                payment_type\\r\\n                value\\r\\n                icon\\r\\n                key\\r\\n                mode\\r\\n            }\\r\\n        }\\r\\n    }","variables":{}}''';
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    Navigator.pop(context);
    if (response.statusCode == 200) {
      Map data = json.decode(await response.stream.bytesToString());
      listOfFeatured.addAll(data['data']['getFeaturedDetails']['featuredInfo']);
      activatedButtonStatus = listOfFeatured[0]['name'];
      feeToPay = listOfFeatured[0]['price'];
      payId = listOfFeatured[0]['id'];
      notifyListeners();
      print("listOfFeatured$listOfFeatured");
    } else {
      print(response.reasonPhrase);
    }
  }

  submitProductBoostDataAfterPaymentSuccess(context, type) async {
    requiredData['featuredId'] = payId;
    requiredData['paymentUserId'] = userId;
    print("OPP12345 ${json.encode(requiredData)}");
    var request = http.Request('POST', Uri.parse(apiBaseUrl));

    try {
      request.headers.addAll({
        'Content-Type': 'application/json',
        'Cookie': authToken,
        'currency': 'USD'
      });
      request.body =
          '''{"query":"mutation ChargePaymentMethod(\$data: ChargePaymentMethodInput) {\\r\\n        ChargePaymentMethod(data: \$data) {\\r\\n            success\\r\\n            transaction {\\r\\n                id\\r\\n                status\\r\\n                amount\\r\\n                currencyIsoCode\\r\\n                paymentInstrumentType\\r\\n                creditCard {\\r\\n                    cardType\\r\\n                    maskedNumber\\r\\n                    cardholderName\\r\\n                }\\r\\n                createdAt\\r\\n                updatedAt\\r\\n            }\\r\\n        }\\r\\n    }","variables":{"data":{"channel":null,"featuredId":${int.parse(payId)},"paymentMode":"Stripe","paymentUserId":${int.parse(userId)},"productId":${int.parse(requiredData['productId'])},"status":"succeeded","tokenId":"${requiredData['tokenId']}","type":"$type"}}}''';

      print("request.body ${request.body}");
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        Map data = json.decode(await response.stream.bytesToString());
        print(data);
        if (data['data']['ChargePaymentMethod'] != null) {
          print("SUCCESS UPDATED");
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/bottom_navigation',
            (route) => false,
          );
          CommanDialog.showErrorDialog(context,
              description: "Product has Marked as Featured");
        }
        if (data.containsKey('errors')) {
          showSnackbar(context, title: data['errors'][0]['message']);
        }
      } else {
        print("ERRRRR  ${response.reasonPhrase}");
        print(response.reasonPhrase);
      }
    } catch (error) {
      print("Error $error");
    }
  }

  submitProductinstantBuy(context, type, productid, addId) async {
    print("JJJJJJJ $type $productid $addId");
    requiredData['featuredId'] = payId;
    requiredData['paymentUserId'] = userId;
    print("OPP ${json.encode(requiredData)}");
    var request = http.Request('POST', Uri.parse(apiBaseUrl));
    try {
      request.headers.addAll({
        'Content-Type': 'application/json',
        'Cookie': authToken,
        'currency': 'USD'
      });
      request.body =
          '''{"query":"mutation ChargePaymentMethod(\$data: ChargePaymentMethodInput) {\\r\\n        ChargePaymentMethod(data: \$data) {\\r\\n            success\\r\\n            transaction {\\r\\n                id\\r\\n                status\\r\\n                amount\\r\\n                currencyIsoCode\\r\\n                paymentInstrumentType\\r\\n                creditCard {\\r\\n                    cardType\\r\\n                    maskedNumber\\r\\n                    cardholderName\\r\\n                }\\r\\n                createdAt\\r\\n                updatedAt\\r\\n            }\\r\\n        }\\r\\n    }","variables":{"data":{"addressId":"$addId","channel":null,"featuredId":${int.parse(payId)},"paymentMode":"Stripe","paymentUserId":${int.parse(userId)},"productId":$productid,"status":"succeeded","tokenId":"${requiredData['tokenId']}","type":"$type"}}}''';

      print("request.body ${request.body}");
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        Map data = json.decode(await response.stream.bytesToString());
        print(data);
        if (data['data']['ChargePaymentMethod'] != null) {
          print("SUCCESS UPDATED");

          Navigator.pushNamedAndRemoveUntil(
            context,
            '/bottom_navigation',
            (route) => false,
          );
          CommanDialog.showErrorDialog(context,
              description: "Order Placed check status in Orders");
        }
        if (data.containsKey('errors')) {
          showSnackbar(context, title: data['errors'][0]['message']);
        }
      } else {
        print("ERRRRR  ${response.reasonPhrase}");
        print(response.reasonPhrase);
      }
    } catch (error) {
      print("Error $error");
    }
  }

  Future<bool> isUserLogedIn() async {
    final _storage = const FlutterSecureStorage();
    final readDta = await _storage.read(key: 'isuser_myplo');
    if (readDta != null) {
      final userInfo = json.decode(readDta);

      userId = userInfo['user_id'];
      authToken = userInfo['authToken'];

      print("User Info $userInfo");
      return true;
    } else {
      return false;
    }
  }

  searchProduct(String enteredKeyword) {
    print("Search value  $enteredKeyword");
    List results = [];
    if (enteredKeyword.isEmpty) {
      print("is Empty");
      // if the search field is empty or only contains white-space, we'll display all users
      results = allProductOfcategoryRecentListing;
    } else {
      print("else");
      results = allProductOfcategoryRecentListing
          .where((user) => user["title"]
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive

      print("resulr $results");
      allProductOfcategoryRecentListingDummy = results;
      notifyListeners();
    }
  }
}
