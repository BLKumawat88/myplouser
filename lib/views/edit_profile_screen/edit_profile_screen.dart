import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:myplo/controller/all_in_controller.dart';
import 'package:myplo/theme/font_theme.dart';
import 'package:myplo/theme/text_form_fields_theme.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final textboxLabels = GoogleFonts.firaSans(
    color: Color(0xFF3C3C3C),
    fontSize: 18,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
  );

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
        print('selectedImage $selectedImage');
        base64Image = base64Encode(selectedImage!.readAsBytesSync());
        print('base64Image $base64Image');
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

  final formKey = GlobalKey<FormState>();

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 80,
                        child: ClipOval(
                          child: selectedImage != null
                              ? Image.file(
                                  selectedImage!,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                )
                              : Center(
                                  child: CircleAvatar(
                                    backgroundColor: Color(0xFFC4C4C4),
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                      '${provider.userProfileData['profileImage']}',
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      Positioned(
                        bottom: -10,
                        right: -10,
                        child: IconButton(
                          onPressed: () {
                            bottomSheet();
                          },
                          icon: Image.asset(
                            'assets/images/edit.png',
                            scale: 4,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            provider.userProfileData['userName'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.firaSans(
                              color: Color(0xFF5F5F5F),
                              fontSize: 22,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          FittedBox(
                            child: Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              'View and edit Profile',
                              style: GoogleFonts.firaSans(
                                color: Color(0xFF5F5F5F),
                                fontSize: 12,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(left: 90),
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
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Color(0xFFD9D9D9),
              thickness: 1,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Form(
                      key: formKey,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 25,
                          right: 25,
                          top: 40,
                          bottom: 40,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'My account',
                              style: GoogleFonts.firaSans(
                                color: Color(0xFF3C3C3C),
                                fontSize: 24,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Make Name:',
                              style: textboxLabels,
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            TextFormField(
                              initialValue:
                                  provider.userProfileData['userName'],
                              onSaved: (newValue) {
                                provider.userProfileData['userName'] = newValue;
                              },
                              style: TextStyle(color: Colors.black),
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                suffixIcon: Image.asset(
                                  'assets/images/edit_text.png',
                                  scale: 4,
                                ),
                                border:
                                    EditProfileTextFormFieldsBorderTheme.border,
                                focusedBorder:
                                    EditProfileTextFormFieldsBorderTheme
                                        .focusBorder,
                                enabledBorder:
                                    EditProfileTextFormFieldsBorderTheme
                                        .enableBorder,
                                fillColor: Color(0xFFEAEAEA),
                                filled: true,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Email:',
                              style: textboxLabels,
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            TextFormField(
                              initialValue: provider.userProfileData['email'],
                              onSaved: (newValue) {
                                provider.userProfileData['email'] = newValue;
                              },
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                suffixIcon: Image.asset(
                                  'assets/images/edit_text.png',
                                  scale: 4,
                                ),
                                border:
                                    EditProfileTextFormFieldsBorderTheme.border,
                                focusedBorder:
                                    EditProfileTextFormFieldsBorderTheme
                                        .focusBorder,
                                enabledBorder:
                                    EditProfileTextFormFieldsBorderTheme
                                        .enableBorder,
                                fillColor: Color(0xFFEAEAEA),
                                filled: true,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Phone:',
                              style: textboxLabels,
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            TextFormField(
                              initialValue:
                                  provider.userProfileData['phoneNumber'],
                              onSaved: (newValue) {
                                String result =
                                    newValue!.replaceAll(RegExp('-'), '');

                                provider.userProfileData['phoneNumber'] =
                                    result;

                                print('New Phone $result');
                              },
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                MaskTextInputFormatter(
                                  mask: "###-###-####",
                                  filter: {
                                    "#": RegExp('[0-9]'),
                                  },
                                ),
                              ],
                              decoration: InputDecoration(
                                suffixIcon: Image.asset(
                                  'assets/images/edit_text.png',
                                  scale: 4,
                                ),
                                border:
                                    EditProfileTextFormFieldsBorderTheme.border,
                                focusedBorder:
                                    EditProfileTextFormFieldsBorderTheme
                                        .focusBorder,
                                enabledBorder:
                                    EditProfileTextFormFieldsBorderTheme
                                        .enableBorder,
                                fillColor: Color(0xFFEAEAEA),
                                filled: true,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your phone number';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Delivery Address:',
                              style: textboxLabels,
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            TextFormField(
                              maxLines: 2,
                              initialValue:
                                  provider.userProfileData['delivery_address'],
                              onSaved: (newValue) {
                                provider.userProfileData['delivery_address'] =
                                    newValue;
                              },
                              keyboardType: TextInputType.streetAddress,
                              decoration: InputDecoration(
                                suffixIcon: Image.asset(
                                  'assets/images/edit_text.png',
                                  scale: 4,
                                ),
                                border:
                                    EditProfileTextFormFieldsBorderTheme.border,
                                focusedBorder:
                                    EditProfileTextFormFieldsBorderTheme
                                        .focusBorder,
                                enabledBorder:
                                    EditProfileTextFormFieldsBorderTheme
                                        .enableBorder,
                                fillColor: Color(0xFFEAEAEA),
                                filled: true,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your delivery address';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Pickup Address:',
                              style: textboxLabels,
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            TextFormField(
                              maxLines: 2,
                              initialValue:
                                  provider.userProfileData['pickup_address'],
                              onSaved: (newValue) {
                                provider.userProfileData['pickup_address'] =
                                    newValue;
                              },
                              keyboardType: TextInputType.streetAddress,
                              decoration: InputDecoration(
                                suffixIcon: Image.asset(
                                  'assets/images/edit_text.png',
                                  scale: 4,
                                ),
                                border:
                                    EditProfileTextFormFieldsBorderTheme.border,
                                focusedBorder:
                                    EditProfileTextFormFieldsBorderTheme
                                        .focusBorder,
                                enabledBorder:
                                    EditProfileTextFormFieldsBorderTheme
                                        .enableBorder,
                                fillColor: Color(0xFFEAEAEA),
                                filled: true,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your pickup address';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                formKey.currentState!.save();
                if (formKey.currentState!.validate()) {
                  provider.editUser(context);
                  print('User update profile name ${provider.userProfileData}');
                  // provider.showSnackbar(
                  //   context,
                  //   title: 'Profile successfully updated',
                  // );
                }
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Update Profile',
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
            )
          ],
        ),
      ),
    );
  }
}
