import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myplo/controller/all_in_controller.dart';
import 'package:myplo/theme/common_dialog.dart';
import 'package:myplo/theme/font_theme.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../theme/text_form_fields_theme.dart';

List<String> imageList = [
  'assets/images/product_detail.png',
];

class ProductDetailScreen extends StatefulWidget {
  ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final CarouselController carouselController = CarouselController();

  String share = 'MyPLo';
  int currentIndex = 0;

  TextEditingController makeAnOffer = TextEditingController();
  bool showHideOfferSection = false;

  @override
  Widget build(BuildContext context) {
    AllInProvider provider = Provider.of<AllInProvider>(context, listen: false);
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Image.asset(
                    'assets/images/app_logo.png',
                    scale: 8,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Stack(
                        children: [
                          CarouselSlider(
                            items: provider.productDetail['images']
                                .map<Widget>(
                                  (item) => SizedBox(
                                    child: Stack(
                                      children: <Widget>[
                                        item.split('.').last == "jpg" ||
                                                item.split('.').last == "png" ||
                                                item.split('.').last == "jpeg"
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 25),
                                                child: Image.network(
                                                  item,
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                  height: 225,
                                                  errorBuilder:
                                                      (context, error, _) {
                                                    return Text(
                                                        'No image found');
                                                  },
                                                ),
                                              )
                                            : Container(
                                                child: Center(
                                                child: Text(
                                                    "Video Will show here"),
                                              )),
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
                          Positioned(
                            bottom: 25,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: provider.productDetail['images']
                                  .asMap()
                                  .entries
                                  .map<Widget>((entry) {
                                return GestureDetector(
                                  onTap: () => carouselController
                                      .animateToPage(entry.key),
                                  child: Container(
                                    width: 7.0,
                                    height: 7.0,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 7.0,
                                    ),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: currentIndex == entry.key
                                          ? appCommonColor
                                          : Colors.white,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              provider.productDetail['title'],
                              style: ProductDetailPageTheme.productName,
                            ),
                          ),
                          // InkWell(
                          //   onTap: () {
                          //     Map createRoomRequiredData = {
                          //       "productId":
                          //           int.parse(provider.productDetail['id']),
                          //       "productuserId":
                          //           provider.productDetail['userId'],
                          //       "userId": int.parse(provider.userId),
                          //     };
                          //     log('${provider.productDetail}');
                          //     provider.createRoom(
                          //         createRoomRequiredData, context);
                          //     // provider.getMessage();
                          //     // provider.sendMessage();
                          //   },
                          //   child: Container(
                          //     padding: EdgeInsets.all(8.0),
                          //     decoration: BoxDecoration(
                          //       gradient: LinearGradient(
                          //         colors: [
                          //           Color(0xFFF257A8),
                          //           Color(0xFF1B66FC),
                          //         ],
                          //         begin: Alignment.topCenter,
                          //         end: Alignment.bottomCenter,
                          //       ),
                          //       shape: BoxShape.circle,
                          //     ),
                          //     child: Icon(
                          //       Icons.chat,
                          //       color: Colors.white,
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Share.share(
                                share,
                                subject: 'MyPlo',
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFFF257A8),
                                    Color(0xFF1B66FC),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.share_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text(
                        '\$ ${provider.productDetail['rate']}',
                        style: ProductDetailPageTheme.productPrice,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: RichText(
                        text: TextSpan(
                          text: provider.productDetail['description'],
                          style: ProductDetailPageTheme.productDetail,
                          children: [
                            // TextSpan(
                            //   text: ' more...',
                            //   style: GoogleFonts.firaSans(
                            //     color: Color(0xFF666666),
                            //     fontSize: 14,
                            //     fontStyle: FontStyle.normal,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     Map createRoomRequiredData = {
                    //       "productId": int.parse(provider.productDetail['id']),
                    //       "productuserId": provider.productDetail['userId'],
                    //       "userId": int.parse(provider.userId),
                    //     };
                    //     log('${provider.productDetail}');
                    //     provider.createRoom(createRoomRequiredData, context);
                    //   },
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(
                    //       top: 15,
                    //       left: 20,
                    //       right: 20,
                    //     ),
                    //     child: Card(
                    //       elevation: 5,
                    //       shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //       child: Container(
                    //         decoration: BoxDecoration(
                    //           gradient: LinearGradient(
                    //             colors: [
                    //               Color(0xFF0A6DFE),
                    //               Color(0xFFF903E3),
                    //             ],
                    //           ),
                    //           borderRadius: BorderRadius.circular(10),
                    //         ),
                    //         child: Row(
                    //           children: [
                    //             Container(
                    //               padding: EdgeInsets.all(4),
                    //               width: 100,
                    //               decoration: BoxDecoration(
                    //                 color: Colors.white,
                    //                 borderRadius: BorderRadius.only(
                    //                   topLeft: Radius.circular(10),
                    //                   bottomLeft: Radius.circular(10),
                    //                 ),
                    //               ),
                    //               child: Center(
                    //                 child: CircleAvatar(
                    //                   backgroundColor: Color(0xFFC4C4C4),
                    //                   radius: 20,
                    //                   backgroundImage: NetworkImage(
                    //                       '${provider.productDetail['userProfile']}'),
                    //                 ),
                    //               ),
                    //             ),
                    //             Padding(
                    //               padding: const EdgeInsets.only(left: 20),
                    //               child: Text(
                    //                 'Chat With ${provider.productDetail['userName']}',
                    //                 style: GoogleFonts.firaSans(
                    //                   color: Color(0xFFECECEC),
                    //                   fontSize: 18,
                    //                   fontStyle: FontStyle.normal,
                    //                   fontWeight: FontWeight.w500,
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    provider.userId !=
                            provider.productDetail['userId'].toString()
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      showHideOfferSection =
                                          !showHideOfferSection;
                                      makeAnOffer.text = "";
                                    });
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF0A6DFE),
                                          Color(0xFFF903E3),
                                        ],
                                      ),
                                    ),
                                    width: double.infinity,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Make an offer',
                                        style: GoogleFonts.firaSans(
                                          color: Color(0xFFECECEC),
                                          fontSize: 24,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                showHideOfferSection
                                    ? Column(
                                        children: [
                                          TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller: makeAnOffer,
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Color(0xFFDEDEDE),
                                              hintText: 'Enter Offer Price ',
                                              hintStyle: CommonFontTheme
                                                  .authTextFormFields,
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter password';
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if (makeAnOffer.text.isEmpty ||
                                                  makeAnOffer.text.isEmpty ==
                                                      "") {
                                                CommanDialog.showErrorDialog(
                                                    context,
                                                    description:
                                                        "Price Required");
                                              } else {
                                                Map createRoomRequiredData = {
                                                  "productId": int.parse(
                                                      provider
                                                          .productDetail['id']),
                                                  "productuserId": provider
                                                      .productDetail['userId'],
                                                  "userId": int.parse(
                                                      provider.userId),
                                                };
                                                provider.makeOfferValue =
                                                    makeAnOffer.text;
                                                provider.createRoom(
                                                  createRoomRequiredData,
                                                  context,
                                                  false,
                                                );
                                                setState(() {
                                                  showHideOfferSection =
                                                      !showHideOfferSection;
                                                });
                                              }
                                            },
                                            child: Container(
                                              height: 50,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                color: Colors.black,
                                              )),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'Send',
                                                  style: GoogleFonts.firaSans(
                                                    fontSize: 24,
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : SizedBox()
                              ],
                            ),
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text(
                        'Similar products',
                        style: GoogleFonts.firaSans(
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 23),
                        child: Row(
                          children: [
                            ...provider.relatedProducts.map(
                              (e) {
                                return InkWell(
                                  onTap: () {
                                    print(e);
                                    // provider
                                    //     .getProductDetailsWithRelatedProduct(
                                    //   context,
                                    //   int.parse(
                                    //     e['id'],
                                    //   ),
                                    // );
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(12),
                                              topRight: Radius.circular(12),
                                            ),
                                            child: Image.network(
                                              e['images'][0],
                                              width: double.infinity,
                                              height: 150,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, _) {
                                                return Text('No image found');
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              e['title'],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.firaSans(
                                                color: Color(0xFF3C3C3C),
                                                fontSize: 13,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: FittedBox(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 10,
                                                    ),
                                                    child: Text(
                                                      e['timeAgo'],
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          GoogleFonts.firaSans(
                                                        color:
                                                            Color(0xFFC1839F),
                                                        fontSize: 10,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: FittedBox(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 30,
                                                      right: 10,
                                                    ),
                                                    child: Text(
                                                      '\$ ${e['rate']}',
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          GoogleFonts.firaSans(
                                                        color:
                                                            Color(0xFF3C3C3C),
                                                        fontSize: 16,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
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
            ),
            provider.userId != provider.productDetail['userId'].toString()
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Map createRoomRequiredData = {
                            "productId":
                                int.parse(provider.productDetail['id']),
                            "productuserId": provider.productDetail['userId'],
                            "userId": int.parse(provider.userId),
                          };

                          log('${provider.productDetail}');
                          provider.createRoom(
                            createRoomRequiredData,
                            context,
                            true,
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 50,
                          color: Color(0xFF727272),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Chat',
                              style: GoogleFonts.firaSans(
                                color: Color(0xFFECECEC),
                                fontSize: 24,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          print(
                              "PID ${int.parse(provider.productDetail['id'])}");
                          provider.productIdToBuy =
                              int.parse(provider.productDetail['id']);
                          // Navigator.pushNamed(context, '/add_address_screen');
                          provider.buyerShippingAddress(context, true);
                          provider.getCountries();
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF0A6DFE),
                                Color(0xFFF903E3),
                              ],
                            ),
                          ),
                          width: MediaQuery.of(context).size.width / 2,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Buy Now',
                              style: GoogleFonts.firaSans(
                                color: Color(0xFFECECEC),
                                fontSize: 24,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          // Map createRoomRequiredData = {
                          //   "productId":
                          //       int.parse(provider.productDetail['id']),
                          //   "productuserId": provider.productDetail['userId'],
                          //   "userId": int.parse(provider.userId),
                          // };

                          // log('${provider.productDetail}');
                          // provider.createRoom(
                          //   createRoomRequiredData,
                          //   context,
                          //   true,
                          // );
                          Navigator.pushNamed(context, '/cong_screen');
                          provider.requiredData['productId'] =
                              provider.productDetail['id'];
                          provider
                              .getCongratulationsScreenDataAfterAddingProductToBoost(
                                  context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 50,
                          color: Color(0xFF727272),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Make Featured',
                              style: GoogleFonts.firaSans(
                                color: Color(0xFFECECEC),
                                fontSize: 24,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // print(
                          //     "PID ${int.parse(provider.productDetail['id'])}");
                          // provider.productIdToBuy =
                          //     int.parse(provider.productDetail['id']);
                          // // Navigator.pushNamed(context, '/add_address_screen');
                          // provider.buyerShippingAddress(context, true);
                          // provider.getCountries();
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF0A6DFE),
                                Color(0xFFF903E3),
                              ],
                            ),
                          ),
                          width: MediaQuery.of(context).size.width / 2,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Mark as sold',
                              style: GoogleFonts.firaSans(
                                color: Color(0xFFECECEC),
                                fontSize: 24,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
