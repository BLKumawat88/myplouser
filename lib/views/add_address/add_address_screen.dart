import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:myplo/controller/all_in_controller.dart';
import 'package:myplo/theme/font_theme.dart';
import 'package:myplo/theme/text_form_fields_theme.dart';
import 'package:provider/provider.dart';

class AddAddressScreen extends StatefulWidget {
  bool addressType;

  AddAddressScreen({super.key, required this.addressType});

  @override
  State<AddAddressScreen> createState() => AddAddressScreenState();
}

class AddAddressScreenState extends State<AddAddressScreen> {
  late AllInProvider provider;
  final formKey = GlobalKey<FormState>();

  double? latitude;
  double? longitude;
  String? city;
  String? state;
  String? postcode;
  String? add;
  String address = 'Use My Current Location';
  String selectCountry = '';
  String? country;

  void getLongitudeLatitude() async {
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
                      valueColor: new AlwaysStoppedAnimation<Color>(
                        appCommonColor,
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

    latitude = result.latitude;
    print('Latitude is $latitude');

    longitude = result.longitude;
    print('Longitude is $longitude');

    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude!, longitude!);
    log('Placemarks ${placemarks.length}');
    log('Placemarks $placemarks');

    add = placemarks[0].street;
    city = placemarks[0].locality;
    state = placemarks[0].administrativeArea;
    country = placemarks[0].country;
    postcode = placemarks[0].postalCode;

    setState(() {
      address = '$add $city, $state, $country, $postcode';
      provider.addAddress['address'] = add;
      provider.addAddress['city'] = city;
      provider.addAddress['state'] = state;
      provider.addAddress['selectCountry'] = country;
      provider.addAddress['zipCode'] = postcode;
      Navigator.pop(context);
    });
  }

  String defaultValueState = "";
  List dropDownListStateData = [
    {"state": "Rajasthan", "value": "Rajasthan"},
    {"state": "Gujrat", "value": "Gujrat"},
    {"state": "Madhya Pradesh", "value": "Madhya Pradesh"},
    {"state": "Uttar Pradesh", "value": "Uttar Pradesh"},
    {"state": "Maharashtra", "value": "Maharashtra"},
    {"state": "Sikkim", "value": "Sikkim"},
    {"state": "California", "value": "California"}
  ];

  bool checkboxUnderstand = false;
  bool checkboxTerm = false;

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  InkWell(
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
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    widget.addressType == true
                        ? 'Update Address'
                        : 'Add Address',
                    style: GoogleFonts.firaSans(
                      color: Color(0xFF3C3C3C),
                      fontSize: 25,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Color(0xFFD9D9D9),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          InkWell(
                            onTap: () {
                              getLongitudeLatitude();
                            },
                            child: Container(
                              height: 57,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Color(0xFFEEF2F3),
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
                                    address,
                                    style: address == 'Use My Current Location'
                                        ? AddAddressPageTheme.textFieldsLabel
                                        : AddAddressPageTheme.dropdownLabel,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 1,
                                width: MediaQuery.of(context).size.width / 2.8,
                                color: Color(0xFF6F6F6F),
                              ),
                              Text(
                                ' Or ',
                                style: TextStyle(
                                  color: Color(0xFF828282),
                                ),
                              ),
                              Container(
                                height: 1,
                                width: MediaQuery.of(context).size.width / 2.8,
                                color: Color(0xFF6F6F6F),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          InputDecorator(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFEEF2F3),
                              contentPadding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 17,
                                bottom: 17,
                              ),
                              focusedBorder:
                                  AddressTextFormFieldsBorderTheme.focusBorder,
                              enabledBorder:
                                  AddressTextFormFieldsBorderTheme.enableBorder,
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: appCommonColor),
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                icon: Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  color: Color(0xFFF903E3),
                                ),
                                isDense: true,
                                value: provider.addAddress['selectCountry'],
                                isExpanded: true,
                                menuMaxHeight: 350,
                                items: [
                                  DropdownMenuItem(
                                    child: Text(
                                      'Select Country',
                                      // style:
                                      //     AddAddressPageTheme.dropdownLabel,
                                      style:
                                          AddAddressPageTheme.textFieldsLabel,
                                    ),
                                    value: "",
                                  ),
                                  ...provider.getAllCountries
                                      .map<DropdownMenuItem<String>>((data) {
                                    return DropdownMenuItem(
                                      child: Text(
                                        '${data['longName']}',
                                        style:
                                            AddAddressPageTheme.dropdownLabel,
                                      ),
                                      value: data['longName'],
                                    );
                                  }).toList(),
                                ],
                                onChanged: (value) {
                                  print("selected Value $value");
                                  setState(() {
                                    country = value!;
                                    provider.addAddress['selectCountry'] =
                                        country.toString();
                                    print(country);
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          TextFormField(
                            initialValue: provider.addAddress['name'],
                            onSaved: (newValue) {
                              provider.addAddress['name'] = newValue;
                            },
                            style: AddAddressPageTheme.dropdownLabel,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              labelStyle: AddAddressPageTheme.textFieldsLabel,
                              border: AddressTextFormFieldsBorderTheme.border,
                              focusedBorder:
                                  AddressTextFormFieldsBorderTheme.focusBorder,
                              enabledBorder:
                                  AddressTextFormFieldsBorderTheme.enableBorder,
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: appCommonColor),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          TextFormField(
                            initialValue: provider.addAddress['mobileNumber'],
                            onSaved: (newValue) {
                              provider.addAddress['mobileNumber'] = newValue;
                            },
                            style: AddAddressPageTheme.dropdownLabel,
                            // inputFormatters: [
                            //   MaskTextInputFormatter(
                            //     mask: "###-###-####",
                            //     filter: {
                            //       "#": RegExp(r'[0-9]'),
                            //     },
                            //   ),
                            // ],
                            decoration: InputDecoration(
                              labelText: 'Mobile Number',
                              labelStyle: AddAddressPageTheme.textFieldsLabel,
                              border: AddressTextFormFieldsBorderTheme.border,
                              focusedBorder:
                                  AddressTextFormFieldsBorderTheme.focusBorder,
                              enabledBorder:
                                  AddressTextFormFieldsBorderTheme.enableBorder,
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: appCommonColor),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter mobile number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          TextFormField(
                            key: Key(provider.addAddress['address'].toString()),
                            initialValue: provider.addAddress['address'],
                            onSaved: (newValue) {
                              provider.addAddress['address'] = newValue;
                            },
                            style: AddAddressPageTheme.dropdownLabel,
                            decoration: InputDecoration(
                              labelText: 'Address',
                              labelStyle: AddAddressPageTheme.textFieldsLabel,
                              border: AddressTextFormFieldsBorderTheme.border,
                              focusedBorder:
                                  AddressTextFormFieldsBorderTheme.focusBorder,
                              enabledBorder:
                                  AddressTextFormFieldsBorderTheme.enableBorder,
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: appCommonColor),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter address';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          // TextFormField(
                          //   controller: area,
                          //   decoration: InputDecoration(
                          //     labelText: 'Area, Street, Sector, Village',
                          //     labelStyle: AddAddressPageTheme.textFieldsLabel,
                          //     border: AddressTextFormFieldsBorderTheme.border,
                          //     focusedBorder:
                          //         AddressTextFormFieldsBorderTheme.focusBorder,
                          //     enabledBorder:
                          //         AddressTextFormFieldsBorderTheme.enableBorder,
                          //     errorBorder: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(10),
                          //       borderSide: BorderSide(color: appCommonColor),
                          //     ),
                          //   ),
                          //   validator: (value) {
                          //     if (value == null || value.isEmpty) {
                          //       return 'Please enter area or street';
                          //     }
                          //     return null;
                          //   },
                          // ),
                          // SizedBox(
                          //   height: 18,
                          // ),
                          // TextFormField(
                          //   controller: landmark,
                          //   decoration: InputDecoration(
                          //     labelText: 'Landmark',
                          //     labelStyle: AddAddressPageTheme.textFieldsLabel,
                          //     border: AddressTextFormFieldsBorderTheme.border,
                          //     focusedBorder:
                          //         AddressTextFormFieldsBorderTheme.focusBorder,
                          //     enabledBorder:
                          //         AddressTextFormFieldsBorderTheme.enableBorder,
                          //     errorBorder: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(10),
                          //       borderSide: BorderSide(color: appCommonColor),
                          //     ),
                          //   ),
                          //   validator: (value) {
                          //     if (value == null || value.isEmpty) {
                          //       return 'Please enter landmark';
                          //     }
                          //     return null;
                          //   },
                          // ),
                          // SizedBox(
                          //   height: 18,
                          // ),
                          Consumer<AllInProvider>(
                            builder: (context, value, child) {
                              return TextFormField(
                                key:
                                    Key(provider.addAddress['city'].toString()),
                                initialValue: provider.addAddress['city'],
                                onSaved: (newValue) {
                                  provider.addAddress['city'] = newValue;
                                },
                                style: AddAddressPageTheme.dropdownLabel,
                                decoration: InputDecoration(
                                  labelText: 'City',
                                  labelStyle:
                                      AddAddressPageTheme.textFieldsLabel,
                                  border:
                                      AddressTextFormFieldsBorderTheme.border,
                                  focusedBorder:
                                      AddressTextFormFieldsBorderTheme
                                          .focusBorder,
                                  enabledBorder:
                                      AddressTextFormFieldsBorderTheme
                                          .enableBorder,
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: appCommonColor),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter city';
                                  }
                                  return null;
                                },
                              );
                            },
                          ),

                          SizedBox(
                            height: 18,
                          ),
                          Text(
                            'State',
                            style: GoogleFonts.firaSans(
                              color: Color(0xFF3C3C3C),
                              fontSize: 12,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InputDecorator(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFEEF2F3),
                              contentPadding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 17,
                                bottom: 17,
                              ),
                              focusedBorder:
                                  AddressTextFormFieldsBorderTheme.focusBorder,
                              enabledBorder:
                                  AddressTextFormFieldsBorderTheme.enableBorder,
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: appCommonColor),
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                icon: Icon(
                                  Icons.keyboard_arrow_down_sharp,
                                  color: Color(0xFFF903E3),
                                ),
                                isDense: true,
                                value: provider.addAddress['state'],
                                isExpanded: true,
                                menuMaxHeight: 350,
                                items: [
                                  DropdownMenuItem(
                                    child: Text(
                                      "Select",
                                      style:
                                          AddAddressPageTheme.textFieldsLabel,
                                    ),
                                    value: "",
                                  ),
                                  ...dropDownListStateData
                                      .map<DropdownMenuItem<String>>((data) {
                                    return DropdownMenuItem(
                                      child: Text(
                                        '${data['state']}',
                                        style:
                                            AddAddressPageTheme.dropdownLabel,
                                      ),
                                      value: data['value'],
                                    );
                                  }).toList(),
                                ],
                                onChanged: (value) {
                                  print("selected Value $value");
                                  setState(() {
                                    state = value!;
                                    provider.addAddress['state'] =
                                        state.toString();
                                    print(state);
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          // Text('Address Type'),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          // InputDecorator(
                          //   decoration: InputDecoration(
                          //     filled: true,
                          //     fillColor: Color(0xFFEEF2F3),
                          //     contentPadding: const EdgeInsets.only(
                          //       left: 10,
                          //       right: 10,
                          //       top: 17,
                          //       bottom: 17,
                          //     ),
                          //     focusedBorder:
                          //         AddressTextFormFieldsBorderTheme.focusBorder,
                          //     enabledBorder:
                          //         AddressTextFormFieldsBorderTheme.enableBorder,
                          //     errorBorder: OutlineInputBorder(
                          //       borderRadius: BorderRadius.circular(10),
                          //       borderSide: BorderSide(color: appCommonColor),
                          //     ),
                          //   ),
                          //   child: DropdownButtonHideUnderline(
                          //     child: DropdownButton<String>(
                          //       icon: Icon(Icons.keyboard_arrow_down_sharp),
                          //       isDense: true,
                          //       value: defaultValueAddresstype,
                          //       isExpanded: true,
                          //       menuMaxHeight: 350,
                          //       items: [
                          //         DropdownMenuItem(
                          //           child: Text(
                          //             "Select an address type",
                          //             style: AddAddressPageTheme.dropdownLabel,
                          //           ),
                          //           value: "",
                          //         ),
                          //         ...dropDownListAddressData
                          //             .map<DropdownMenuItem<String>>((data) {
                          //           return DropdownMenuItem(
                          //             child: Text('${data['country']}'),
                          //             value: data['value'],
                          //           );
                          //         }).toList(),
                          //       ],
                          //       onChanged: (value) {
                          //         print("selected Value $value");
                          //         setState(() {
                          //           country = value!;
                          //           print(country);
                          //         });
                          //       },
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            height: 18,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                // fillColor: MaterialStateProperty.all(
                                //   Color(0xFFD9D9D9),
                                // ),
                                value: checkboxUnderstand,
                                onChanged: (value) {
                                  setState(() {
                                    checkboxUnderstand = value!;
                                    print(
                                      'Checkbox value 2 $checkboxUnderstand',
                                    );
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              Text('Make this my default address'),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                formKey.currentState!.save();
                if (formKey.currentState!.validate()) {
                  print('User address data ${provider.addAddress}');

                  // provider.updateShippingAddress(
                  //   context,
                  // );

                  if (widget.addressType) {
                    provider.updateShippingAddress(
                        context, "Address Updated Successfully");
                  } else {
                    provider.updateShippingAddress(
                        context, "Address Addedd Successfully");
                  }
                }
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.addressType == true
                        ? 'Update Address'
                        : 'Add Address',
                    style: GoogleFonts.firaSans(
                      color: Color(0xFFECECEC),
                      fontSize: 24,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF0A6DFE),
                      Color(0xFFF903E3),
                    ],
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
