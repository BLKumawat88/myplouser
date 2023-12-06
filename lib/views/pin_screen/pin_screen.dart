import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myplo/theme/common_theme.dart';
import 'package:myplo/theme/font_theme.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends State<PinScreen> {
  int selectedIndex = 0;
  String code = '';

  addDigit(int digit) {
    if (code.length > 3) {
      return;
    }
    setState(() {
      code = code + digit.toString();
      // print('Code is $code');
      selectedIndex = code.length;
    });
    if (code.length == 4) {
      print("Your pin is $code");
      // AllInController.updatePin(code);
      // Get.back();

    } else {
      print("Complete your pin set");
    }
  }

  backspace() {
    if (code.isEmpty) {
      return;
    }
    setState(() {
      code = code.substring(0, code.length - 1);
      selectedIndex = code.length;
    });
  }

  verifyOtp() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/location_screen',
      (route) => false,
    );
  }

  final formKey = GlobalKey<FormState>();
  TextEditingController one = TextEditingController();
  TextEditingController two = TextEditingController();
  TextEditingController three = TextEditingController();
  TextEditingController four = TextEditingController();

  OutlineInputBorder enableBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color: Color(0xFFFF5A5F),
      ),
    );
  }

  OutlineInputBorder focusBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color: Color(0xFFFF5A5F),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Image.asset(
                'assets/images/app_logo.png',
                scale: 6,
              ),
            ),
            Text(
              textAlign: TextAlign.center,
              'The Genius Way to Buy & Sell Party Leftovers',
              style: appTagline,
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                'Otp',
                style: CommonFontTheme.authHeadTitle,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                'We’ll send you a verification code on the phone number',
                style: CommonFontTheme.authHeadSubtitle,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Form(
              key: formKey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 76,
                      height: CommonTheme.btnHeight,
                      child: TextFormField(
                        controller: one,
                        obscureText: true,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Color(0xFFDEDEDE),
                          enabledBorder: enableBorder(),
                          focusedBorder: focusBorder(),
                        ),
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                      ),
                    ),
                    Container(
                      width: 76,
                      height: CommonTheme.btnHeight,
                      child: TextFormField(
                        controller: two,
                        obscureText: true,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Color(0xFFDEDEDE),
                          enabledBorder: enableBorder(),
                          focusedBorder: focusBorder(),
                        ),
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                          print(value);
                        },
                      ),
                    ),
                    Container(
                      width: 76,
                      height: CommonTheme.btnHeight,
                      child: TextFormField(
                        controller: three,
                        obscureText: true,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Color(0xFFDEDEDE),
                          enabledBorder: enableBorder(),
                          focusedBorder: focusBorder(),
                        ),
                        onChanged: (value) {
                          if (value.length == 1) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                      ),
                    ),
                    Container(
                      width: 76,
                      height: CommonTheme.btnHeight,
                      child: TextFormField(
                        controller: four,
                        obscureText: true,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Color(0xFFDEDEDE),
                          enabledBorder: enableBorder(),
                          focusedBorder: focusBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AppCommonButton(actionMethod: verifyOtp, title: 'Next'),
            ),
          ],
        ),
      ),
    );
  }
}
