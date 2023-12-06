import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myplo/controller/all_in_controller.dart';
import 'package:myplo/theme/common_theme.dart';
import 'package:myplo/theme/font_theme.dart';
import 'package:myplo/theme/text_form_fields_theme.dart';
import 'package:provider/provider.dart';

class AddItems extends StatefulWidget {
  double latitude;
  double longitude;
  String address;
  String categoryID;
  String city;
  String state;
  String country;
  AddItems(
      {super.key,
      required this.latitude,
      required this.longitude,
      required this.address,
      required this.categoryID,
      required this.city,
      required this.state,
      required this.country}) {
    print("categoryID $categoryID");
  }

  @override
  State<AddItems> createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  late AllInProvider provider;
  final formKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController discription = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController location = TextEditingController();
  double _currentSliderValue = 0;

  File? selectedOne;
  File? selectedTwo;
  File? selectedThree;
  File? selectedFour;
  File? selectedFive;
  File? selectedVideo;

  String base64ImageOne = "";
  String base64ImageTwo = "";
  String base64ImageThree = "";
  String base64ImageFour = "";
  String base64ImageFive = "";
  String base64ImageSix = "";
  var image;
  var videos;
  String userLocation = 'Location';

  Future<void> chooseImageOne(type) async {
    Navigator.pop(context);
    // ignore: prefer_typing_uninitialized_variables
    if (type == "camera") {
      image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 10);
    } else {
      image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 25);
    }
    if (image != null) {
      setState(() {
        selectedOne = File(image.path);
        base64ImageOne = base64Encode(selectedOne!.readAsBytesSync());

        print('Selected image $selectedOne');
        // won't have any error now
      });
    }
  }

  void bottomSheetOne() {
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
                  chooseImageOne("camera");
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
                  chooseImageOne("Gallery");
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

  Future<void> chooseImageTwo(type) async {
    Navigator.pop(context);
    // ignore: prefer_typing_uninitialized_variables
    if (type == "camera") {
      image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 10);
    } else {
      image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 25);
    }

    if (image != null) {
      setState(() {
        selectedTwo = File(image.path);
        base64ImageTwo = base64Encode(selectedTwo!.readAsBytesSync());
        print('Selected image $selectedTwo');
        // won't have any error now
      });
    }
  }

  void bottomSheetTwo() {
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
                  chooseImageTwo("camera");
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
                  chooseImageTwo("Gallery");
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

  Future<void> chooseImageThree(type) async {
    Navigator.pop(context);
    // ignore: prefer_typing_uninitialized_variables
    if (type == "camera") {
      image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 10);
    } else {
      image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 25);
    }

    if (image != null) {
      setState(() {
        selectedThree = File(image.path);
        base64ImageThree = base64Encode(selectedThree!.readAsBytesSync());

        print('Selected image $selectedThree');
        // won't have any error now
      });
    }
  }

  void bottomSheetThree() {
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
                  chooseImageThree("camera");
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
                  chooseImageThree("Gallery");
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

  Future<void> chooseImageFour(type) async {
    Navigator.pop(context);
    // ignore: prefer_typing_uninitialized_variables
    if (type == "camera") {
      image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 10);
    } else {
      image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 25);
    }

    if (image != null) {
      setState(() {
        selectedFour = File(image.path);
        base64ImageFour = base64Encode(selectedFour!.readAsBytesSync());

        print('Selected image $selectedFour');
        // won't have any error now
      });
    }
  }

  void bottomSheetFour() {
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
                  chooseImageFour("camera");
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
                  chooseImageFour("Gallery");
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

  Future<void> chooseImageFive(type) async {
    Navigator.pop(context);
    // ignore: prefer_typing_uninitialized_variables
    if (type == "camera") {
      image = await ImagePicker().pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker().pickImage(source: ImageSource.gallery);
    }

    if (image != null) {
      setState(() {
        selectedFive = File(image.path);
        base64ImageFive = base64Encode(selectedFive!.readAsBytesSync());

        print('Selected image $selectedFive');
        // won't have any error now
      });
    }
  }

  void bottomSheetFive() {
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
                  chooseImageFive("camera");
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
                  chooseImageFive("Gallery");
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

  Future<void> pickVideo(type) async {
    Navigator.pop(context);
    if (type == "camera") {
      videos = await ImagePicker().pickVideo(
        source: ImageSource.camera,
      );
    } else {
      videos = await ImagePicker().pickVideo(
        source: ImageSource.gallery,
      );
    }

    if (videos != null) {
      setState(() {
        selectedVideo = File(videos.path);
        base64ImageSix = base64Encode(selectedVideo!.readAsBytesSync());

        // print('Selected image $selectedFive');
        // won't have any error now
      });
    }
  }

  void bottomSheetVideo() {
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
                  // chooseImageFive("camera");
                  pickVideo("camera");
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
                      // "Image From Camera",
                      "Video From Camera",
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
                  // chooseImageFive("Gallery");
                  pickVideo("Gallery");
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
                      // "Image From Gallery",
                      "Video From Gallery",
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

  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    print('On map created');
    _markers.clear();
    setState(() {
      final marker = Marker(
        markerId: MarkerId('123'),
        position: LatLng(widget.latitude, widget.longitude),
        draggable: true,
        onTap: () {
          print("Clicked on marker");
        },
      );
      _markers['name'] = marker;
    });
  }

  void updateLocation() async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(widget.latitude, widget.longitude);

    var city = placemarks[0].locality;
    var state = placemarks[0].administrativeArea;
    var country = placemarks[0].country;

    setState(() {
      widget.address = '$city, $state, $country';
    });

    print('Updated address ${widget.address}');
  }

  String defaultCondition = '';

  final List conditions = [
    {'id': '1', 'item': 'Excellent'},
    {'id': '2', 'item': 'Fair'},
    {'id': '3', 'item': 'Good'},
  ];

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AllInProvider>(context, listen: false);
    // final argument = ModalRoute.of(context)!.settings.arguments as Map;
    print('Build');
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
              child: Container(
                margin: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          top: 10,
                          right: 20,
                        ),
                        child: Wrap(
                          children: [
                            InkWell(
                              onTap: () {
                                bottomSheetOne();
                              },
                              child: Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width / 3.6,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Container(
                                        height: 80,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4.5,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(.5),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: selectedOne != null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.file(
                                                    selectedOne!,
                                                    width: double.infinity,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                              : Image.asset(
                                                  'assets/images/upload_image.png',
                                                  color: Color(0xFFF903E3)
                                                      .withAlpha(200),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      5,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                    ),
                                    selectedOne != null
                                        ? InkWell(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: Text('Delete Image'),
                                                    content: Text(
                                                        'Are you sure you want to delete image?'),
                                                    actions: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 15,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                horizontal: 10,
                                                                vertical: 8,
                                                              ),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Color(
                                                                    0xFFF903E3),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            18),
                                                              ),
                                                              child: Text(
                                                                  'Delete'),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Container(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 8,
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                    color: Color(
                                                                        0xFFF903E3),
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              18),
                                                                ),
                                                                child: Text(
                                                                  'Cancel',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color(
                                                                        0xFFF903E3),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: Icon(
                                              Icons.cancel_outlined,
                                              color: Colors.red,
                                              size: 20,
                                            ),
                                          )
                                        : SizedBox()
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                bottomSheetTwo();
                              },
                              child: Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width / 3.6,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Container(
                                        height: 80,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4.5,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(.5),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: selectedTwo != null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.file(
                                                    selectedTwo!,
                                                    width: double.infinity,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                              : Image.asset(
                                                  'assets/images/upload_image.png',
                                                  color: Color(0xFFF903E3)
                                                      .withAlpha(200),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      5,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                    ),
                                    selectedTwo != null
                                        ? Icon(
                                            Icons.cancel_outlined,
                                            color: Colors.red,
                                            size: 20,
                                          )
                                        : SizedBox()
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                bottomSheetThree();
                              },
                              child: Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width / 3.6,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Container(
                                        height: 80,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4.5,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(.5),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: selectedThree != null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.file(
                                                    selectedThree!,
                                                    width: double.infinity,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                              : Image.asset(
                                                  'assets/images/upload_image.png',
                                                  color: Color(0xFFF903E3)
                                                      .withAlpha(200),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      5,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                    ),
                                    selectedThree != null
                                        ? Icon(
                                            Icons.cancel_outlined,
                                            color: Colors.red,
                                            size: 20,
                                          )
                                        : SizedBox()
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                bottomSheetFour();
                              },
                              child: Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width / 3.6,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Container(
                                        height: 80,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4.5,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(.5),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: selectedFour != null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.file(
                                                    selectedFour!,
                                                    width: double.infinity,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                              : Image.asset(
                                                  'assets/images/upload_image.png',
                                                  color: Color(0xFFF903E3)
                                                      .withAlpha(200),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      5,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                    ),
                                    selectedFour != null
                                        ? Icon(
                                            Icons.cancel_outlined,
                                            color: Colors.red,
                                            size: 20,
                                          )
                                        : SizedBox()
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                bottomSheetFive();
                              },
                              child: Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width / 3.6,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Container(
                                        height: 80,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4.5,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(.5),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: selectedFive != null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.file(
                                                    selectedFive!,
                                                    width: double.infinity,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                              : Image.asset(
                                                  'assets/images/upload_image.png',
                                                  color: Color(0xFFF903E3)
                                                      .withAlpha(200),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      5,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                    ),
                                    selectedFive != null
                                        ? Icon(
                                            Icons.cancel_outlined,
                                            color: Colors.red,
                                            size: 20,
                                          )
                                        : SizedBox()
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                bottomSheetVideo();
                              },
                              child: Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width / 3.6,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Container(
                                        height: 80,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4.5,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(.5),
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: selectedVideo != null
                                              ? Image.asset(
                                                  'assets/images/picked_video.jpg',
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      10,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.asset(
                                                  'assets/images/up.png',
                                                  color: Color(0xFFF903E3)
                                                      .withAlpha(200),
                                                ),
                                        ),
                                      ),
                                    ),
                                    selectedVideo != null
                                        ? Icon(
                                            Icons.cancel_outlined,
                                            color: Colors.red,
                                            size: 20,
                                          )
                                        : SizedBox()
                                  ],
                                ),
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(top: 10),
                            //   child: Container(
                            //     height: 80,
                            //     width: MediaQuery.of(context).size.width / 4.5,
                            //     decoration: BoxDecoration(
                            //       color: Colors.grey.withOpacity(.5),
                            //       borderRadius: BorderRadius.circular(10),
                            //     ),
                            //     child: Image.asset(
                            //       'assets/images/upload_image.png',
                            //       color: Color(0xFFF903E3).withAlpha(200),
                            //       width: MediaQuery.of(context).size.width / 5,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        width: double.infinity,
                        height: 250,
                        child: GoogleMap(
                          onMapCreated: _onMapCreated,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                              widget.latitude,
                              widget.longitude,
                            ),
                            zoom: 10,
                          ),
                          onTap: (argument) {
                            print('1213 $argument');
                            setState(() {
                              widget.latitude = argument.latitude;
                              widget.longitude = argument.longitude;
                            });
                            updateLocation();

                            print(
                                'Latitude ${widget.latitude} & Longitude ${widget.longitude}');
                            print('Address ${widget.address}');
                          },
                          markers: _markers.values.toSet(),
                          myLocationButtonEnabled: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          left: 10,
                          right: 10,
                        ),
                        child: Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  provider.getLongitudeLatitude(context);
                                  setState(() {
                                    userLocation =
                                        _markers.values.toSet().toString();
                                  });
                                },
                                child: Container(
                                  height: 57,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: appCommonColor,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        widget.address,
                                        // style: userLocation == 'Location'
                                        //     ? AddAddressPageTheme
                                        //         .textFieldsLabel
                                        //     :
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Color(0xFFF903E3),
                                  ),
                                ),
                                child: DropdownButton<String>(
                                  underline: SizedBox(),
                                  value: defaultCondition,
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Color(0xFFF903E3),
                                  ),
                                  isExpanded: true,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text(
                                        'Condition',
                                        style:
                                            AddAddressPageTheme.textFieldsLabel,
                                      ),
                                      value: '',
                                    ),
                                    ...provider.itemConditions
                                        .map<DropdownMenuItem<String>>((e) {
                                      return DropdownMenuItem(
                                        child: Text(
                                          e['valueChildData'],
                                        ),
                                        value: e['valueChildId'],
                                      );
                                    }).toList(),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      defaultCondition = value!;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text("Weight (Lbs) * "),
                              Row(
                                children: [
                                  Text("Min: 0"),
                                  Expanded(
                                    child: Slider(
                                      value: _currentSliderValue,
                                      max: provider.max,
                                      divisions: 100,
                                      label: _currentSliderValue
                                          .round()
                                          .toString(),
                                      onChanged: (double value) {
                                        print(_currentSliderValue);
                                        setState(
                                          () {
                                            _currentSliderValue = value;
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  Text("Max: 30"),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                // initialValue: provider.userProfileData['name'],
                                // onSaved: (newValue) {
                                //   provider.userProfileData['name'] = newValue;
                                // },
                                controller: title,
                                style: TextStyle(color: Colors.black),
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                  border: EditProfileTextFormFieldsBorderTheme
                                      .border,
                                  focusedBorder:
                                      EditProfileTextFormFieldsBorderTheme
                                          .focusBorder,
                                  enabledBorder:
                                      EditProfileTextFormFieldsBorderTheme
                                          .enableBorder,
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: appCommonColor),
                                  ),
                                  label: Text('Title'),
                                  labelStyle:
                                      AddAddressPageTheme.textFieldsLabel,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter title';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                // initialValue: provider.userProfileData['name'],
                                // onSaved: (newValue) {
                                //   provider.userProfileData['name'] = newValue;
                                // },
                                controller: discription,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  border: EditProfileTextFormFieldsBorderTheme
                                      .border,
                                  focusedBorder:
                                      EditProfileTextFormFieldsBorderTheme
                                          .focusBorder,
                                  enabledBorder:
                                      EditProfileTextFormFieldsBorderTheme
                                          .enableBorder,
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: appCommonColor),
                                  ),
                                  label: Text('Description'),
                                  labelStyle:
                                      AddAddressPageTheme.textFieldsLabel,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter discription';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                // initialValue: provider.userProfileData['name'],
                                // onSaved: (newValue) {
                                //   provider.userProfileData['name'] = newValue;
                                // },
                                controller: price,
                                keyboardType: TextInputType.number,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  border: EditProfileTextFormFieldsBorderTheme
                                      .border,
                                  focusedBorder:
                                      EditProfileTextFormFieldsBorderTheme
                                          .focusBorder,
                                  enabledBorder:
                                      EditProfileTextFormFieldsBorderTheme
                                          .enableBorder,
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: appCommonColor),
                                  ),
                                  label: Text('Price'),
                                  labelStyle:
                                      AddAddressPageTheme.textFieldsLabel,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter prize';
                                  }
                                  return null;
                                },
                              ),
                              // InkWell(
                              //   onTap: () {
                              //     provider.getLongitudeLatitude(context);
                              //     setState(() {
                              //       userLocation = provider.address;
                              //     });
                              //   },
                              //   child: TextFormField(
                              //     enabled: false,
                              //     // initialValue: provider.userProfileData['name'],
                              //     onSaved: (newValue) {
                              //       // provider.userProfileData['name'] = newValue;
                              //     },
                              //     style: TextStyle(color: Colors.black),
                              //     keyboardType: TextInputType.name,
                              //     decoration: InputDecoration(
                              //       border: EditProfileTextFormFieldsBorderTheme
                              //           .border,
                              //       focusedBorder:
                              //           EditProfileTextFormFieldsBorderTheme
                              //               .focusBorder,
                              //       enabledBorder:
                              //           EditProfileTextFormFieldsBorderTheme
                              //               .enableBorder,
                              //       // errorBorder: OutlineInputBorder(
                              //       //   borderRadius: BorderRadius.circular(10),
                              //       //   borderSide:
                              //       //       BorderSide(color: appCommonColor),
                              //       // ),
                              //       label: Text(userLocation),
                              //       labelStyle: userLocation == 'Location'
                              //           ? AddAddressPageTheme.textFieldsLabel
                              //           : TextStyle(color: Colors.black),
                              //     ),
                              //     validator: (value) {
                              //       if (value == null || value.isEmpty) {
                              //         return 'Please enter your location';
                              //       }
                              //       return null;
                              //     },
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if (formKey.currentState!.validate()) {
                  List imagesAndVideoData = [
                    {"value": selectedOne != null ? selectedOne!.path : ""},
                    {"value": selectedTwo != null ? selectedTwo!.path : ""},
                    {"value": selectedThree != null ? selectedThree!.path : ""},
                    {"value": selectedFour != null ? selectedFour!.path : ""},
                    {"value": selectedFive != null ? selectedFive!.path : ""},
                    {"value": selectedVideo != null ? selectedVideo!.path : ""}
                  ];
                  List lengthOfImagesAndVideo = [];
                  for (int i = 0; i < imagesAndVideoData.length; i++) {
                    if (imagesAndVideoData[i]['value'] != "") {
                      lengthOfImagesAndVideo.add(null);
                    }
                  }
                  print("Null $lengthOfImagesAndVideo");

                  var sliderValue = _currentSliderValue.round();

                  Map addProductRequiredData = {
                    'operations':
                        '{"operationName":"updateProduct","variables":{"data":{"language":[{"langCode":"en","title":"${title.text}","description":"${discription.text}"}],"categoryFields":[{"fieldId":"${provider.conditionID}","fieldChild":"$defaultCondition"},{"fieldId":"${provider.rangeSliderID}","rangeValue":"$sliderValue"}],"isFree":false,"categoryId":${widget.categoryID},"rate":${price.text},"images":$lengthOfImagesAndVideo,"deleteImages":[],"location":{"city":"${widget.city}","state":"${widget.state}","country":"${widget.country}","lat_lon":[${widget.latitude},${widget.longitude}]},"currencyCode":"USD","userId":${provider.userId},"userName":"kk","instantBuy":true,"shippingRate":0}},"query":"mutation updateProduct(\$id: Int, \$data: ProductData) {updateProduct(id: \$id, data: \$data) {id language {langCode title description}userName userProfile userId images    categoryId category viewers type likedUsers location {city state country lat_lon pincode      address}isFree createdAt updatedAt likedUsers sellingStatus status rate currencyCode    currencySymbol viewersCount frequency groupsId groupsName featured    featuredTransactionId    featuredExpiry featuredName featuredValidation featuredDescription categoryFieldsInfo{fieldId fieldParent fieldChild rangeValue}instantBuy shippingRate isUserVerified userVerifyMessage}}"}',
                  };
                  // Map addProductRequiredData = {
                  //   'operations':
                  //       '{"operationName":"updateProduct","variables":{"data":{"language":[{"langCode":"en","title":"${title.text}","description":"${discription.text}"}],"categoryFields":[{"fieldId":"1000","fieldChild":"$defaultCondition"}],"isFree":false,"categoryId":10004,"rate":1000,"images":[null,null,null],"deleteImages":[],"location":{"city":"Jaipur","state":"Rajasthan","country":"India","pincode":"302001","lat_lon":[26.9140607,75.80428549999999]},"currencyCode":"USD","userId":10002,"userName":"kk","instantBuy":true,"shippingRate":0}},"query":"mutation updateProduct(\$id: Int, \$data: ProductData) {\\n  updateProduct(id: \$id, data: \$data) {\\n    id\\n    language {\\n      langCode\\n      title\\n      description\\n    }\\n    userName\\n    userProfile\\n    userId\\n    images\\n    categoryId\\n    category\\n    viewers\\n    type\\n    likedUsers\\n    location {\\n      city\\n      state\\n      country\\n      lat_lon\\n      pincode\\n      address\\n    }\\n    isFree\\n    createdAt\\n    updatedAt\\n    likedUsers\\n    sellingStatus\\n    status\\n    rate\\n    currencyCode\\n    currencySymbol\\n    viewersCount\\n    frequency\\n    groupsId\\n    groupsName\\n    featured\\n    featuredTransactionId\\n    featuredExpiry\\n    featuredName\\n    featuredValidation\\n    featuredDescription\\n    categoryFieldsInfo {\\n      fieldId\\n      fieldParent\\n      fieldChild\\n      rangeValue\\n    }\\n    instantBuy\\n    shippingRate\\n    isUserVerified\\n    userVerifyMessage\\n  }\\n}\\n"}',
                  //   'map':
                  //       '{"0":["variables.data.images.0"],"1":["variables.data.images.1"],"2":["variables.data.images.2"]}'
                  // };

                  provider.updateItems(
                      context, imagesAndVideoData, addProductRequiredData);

                  // Map addItemsData = {
                  //   'title': title.text,
                  //   'discription': discription.text,
                  //   'price': price.text,
                  //   'location': widget.address,
                  //   'condition': defaultCondition,
                  //   'imageOne': base64ImageOne,
                  //   'imageTwo': base64ImageTwo,
                  //   'imageThree': base64ImageThree,
                  //   'imageFour': base64ImageFour,
                  //   'imageFive': base64ImageFive,
                  //   'imageSix': base64ImageSix,
                  // };
                  // print('Add items data $addItemsData');
                }
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF0A6DFE),
                      Color(0xFFF903E3),
                    ],
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Add Item',
                    style: GoogleFonts.firaSans(
                      color: Color(0xFFECECEC),
                      fontSize: 24,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
