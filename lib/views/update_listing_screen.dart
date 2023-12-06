import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateListingScreen extends StatelessWidget {
  const UpdateListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Image.asset(
              'assets/images/app_logo.png',
              scale: 6,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              margin: EdgeInsets.only(
                left: 30,
                right: 30,
                top: 50,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Image.asset('assets/images/update_listing.png'),
                  Text(
                    textAlign: TextAlign.center,
                    'Congratulation Your Listing Has Been updated',
                    style: GoogleFonts.firaSans(
                      color: Color(0xFF3C3C3C),
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 50,
                          color: Color(0xFF727272),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Go To Home',
                              style: GoogleFonts.firaSans(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF0A6DFE), Color(0xFFF903E3)],
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Add More Listing',
                            style: GoogleFonts.firaSans(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
