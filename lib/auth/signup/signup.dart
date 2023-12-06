import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myplo/controller/all_in_controller.dart';
import 'package:myplo/theme/common_theme.dart';
import 'package:myplo/theme/font_theme.dart';
import 'package:myplo/theme/text_form_fields_theme.dart';
import 'package:provider/provider.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late AllInProvider allInProvider;

  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  RegExp emailVerify = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  Signup() {
    if (formKey.currentState!.validate()) {
      Map userSignupData = {
        'userName': name.text,
        'email': email.text,
        'password': password.text,
      };
      allInProvider.signup(userSignupData, context);
      // print('User signup data $userSignupData');
      // Navigator.pushNamedAndRemoveUntil(
      //   context,
      //   '/pin_screen',
      //   (route) => false,
      // );
    } else {
      print('Fill all the required data.');
    }
  }

  @override
  Widget build(BuildContext context) {
    allInProvider = Provider.of<AllInProvider>(context, listen: false);
    email.text = allInProvider.email;
    name.text = allInProvider.name;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Image.asset(
                'assets/images/app_logo.png',
                scale: 6,
              ),
              Text(
                textAlign: TextAlign.center,
                'The Genius Way to Buy & Sell Party Leftovers',
                style: appTagline,
              ),
              SizedBox(
                height: 30,
              ),
              Form(
                key: formKey,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Signup',
                        style: CommonFontTheme.authHeadTitle,
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        'Signup with one of the following options',
                        style: CommonFontTheme.authHeadSubtitle,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: name,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFDEDEDE),
                          border: TextFormFieldsBorderTheme.focusedBorder,
                          hintText: 'Name',
                          hintStyle: CommonFontTheme.authTextFormFields,
                          focusedBorder:
                              TextFormFieldsBorderTheme.focusedBorder,
                          enabledBorder:
                              TextFormFieldsBorderTheme.enabledBorder,
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
                        controller: email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFDEDEDE),
                          border: TextFormFieldsBorderTheme.focusedBorder,
                          hintText: 'Email',
                          hintStyle: CommonFontTheme.authTextFormFields,
                          focusedBorder:
                              TextFormFieldsBorderTheme.focusedBorder,
                          enabledBorder:
                              TextFormFieldsBorderTheme.enabledBorder,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          } else if (!emailVerify.hasMatch(email.text)) {
                            return 'Please enter email in correct format';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      TextFormField(
                        controller: password,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFDEDEDE),
                          border: TextFormFieldsBorderTheme.focusedBorder,
                          hintText: 'Password',
                          hintStyle: CommonFontTheme.authTextFormFields,
                          focusedBorder:
                              TextFormFieldsBorderTheme.focusedBorder,
                          enabledBorder:
                              TextFormFieldsBorderTheme.enabledBorder,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      TextFormField(
                        controller: confirmPassword,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFDEDEDE),
                          border: TextFormFieldsBorderTheme.focusedBorder,
                          hintText: 'Confirm Password',
                          hintStyle: CommonFontTheme.authTextFormFields,
                          focusedBorder:
                              TextFormFieldsBorderTheme.focusedBorder,
                          enabledBorder:
                              TextFormFieldsBorderTheme.enabledBorder,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          } else if (password.text != confirmPassword.text) {
                            return 'Password did not match';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      AppCommonButton(
                        actionMethod: Signup,
                        title: 'Create account',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              text: 'Already have an account? ',
                              style: GoogleFonts.archivo(
                                color: Color(0xFF828282),
                                fontSize: 18,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Login',
                                  style: CommonFontTheme.authTextButtons,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width / 3,
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
                            width: MediaQuery.of(context).size.width / 3,
                            color: Color(0xFF6F6F6F),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: CommonTheme.btnHeight,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFFDEDEDE),
                          borderRadius:
                              BorderRadius.circular(CommonTheme.borderRadius),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/google.png',
                              width: 26,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              'Continue With Google',
                              style: CommonFontTheme.onlineButtons,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: CommonTheme.btnHeight,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFFDEDEDE),
                          borderRadius:
                              BorderRadius.circular(CommonTheme.borderRadius),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/facebook.png',
                              width: 26,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              'Continue With Facebook',
                              style: CommonFontTheme.onlineButtons,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
