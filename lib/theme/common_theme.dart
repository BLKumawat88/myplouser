import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myplo/theme/font_theme.dart';

class CommonTheme {
  static final gradientColorOne = 0xFFF903E3;
  static final gradientColorTwo = 0xFF0A6DFE;
  static final double borderRadius = 22;
  static final double btnHeight = 55;
}

final appbarTitle = GoogleFonts.firaSans(
  color: Color(0xFF3C3C3C),
  fontSize: 25,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w700,
);

class AppCommonButton extends StatelessWidget {
  final Function actionMethod;
  final String title;
  const AppCommonButton(
      {super.key, required this.actionMethod, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        actionMethod();
      },
      child: Container(
        height: CommonTheme.btnHeight,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(CommonTheme.gradientColorOne),
              Color(CommonTheme.gradientColorTwo),
            ],
          ),
          borderRadius: BorderRadius.circular(CommonTheme.borderRadius),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            title,
            style: CommonFontTheme.authbutton,
          ),
        ),
      ),
    );
  }
}

class AppCommonButtonWithIcon extends StatelessWidget {
  final Function actionMethod;
  final String title;
  final String image;
  const AppCommonButtonWithIcon({
    super.key,
    required this.actionMethod,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        actionMethod();
      },
      child: Container(
        height: CommonTheme.btnHeight,
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 35),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(CommonTheme.gradientColorOne),
              Color(CommonTheme.gradientColorTwo),
            ],
          ),
          borderRadius: BorderRadius.circular(CommonTheme.borderRadius),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              width: 22,
            ),
            SizedBox(
              width: 7,
            ),
            Text(
              title,
              style: CommonFontTheme.authbutton,
            ),
          ],
        ),
      ),
    );
  }
}
