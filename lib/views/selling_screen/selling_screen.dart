import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:myplo/controller/all_in_controller.dart';
import 'package:myplo/theme/common_theme.dart';
import 'package:provider/provider.dart';

class SellingScreen extends StatefulWidget {
  SellingScreen({super.key});

  @override
  State<SellingScreen> createState() => _SellingScreenState();
}

class _SellingScreenState extends State<SellingScreen> {
  late AllInProvider provider;

  String date = '1668149518489';

  void updateDate() {
    DateTime now = DateTime.now();
    setState(() {
      date = DateFormat('dd-MM-yyyy').format(now);

      print('Date $date');
    });
  }

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
                  Text(
                    'Selling',
                    style: appbarTitle,
                  )
                ],
              ),
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
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Consumer<AllInProvider>(
                        builder: (context, value, child) {
                          return provider.sellingData.isEmpty
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Image.asset('assets/images/error.png'),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Text(
                                      'Nothing here...',
                                      style: GoogleFonts.firaSans(
                                        color: Color(0xFF003034),
                                        fontSize: 16,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                )
                              : Column(
                                  children: [
                                    ...provider.sellingData.map(
                                      (e) {
                                        return InkWell(
                                          onTap: () {
                                            print(
                                                'Instance of selling data :- $e');
                                            Navigator.pushNamed(
                                              context,
                                              '/selling_product_detail_screen',
                                              arguments: e,
                                            );
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 12,
                                            ),
                                            margin: EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Color(0xFF088B1D)
                                                  .withOpacity(.14),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                    e['images'][0],
                                                    width: 100,
                                                  ),
                                                ),
                                                Flexible(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 12),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        FittedBox(
                                                          child: Text(
                                                            e['title'],
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: GoogleFonts
                                                                .firaSans(
                                                              color: Color(
                                                                  0xFF616161),
                                                              fontSize: 18,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 8,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                FittedBox(
                                                                  child: Text(
                                                                    'Views: ${e['viewers']}',
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: GoogleFonts
                                                                        .firaSans(
                                                                      color: Color(
                                                                          0xFF616161),
                                                                      fontSize:
                                                                          16,
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .normal,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Flexible(
                                                              flex: 3,
                                                              child: FittedBox(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                    left: 15,
                                                                  ),
                                                                  child: Text(
                                                                    e['status'],
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: GoogleFonts
                                                                        .firaSans(
                                                                      color: Color(
                                                                          0xFF3C3C3C),
                                                                      fontSize:
                                                                          14,
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .normal,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 7,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                FittedBox(
                                                                  child: Text(
                                                                    '\$ ${e['rate']}',
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: GoogleFonts
                                                                        .firaSans(
                                                                      color: Color(
                                                                          0xFF087E8B),
                                                                      fontSize:
                                                                          18,
                                                                      fontStyle:
                                                                          FontStyle
                                                                              .normal,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Flexible(
                                                              flex: 3,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  left: 10,
                                                                ),
                                                                child: Text(
                                                                  e['createdAt'],
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: GoogleFonts
                                                                      .firaSans(
                                                                    color: Color(
                                                                        0xFFC1839F),
                                                                    fontSize:
                                                                        18,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .normal,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            // Flexible(
                                                            //   child: FittedBox(
                                                            //     child: Padding(
                                                            //       padding:
                                                            //           const EdgeInsets
                                                            //               .only(
                                                            //         left: 10,
                                                            //       ),
                                                            //       child: Container(
                                                            //         decoration:
                                                            //             BoxDecoration(
                                                            //           color:
                                                            //               Colors.white,
                                                            //           shape: BoxShape
                                                            //               .circle,
                                                            //         ),
                                                            //         padding:
                                                            //             EdgeInsets.all(
                                                            //                 2),
                                                            //         child: e['icon'],
                                                            //       ),
                                                            //     ),
                                                            //   ),
                                                            // ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ).toList()
                                  ],
                                );
                        },
                      ),
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
