import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:myplo/controller/all_in_controller.dart';
import 'package:myplo/theme/common_theme.dart';
import 'package:myplo/theme/font_theme.dart';
import 'package:myplo/theme/text_form_fields_theme.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late AllInProvider allInProvider;
  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  RegExp emailVerify = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  login() {
    if (formKey.currentState!.validate()) {
      Map userLogindata = {
        'email': email.text,
        'password': password.text,
      };
      allInProvider.login(userLogindata, context);
    } else {
      print('Fill all the required data.');
    }
  }

  loginWithGoogle() async {
    allInProvider = Provider.of<AllInProvider>(context, listen: false);
    GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      var result = await _googleSignIn.signIn();
      if (result == null) {
        return;
      }
      final userData = await result.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: userData.accessToken, idToken: userData.idToken);
      var finalResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (finalResult.credential != null) {
        allInProvider.email = result.email;
        allInProvider.name = result.displayName!;

        Navigator.pushNamed(context, '/signup_screen');
        logoutgoogleFirebase();
      }
    } catch (error) {
      print("$error Error");
    }
  }

  Future<void> logoutgoogleFirebase() async {
    await GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
  }

  logout() async {
    await GoogleSignIn().disconnect();
  }

  bool isPasswordShowSecure = true;
  @override
  Widget build(BuildContext context) {
    allInProvider = Provider.of<AllInProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 20,
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
                        'Login',
                        // style: LoginPageTheme.login,
                        style: CommonFontTheme.authHeadTitle,
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        'Login with one of the following options',
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
                      TextFormField(
                        controller: password,
                        obscureText: isPasswordShowSecure ? true : false,
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                isPasswordShowSecure = !isPasswordShowSecure;
                              });
                            },
                            child: Icon(
                              isPasswordShowSecure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
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
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/forgot_password_screen',
                            );
                          },
                          child: Text(
                            'Forgot Password?',
                            style: GoogleFonts.archivo(
                              color: Color(0xFF6F6F6F),
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      AppCommonButton(
                        actionMethod: login,
                        title: 'Log in',
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/signup_screen');
                        },
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              text: 'Don\'t have an account? ',
                              style: GoogleFonts.archivo(
                                color: Color(0xFF828282),
                                fontSize: 18,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Signup',
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
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          loginWithGoogle();
                        },
                        child: Container(
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
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
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
