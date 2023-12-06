import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myplo/theme/font_theme.dart';
import 'package:myplo/theme/text_form_fields_theme.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  Flexible(
                    child: FittedBox(
                      child: Text(
                        maxLines: 1,
                        'Change Password',
                        style: GoogleFonts.firaSans(
                          color: Color(0xFF3C3C3C),
                          fontSize: 25,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Color(0xFFD9D9D9),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          controller: oldPassword,
                          decoration: InputDecoration(
                            border:
                                ChangePasswordTextFormFieldsBorderTheme.border,
                            focusedBorder:
                                ChangePasswordTextFormFieldsBorderTheme
                                    .focusBorder,
                            enabledBorder:
                                ChangePasswordTextFormFieldsBorderTheme
                                    .enableBorder,
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: appCommonColor),
                            ),
                            labelText: 'Old Password',
                            labelStyle: GoogleFonts.firaSans(
                              color: appCommonColor,
                              fontSize: 12,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your old password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          controller: newPassword,
                          decoration: InputDecoration(
                            border:
                                ChangePasswordTextFormFieldsBorderTheme.border,
                            focusedBorder:
                                ChangePasswordTextFormFieldsBorderTheme
                                    .focusBorder,
                            enabledBorder:
                                ChangePasswordTextFormFieldsBorderTheme
                                    .enableBorder,
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: appCommonColor),
                            ),
                            labelText: 'New Password',
                            labelStyle: GoogleFonts.firaSans(
                              color: appCommonColor,
                              fontSize: 12,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your new password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          controller: confirmPassword,
                          decoration: InputDecoration(
                            border:
                                ChangePasswordTextFormFieldsBorderTheme.border,
                            focusedBorder:
                                ChangePasswordTextFormFieldsBorderTheme
                                    .focusBorder,
                            enabledBorder:
                                ChangePasswordTextFormFieldsBorderTheme
                                    .enableBorder,
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: appCommonColor),
                            ),
                            labelText: 'Confirm Password',
                            labelStyle: GoogleFonts.firaSans(
                              color: appCommonColor,
                              fontSize: 12,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your confirm password';
                            } else if (newPassword.text !=
                                confirmPassword.text) {
                              return 'Password did not match';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                if (formKey.currentState!.validate()) {
                  Map userNewPassword = {
                    'old_password': oldPassword.text,
                    'new_password': newPassword.text,
                    'confirm_password': confirmPassword.text,
                  };
                  print('User new password :- $userNewPassword');
                }
              },
              child: Container(
                height: 55,
                width: MediaQuery.of(context).size.width,
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
                    'Change Password',
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
