import 'package:flutter/material.dart';
import 'package:myplo/controller/all_in_controller.dart';
import 'package:myplo/theme/common_theme.dart';
import 'package:myplo/theme/font_theme.dart';
import 'package:myplo/theme/text_form_fields_theme.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late AllInProvider allInProvider;
  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();

  RegExp emailVerify = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  void forgotPassword() {
    if (formKey.currentState!.validate()) {
      Map userForgotPassword = {'email': email.text};
      // print('User forgot password recovery email $forgotPassword');
      allInProvider.forgotPassword(userForgotPassword, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    allInProvider = Provider.of<AllInProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/app_logo.png',
                          scale: 8,
                        ),
                        // Text(
                        //   textAlign: TextAlign.center,
                        //   'The Genius Way to Buy & Sell Party Leftover',
                        //   style: appTagline,
                        // ),
                      ],
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
            // SizedBox(
            //   height: 20,
            // ),
            // Image.asset(
            //   'assets/images/app_logo.png',
            //   scale: 6,
            // ),
            // Text(
            //   textAlign: TextAlign.center,
            //   'The Genius Way to Buy & Sell Party Leftover',
            //   style: appTagline,
            // ),
            // SizedBox(
            //   height: 30,
            // ),
            Form(
              key: formKey,
              child: Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Forgot Password',
                          style: CommonFontTheme.authHeadTitle,
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          'Enter your Email for the recovery of your password',
                          style: CommonFontTheme.authHeadSubtitle,
                        ),
                        SizedBox(
                          height: 30,
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
                        AppCommonButton(
                          actionMethod: forgotPassword,
                          title: 'Continue',
                        ),
                      ],
                    ),
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
