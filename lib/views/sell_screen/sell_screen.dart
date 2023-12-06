import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myplo/controller/all_in_controller.dart';
import 'package:myplo/theme/common_theme.dart';
import 'package:myplo/theme/font_theme.dart';
import 'package:myplo/views/add_items/add_items.dart';
import 'package:provider/provider.dart';

class SellScreen extends StatefulWidget {
  SellScreen({super.key});

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  late AllInProvider provider;
  File? selectedImage;
  String base64Image = "";

  Future<void> chooseImage(type) async {
    Navigator.pop(context);
    // ignore: prefer_typing_uninitialized_variables
    var image;
    if (type == "camera") {
      image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 10);
    } else {
      image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 25);
    }
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
        base64Image = base64Encode(selectedImage!.readAsBytesSync());
        // won't have any error now
      });
    }
  }

  void bottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              InkWell(
                onTap: () {
                  chooseImage("camera");
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFF903E3),
                        Color(0xFF0A6DFE),
                      ],
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Image From Camera",
                      style: btnCameras,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {
                  chooseImage("Gallery");
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFF903E3),
                        Color(0xFF0A6DFE),
                      ],
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Image From Gallery",
                      style: btnCameras,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  var address;
  void getLongitudeLatitude(
    context,
    categoryID,
  ) async {
    bool serviceEnabled;
    LocationPermission permission;
    print('Get location');
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
                      valueColor: new AlwaysStoppedAnimation<Color>(
                        Color(0xFFF903E3),
                      ),
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

    var latitude = result.latitude;
    print('Latitude is $latitude');

    var longitude = result.longitude;
    print('Longitude is $longitude');

    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);

    var city = placemarks[0].locality;
    var state = placemarks[0].administrativeArea;
    var country = placemarks[0].country;
    // postcode = placemarks[0].postalCode;

    address = '$city, $state, $country';

    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return AddItems(
              latitude: latitude,
              longitude: longitude,
              address: address,
              categoryID: categoryID,
              city: "$city",
              state: "$state",
              country: "$country");
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AllInProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFF555555),
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Color(0xFF555555),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add Items',
                        style: appbarTitle,
                      ),
                      Text(
                        'What Are You Offering',
                        style: AddItemsPageTheme.whatAreYouOffering,
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Color(0xFFD9D9D9),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    GridView.builder(
                      itemCount: provider.categories.length,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 3),
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            log('object ${provider.categories[index]['fields']}');
                            // bottomSheet();
                            provider.itemConditions.clear();
                            provider.min = provider.categories[index]['fields']
                                    [1]['min']
                                .toDouble();
                            provider.max = provider.categories[index]['fields']
                                    [1]['max']
                                .toDouble();

                            provider.rangeSliderID = provider.categories[index]
                                ['fields'][1]['filterId'];
                            provider.itemConditions.addAll(
                                provider.categories[index]['fields'][0]
                                    ['values'][0]['valueChild']);
                            provider.conditionID = provider.categories[index]
                                ['fields'][0]['filterId'];

                            print("Range Slider id ${provider.rangeSliderID}");
                            print("conditionID ${provider.conditionID}");

                            getLongitudeLatitude(
                              context,
                              "${provider.categories[index]['id']}",
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  color: Color(0xFFD9D9D9),
                                ),
                                bottom: BorderSide(
                                  color: Color(0xFFD9D9D9),
                                ),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 3.5,
                                  height: 90,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(18),
                                    child: Image.network(
                                      provider.categories[index]['image'],
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    provider.categories[index]['name'],
                                    style: GoogleFonts.firaSans(
                                      fontSize: 13,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
