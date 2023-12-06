import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  bool customTileExpandedOne = false;
  bool customTileExpandedTwo = false;

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
                  Text(
                    'FAQ',
                    style: GoogleFonts.firaSans(
                      color: Color(0xFF3C3C3C),
                      fontSize: 25,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
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
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Help Center',
                        style: GoogleFonts.firaSans(
                          color: Color(0xFF3C3C3C),
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Lorem Ipsum is simply dummy text of the printing'
                        'and typesetting industry. Lorem Ipsum has been '
                        'the industry\'s standard dummy text ever since the '
                        '1500s, when an unknown printer took a galley of type '
                        'and scrambled it to make a type specimen book. It '
                        'has survived not only five centuries, but also the leap '
                        'into electronic typesetting, remaining essentially unchanged.',
                        style: GoogleFonts.firaSans(
                          color: Color(0xFF656565),
                          fontSize: 14,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Theme(
                          data: ThemeData().copyWith(
                            dividerColor: Colors.transparent,
                          ),
                          child: ExpansionTile(
                            childrenPadding: EdgeInsets.only(
                              left: 15,
                              bottom: 15,
                            ),
                            trailing: Icon(
                              customTileExpandedOne
                                  ? Icons.keyboard_arrow_down_rounded
                                  : Icons.keyboard_arrow_right_rounded,
                              color: Color(0xFF3C3C3C),
                            ),
                            onExpansionChanged: (bool value) {
                              setState(
                                () => customTileExpandedOne = value,
                              );
                            },
                            title: Text(
                              'Any Question',
                              style: GoogleFonts.firaSans(
                                color: Color(0xFF3C3C3C),
                                fontSize: 16,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'Lorem Ipsum is simply dummy text of the printing and typesetting '
                                      'industry. Lorem Ipsum has been the industry\'s standard dummy '
                                      'text ever since the 1500s, when an unknown printer took a galley '
                                      'of type and scrambled it to make a type specimen book.',
                                      style: GoogleFonts.firaSans(
                                        fontSize: 10,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Theme(
                          data: ThemeData().copyWith(
                            dividerColor: Colors.transparent,
                          ),
                          child: ExpansionTile(
                            childrenPadding: EdgeInsets.only(
                              left: 15,
                              bottom: 15,
                            ),
                            trailing: Icon(
                              customTileExpandedTwo
                                  ? Icons.keyboard_arrow_down_rounded
                                  : Icons.keyboard_arrow_right_rounded,
                              color: Color(0xFF3C3C3C),
                            ),
                            onExpansionChanged: (bool value) {
                              setState(
                                () => customTileExpandedTwo = value,
                              );
                            },
                            title: Text(
                              'Any Question',
                              style: GoogleFonts.firaSans(
                                color: Color(0xFF3C3C3C),
                                fontSize: 16,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'Lorem Ipsum is simply dummy text of the printing and typesetting '
                                      'industry. Lorem Ipsum has been the industry\'s standard dummy '
                                      'text ever since the 1500s, when an unknown printer took a galley '
                                      'of type and scrambled it to make a type specimen book.',
                                      style: GoogleFonts.firaSans(
                                        fontSize: 10,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
