import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myplo/controller/all_in_controller.dart';
import 'package:myplo/theme/common_theme.dart';
import 'package:provider/provider.dart';

class MakeFeaturedScreen extends StatefulWidget {
  const MakeFeaturedScreen({super.key});

  @override
  State<MakeFeaturedScreen> createState() => _MakeFeaturedScreenState();
}

class _MakeFeaturedScreenState extends State<MakeFeaturedScreen> {
  late AllInProvider provider;
  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AllInProvider>(context, listen: false);
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   provider.getMakeFeaturedDetails();
    // });
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
                    'Make Featured',
                    style: appbarTitle,
                  ),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Text(
                textAlign: TextAlign.center,
                'REACH MORE BUYERS AND SELL FASTER',
                style: GoogleFonts.firaSans(
                  color: Color(0xFF3C3C3C),
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                textAlign: TextAlign.center,
                'Upgrade your Product to a top position',
                style: GoogleFonts.firaSans(
                  color: Color(0xFF3C3C3C),
                  fontSize: 18,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 18),
            //   child: Consumer<AllInProvider>(
            //     builder: (context, value, child) {
            //       return Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           ...provider.makeFeature.map(
            //             (e) {
            //               return Consumer<AllInProvider>(
            //                 builder: (context, value, child) {
            //                   return InkWell(
            //                     onTap: () {
            //                       print(e);
            //                       if (e['id'] == '1') {
            //                         setState(() {
            //                           e['id'] = '1';
            //                           print(e['name']);
            //                         });
            //                       }
            //                       if (e['id'] == '2') {
            //                         setState(() {
            //                           e['id'] = '2';
            //                           print(e['name']);
            //                         });
            //                       }
            //                       if (e['id'] == '3') {
            //                         setState(() {
            //                           e['id'] = '3';
            //                           print(e['name']);
            //                         });
            //                       }
            //                     },
            //                     child: Container(
            //                       padding: EdgeInsets.symmetric(
            //                         horizontal: 30,
            //                         vertical: 10,
            //                       ),
            //                       decoration: BoxDecoration(
            //                         color: e['id'] == '1'
            //                             ? Color(0xFFF903E3)
            //                             : e['id'] == '2'
            //                                 ? Colors.white
            //                                 : e['id'] == '3'
            //                                     ? Colors.white
            //                                     : Color(0xFFF903E3),
            //                         borderRadius: BorderRadius.circular(15),
            //                         border: Border.all(
            //                           color: Color(0xFFF903E3),
            //                         ),
            //                       ),
            //                       child: Text(
            //                         e['name'],
            //                         style: GoogleFonts.firaSans(
            //                           color: Color(0xFF3C3C3C),
            //                           fontSize: 18,
            //                           fontStyle: FontStyle.normal,
            //                           fontWeight: FontWeight.w400,
            //                         ),
            //                       ),
            //                     ),
            //                   );
            //                 },
            //               );
            //             },
            //           ),
            //         ],
            //       );
            //     },
            //   ),
            // ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Text(
                        textAlign: TextAlign.center,
                        'REACH MORE BUYERS AND SELL FASTER',
                        style: GoogleFonts.firaSans(
                          color: Color(0xFF3C3C3C),
                          fontSize: 20,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        textAlign: TextAlign.center,
                        'Upgrade your Product to a top position',
                        style: GoogleFonts.firaSans(
                          color: Color(0xFF3C3C3C),
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                currentIndex = 1;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: currentIndex == 1
                                    ? Color(0xFFF903E3)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Color(0xFFF903E3),
                                ),
                              ),
                              child: Text(
                                '2x',
                                style: GoogleFonts.firaSans(
                                  color: currentIndex == 1
                                      ? Color(0xFF3C3C3C)
                                      : Color(0xFFF903E3),
                                  fontSize: 18,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                currentIndex = 2;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: currentIndex == 2
                                    ? Color(0xFFF903E3)
                                    : Colors.white,
                                border: Border.all(
                                  color: Color(0xFFF903E3),
                                ),
                              ),
                              child: Text(
                                '6x',
                                style: GoogleFonts.firaSans(
                                  color: currentIndex == 2
                                      ? Color(0xFF3C3C3C)
                                      : Color(0xFFF903E3),
                                  fontSize: 18,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                currentIndex = 3;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: currentIndex == 3
                                    ? Color(0xFFF903E3)
                                    : Colors.white,
                                border: Border.all(
                                  color: Color(0xFFF903E3),
                                ),
                              ),
                              child: Text(
                                '3x',
                                style: GoogleFonts.firaSans(
                                  color: currentIndex == 3
                                      ? Color(0xFF3C3C3C)
                                      : Color(0xFFF903E3),
                                  fontSize: 18,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: currentIndex == 1
                          ? Image.network(
                              'http://myplo.itworkshop.in:4000/fileStorage/uploads/featured/1/2x.png',
                              errorBuilder: (context, error, stackTrace) {
                                return Text('Image not found');
                              },
                            )
                          : currentIndex == 2
                              ? Image.network(
                                  'http://myplo.itworkshop.in:4000/fileStorage/uploads/featured/3/6x.png',
                                  errorBuilder: (context, error, stackTrace) {
                                    return Text('Image not found');
                                  },
                                )
                              : Image.network(
                                  'http://myplo.itworkshop.in:4000/fileStorage/uploads/featured/2/3x.png',
                                  errorBuilder: (context, error, stackTrace) {
                                    return Text('Image not found');
                                  },
                                ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFF903E3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        currentIndex == 1
                            ? 'Feature It For \$ 1'
                            : currentIndex == 2
                                ? 'Feature It For \$ 3'
                                : 'Feature It For \$ 2',
                        style: TextStyle(
                          color: Color(0xFF3C3C3C),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
