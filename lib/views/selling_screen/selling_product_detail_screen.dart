import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myplo/controller/all_in_controller.dart';
import 'package:myplo/theme/common_theme.dart';
import 'package:myplo/theme/font_theme.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class SellingProductDetailScreen extends StatefulWidget {
  const SellingProductDetailScreen({super.key});

  @override
  State<SellingProductDetailScreen> createState() =>
      _SellingProductDetailScreenState();
}

class _SellingProductDetailScreenState
    extends State<SellingProductDetailScreen> {
  final CarouselController carouselController = CarouselController();
  late AllInProvider provider;
  int currentIndex = 0;
  String share = 'MyPLo';

  void deleteDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Product'),
          content: Text('Are you sure you want to delete product?'),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFFF903E3),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text('Delete'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFFF903E3),
                        ),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Color(0xFFF903E3),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AllInProvider>(context, listen: false);
    final argument = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
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
                        'Selling Products',
                        style: appbarTitle,
                      )
                    ],
                  ),
                ),
                PopupMenuButton(
                  onSelected: (value) {
                    // setState(() {
                    //   print('value $value');
                    // });
                    if (value == 'Edit') {
                      print('Edit');
                    } else if (value == 'Share') {
                      print('Share');
                    } else {
                      print('Delete');
                      deleteDialog();
                    }
                  },
                  itemBuilder: (context) {
                    return <PopupMenuEntry>[
                      PopupMenuItem(
                        value: 'Edit',
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.edit),
                            Text('Edit'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        onTap: () {
                          Share.share(
                            share,
                            subject: 'MyPlo',
                          );
                        },
                        value: 'Share',
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.share),
                            Text('Share'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'Delete',
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.delete),
                            Text('Delete'),
                          ],
                        ),
                      ),
                    ];
                  },
                )
              ],
            ),
            SizedBox(
              height: 20,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(
                      items: argument['images']
                          .map<Widget>(
                            (item) => SizedBox(
                              child: Stack(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: Image.network(
                                      item,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      errorBuilder: (context, error, _) {
                                        return Text('No image found');
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                      carouselController: carouselController,
                      options: CarouselOptions(
                        scrollPhysics: const BouncingScrollPhysics(),
                        autoPlay: false,
                        aspectRatio: 1.5,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image.network(argument['images'][0]),
                          SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                              'Description',
                              style: GoogleFonts.firaSans(
                                color: Color(0xFF3C3C3C),
                                fontSize: 24,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                              right: 15,
                              top: 15,
                              bottom: 15,
                            ),
                            child: RichText(
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                text: '${argument['description']}',
                                style: ProductDetailPageTheme.productDetail,
                                children: [
                                  TextSpan(
                                    text: ' more...',
                                    style: GoogleFonts.firaSans(
                                      color: Color(0xFF666666),
                                      fontSize: 14,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                              right: 15,
                              top: 25,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    '${argument['title']}',
                                    style: ProductDetailPageTheme.productName,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                              right: 15,
                              top: 15,
                            ),
                            child: RichText(
                              text: TextSpan(
                                text: 'Price : ',
                                style: GoogleFonts.firaSans(
                                  color: Color(0xFF3C3C3C),
                                  fontSize: 20,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w600,
                                ),
                                children: [
                                  TextSpan(
                                    text: '\$ ${argument['rate']}',
                                    style: GoogleFonts.firaSans(
                                      color: Color(0xFFF903E3),
                                      fontSize: 20,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                              right: 15,
                              top: 15,
                            ),
                            child: RichText(
                              text: TextSpan(
                                text: 'Shipping Price : ',
                                style: GoogleFonts.firaSans(
                                  color: Color(0xFF3C3C3C),
                                  fontSize: 20,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w600,
                                ),
                                children: [
                                  TextSpan(
                                    text: '\$ ${argument['rate']}',
                                    style: GoogleFonts.firaSans(
                                      color: Color(0xFFF903E3),
                                      fontSize: 20,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 15,
                              top: 10,
                              right: 15,
                              bottom: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusDirectional.circular(5),
                                      side: BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/make_featured_screen');
                                    // provider.getMakeFeaturedDetails(context);
                                  },
                                  child: Text(
                                    '   Make Featured   ',
                                    style: GoogleFonts.firaSans(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusDirectional.circular(5),
                                      side: BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: Text(
                                    '   Mark as Sold   ',
                                    style: GoogleFonts.firaSans(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    // Container(
                    //   margin: EdgeInsets.symmetric(horizontal: 20),
                    //   padding: EdgeInsets.only(
                    //     left: 15,
                    //     bottom: 15,
                    //     right: 15,
                    //   ),
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(10),
                    //   ),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.only(
                    //           top: 15,
                    //         ),
                    //         child: Text(
                    //           'Sold By',
                    //           style: GoogleFonts.firaSans(
                    //             color: Color(0xFF0A6DFE),
                    //             fontSize: 16,
                    //             fontStyle: FontStyle.normal,
                    //             fontWeight: FontWeight.w500,
                    //           ),
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.only(top: 10),
                    //         child: Text(
                    //           provider.userProfileData['userName'],
                    //           style: GoogleFonts.firaSans(
                    //             color: Color(0xFF3C3C3C),
                    //             fontSize: 18,
                    //             fontStyle: FontStyle.normal,
                    //             fontWeight: FontWeight.w500,
                    //           ),
                    //         ),
                    //       ),
                    //       // Padding(
                    //       //   padding: const EdgeInsets.only(top: 15),
                    //       //   child: Row(
                    //       //     children: [
                    //       //       Icon(
                    //       //         Icons.access_time_outlined,
                    //       //       ),
                    //       //       RichText(
                    //       //         text: TextSpan(
                    //       //           text: ' Posted On : ',
                    //       //           style: GoogleFonts.firaSans(
                    //       //             color: Color(0xFF3C3C3C),
                    //       //             fontSize: 12,
                    //       //             fontStyle: FontStyle.normal,
                    //       //             fontWeight: FontWeight.w500,
                    //       //           ),
                    //       //           children: [
                    //       //             TextSpan(
                    //       //               text: '1 month ago',
                    //       //               style: GoogleFonts.firaSans(
                    //       //                 color: Color(0xFF3C3C3C),
                    //       //                 fontSize: 12,
                    //       //                 fontStyle: FontStyle.normal,
                    //       //                 fontWeight: FontWeight.w500,
                    //       //               ),
                    //       //             ),
                    //       //           ],
                    //       //         ),
                    //       //       ),
                    //       //     ],
                    //       //   ),
                    //       // ),
                    //       InkWell(
                    //         onTap: () {
                    //           Navigator.pushNamed(
                    //             context,
                    //             '/user_chat_screen',
                    //             arguments: argument,
                    //           );
                    //         },
                    //         child: Padding(
                    //           padding: const EdgeInsets.only(top: 15),
                    //           child: Card(
                    //             elevation: 5,
                    //             shape: RoundedRectangleBorder(
                    //               borderRadius: BorderRadius.circular(10),
                    //             ),
                    //             child: Container(
                    //               decoration: BoxDecoration(
                    //                 gradient: LinearGradient(
                    //                   colors: [
                    //                     Color(0xFF0A6DFE),
                    //                     Color(0xFFF903E3),
                    //                   ],
                    //                 ),
                    //                 borderRadius: BorderRadius.circular(10),
                    //               ),
                    //               child: Row(
                    //                 children: [
                    //                   Container(
                    //                     padding: EdgeInsets.all(4),
                    //                     width: 100,
                    //                     decoration: BoxDecoration(
                    //                       color: Colors.white,
                    //                       borderRadius: BorderRadius.only(
                    //                         topLeft: Radius.circular(10),
                    //                         bottomLeft: Radius.circular(10),
                    //                       ),
                    //                     ),
                    //                     child: Center(
                    //                       child: CircleAvatar(
                    //                         backgroundColor: Color(0xFFC4C4C4),
                    //                         radius: 20,
                    //                         backgroundImage: NetworkImage(
                    //                           '${provider.userProfileData['profileImage']}',
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                   Padding(
                    //                     padding:
                    //                         const EdgeInsets.only(left: 20),
                    //                     child: Text(
                    //                       'Chat With ${provider.userProfileData['userName']}',
                    //                       style: GoogleFonts.firaSans(
                    //                         color: Color(0xFFECECEC),
                    //                         fontSize: 18,
                    //                         fontStyle: FontStyle.normal,
                    //                         fontWeight: FontWeight.w500,
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(
                      height: 40,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 25),
                    //   child: Text(
                    //     'Similar products',
                    //     style: GoogleFonts.firaSans(
                    //       fontSize: 18,
                    //       fontStyle: FontStyle.normal,
                    //       fontWeight: FontWeight.w700,
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   physics: BouncingScrollPhysics(),
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(left: 23),
                    //     child: Row(
                    //       children: [
                    //         ...provider.sellingData.map(
                    //           (e) {
                    //             return InkWell(
                    //               onTap: () {
                    //                 print(e);
                    //               },
                    //               child: Container(
                    //                 width:
                    //                     MediaQuery.of(context).size.width / 2,
                    //                 child: Card(
                    //                   shape: RoundedRectangleBorder(
                    //                     borderRadius: BorderRadius.circular(12),
                    //                   ),
                    //                   child: Column(
                    //                     crossAxisAlignment:
                    //                         CrossAxisAlignment.start,
                    //                     children: [
                    //                       ClipRRect(
                    //                         borderRadius: BorderRadius.only(
                    //                           topLeft: Radius.circular(12),
                    //                           topRight: Radius.circular(12),
                    //                         ),
                    //                         child: Image.network(
                    //                           e['images'][0],
                    //                           width: double.infinity,
                    //                           height: 150,
                    //                           fit: BoxFit.cover,
                    //                           errorBuilder:
                    //                               (context, error, _) {
                    //                             return Text('No image found');
                    //                           },
                    //                         ),
                    //                       ),
                    //                       SizedBox(
                    //                         height: 10,
                    //                       ),
                    //                       Padding(
                    //                         padding:
                    //                             const EdgeInsets.only(left: 10),
                    //                         child: Text(
                    //                           e['title'],
                    //                           maxLines: 1,
                    //                           overflow: TextOverflow.ellipsis,
                    //                           style: GoogleFonts.firaSans(
                    //                             color: Color(0xFF3C3C3C),
                    //                             fontSize: 13,
                    //                             fontStyle: FontStyle.normal,
                    //                             fontWeight: FontWeight.w500,
                    //                           ),
                    //                         ),
                    //                       ),
                    //                       SizedBox(
                    //                         height: 5,
                    //                       ),
                    //                       Row(
                    //                         children: [
                    //                           Expanded(
                    //                             child: FittedBox(
                    //                               child: Padding(
                    //                                 padding:
                    //                                     const EdgeInsets.only(
                    //                                   left: 10,
                    //                                 ),
                    //                                 child: Text(
                    //                                   e['createdAt'],
                    //                                   maxLines: 1,
                    //                                   overflow:
                    //                                       TextOverflow.ellipsis,
                    //                                   style:
                    //                                       GoogleFonts.firaSans(
                    //                                     color:
                    //                                         Color(0xFFC1839F),
                    //                                     fontSize: 10,
                    //                                     fontStyle:
                    //                                         FontStyle.normal,
                    //                                     fontWeight:
                    //                                         FontWeight.w400,
                    //                                   ),
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                           ),
                    //                           Expanded(
                    //                             child: FittedBox(
                    //                               child: Padding(
                    //                                 padding:
                    //                                     const EdgeInsets.only(
                    //                                   left: 30,
                    //                                   right: 10,
                    //                                 ),
                    //                                 child: Text(
                    //                                   '\$ ${e['rate']}',
                    //                                   maxLines: 1,
                    //                                   overflow:
                    //                                       TextOverflow.ellipsis,
                    //                                   style:
                    //                                       GoogleFonts.firaSans(
                    //                                     color:
                    //                                         Color(0xFF3C3C3C),
                    //                                     fontSize: 16,
                    //                                     fontStyle:
                    //                                         FontStyle.normal,
                    //                                     fontWeight:
                    //                                         FontWeight.w700,
                    //                                   ),
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                       SizedBox(
                    //                         height: 10,
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ),
                    //             );
                    //           },
                    //         ).toList(),
                    //         SizedBox(
                    //           width: 20,
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    // ),
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
