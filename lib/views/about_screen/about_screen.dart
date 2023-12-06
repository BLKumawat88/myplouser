import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myplo/controller/all_in_controller.dart';
import 'package:myplo/theme/common_theme.dart';
import 'package:provider/provider.dart';

class AboutScreen extends StatelessWidget {
  AboutScreen({super.key});
  late AllInProvider provider;

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
                  Flexible(
                    child: FittedBox(
                      child: Text(
                        'About',
                        style: appbarTitle,
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
            SizedBox(
              height: 10,
            ),
            Consumer<AllInProvider>(
              builder: (context, value, child) {
                return Column(
                  children: [
                    ...provider.getstaticPageDetails.map(
                      (e) {
                        return Column(
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/about_detail_screen',
                                  arguments: e,
                                );
                                print('Data $e');
                              },
                              title: Text(
                                e['title'],
                                style: GoogleFonts.firaSans(
                                  color: Color(0xFF3C3C3C),
                                  fontSize: 18,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Divider(
                              color: Color(0xFFD9D9D9),
                            )
                          ],
                        );
                      },
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
