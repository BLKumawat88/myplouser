import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myplo/controller/all_in_controller.dart';
import 'package:myplo/theme/common_theme.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late AllInProvider provider;
  int currentIndex = 1;

  final orderScreenTitle = GoogleFonts.inter(
    color: Color(0xFF033134),
    fontSize: 10,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
  );
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AllInProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 10,
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
                    'My Orders',
                    style: appbarTitle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // Divider(
            //   color: Color(0xFFD9D9D9),
            // ),
            SizedBox(
              height: 10,
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 30),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       InkWell(
            //         onTap: () {
            //           setState(() {
            //             currentIndex = 1;
            //           });
            //         },
            //         child: Container(
            //           height: 20,
            //           child: Text(
            //             'ACTIVE',
            //             style: orderScreenTitle,
            //           ),
            //         ),
            //       ),
            //       InkWell(
            //         onTap: () {
            //           setState(() {
            //             currentIndex = 2;
            //           });
            //         },
            //         child: Container(
            //           height: 20,
            //           child: Text(
            //             'SCHEDULED',
            //             style: orderScreenTitle,
            //           ),
            //         ),
            //       ),
            //       InkWell(
            //         onTap: () {
            //           setState(() {
            //             currentIndex = 3;
            //           });
            //         },
            //         child: Container(
            //           height: 20,
            //           child: Text(
            //             'EXPIRED',
            //             style: orderScreenTitle,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     currentIndex == 1
            //         ? Container(
            //             height: 6,
            //             width: 110,
            //             color: Color(0xFF033134),
            //           )
            //         : Container(),
            //     currentIndex == 2
            //         ? Container(
            //             height: 6,
            //             width: 110,
            //             color: Color(0xFF033134),
            //           )
            //         : Container(),
            //     currentIndex == 3
            //         ? Container(
            //             height: 6,
            //             width: 110,
            //             color: Color(0xFF033134),
            //           )
            //         : Container(),
            //   ],
            // ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Color(0xFFD9D9D9),
            ),
            currentIndex == 1
                ? Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Consumer<AllInProvider>(
                        builder: (context, value, child) {
                          return Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              ...provider.myOrderData.map(
                                (e) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFF1F3F5),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  text: 'Status: ',
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.black,
                                                    fontSize: 13,
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text: e['status'],
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color:
                                                            Color(0xFFF903E3),
                                                        fontSize: 12,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    '/order_detail_screen',
                                                    arguments: e,
                                                  );
                                                },
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      'More Info',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.black,
                                                        fontSize: 12,
                                                        fontStyle:
                                                            FontStyle.normal,
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons
                                                          .arrow_forward_ios_rounded,
                                                      size: 11,
                                                      color: Colors.black,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 1,
                                          color: Colors.grey,
                                        ),
                                        Container(
                                          color: Color(0xFFF1F3F5),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Flexible(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 10,
                                                    top: 10,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child: Image.network(e[
                                                                'orderDetails']
                                                            ['productImage']),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          top: 10,
                                                        ),
                                                        child: RichText(
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          text: TextSpan(
                                                            text: 'Seller: ',
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 13,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                            children: [
                                                              TextSpan(
                                                                text: e['orderDetails']
                                                                    [
                                                                    'sellerName'],
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 12,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
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
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 10,
                                                    top: 10,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        e['orderDetails']
                                                            ['productName'],
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      Text(
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        '\$ ${e['orderDetails']['productFee']}',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: Colors.black,
                                                          fontSize: 12,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Flexible(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 10,
                                                    right: 10,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            3.8,
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            5,
                                                          ),
                                                          border: Border.all(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                        child: RichText(
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          text: TextSpan(
                                                            text: 'Order Id: ',
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                            children: [
                                                              TextSpan(
                                                                text: e['_id'],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            3.8,
                                                        padding:
                                                            EdgeInsets.all(5),
                                                        margin: EdgeInsets.only(
                                                          top: 10,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFF464E55),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            5,
                                                          ),
                                                        ),
                                                        child: Text(
                                                          textAlign:
                                                              TextAlign.center,
                                                          'Cancel',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                            top: 8,
                                            bottom: 8,
                                            right: 8,
                                          ),
                                          margin: EdgeInsets.only(top: 5),
                                          decoration: BoxDecoration(
                                            color: Color(0xFFE8ECF0),
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            ),
                                          ),
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: RichText(
                                              text: TextSpan(
                                                text: 'Order Total: ',
                                                style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontSize: 13,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        '\$ ${(e['orderDetails']['totalFee']).toStringAsFixed(2)}',
                                                    style: GoogleFonts.poppins(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ).toList(),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  )
                : currentIndex == 2
                    ? Consumer<AllInProvider>(
                        builder: (context, value, child) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Image.asset(
                                'assets/images/error.png',
                                width: 250,
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Text(
                                'Nothing Here......',
                                style: GoogleFonts.firaSans(
                                  color: Color(0xFF003034),
                                  fontSize: 16,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                'You don’t Have active package',
                                style: GoogleFonts.firaSans(
                                  color: Color(0xFF003034),
                                  fontSize: 16,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          );
                        },
                      )
                    : currentIndex == 3
                        ? Consumer<AllInProvider>(
                            builder: (context, value, child) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Image.asset(
                                    'assets/images/error.png',
                                    width: 250,
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Text(
                                    'Nothing Here......',
                                    style: GoogleFonts.firaSans(
                                      color: Color(0xFF003034),
                                      fontSize: 16,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'You don’t Have active package',
                                    style: GoogleFonts.firaSans(
                                      color: Color(0xFF003034),
                                      fontSize: 16,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              );
                            },
                          )
                        : SizedBox(),
          ],
        ),
      ),
    );
  }
}
