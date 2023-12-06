import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myplo/controller/all_in_controller.dart';
import 'package:myplo/theme/font_theme.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AllInProvider provider = Provider.of<AllInProvider>(context, listen: false);
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   provider.getAllRecentProducts(context);
    // });
    @override
    void dispose() {
      searchValue.dispose();
      FocusScope.of(context).unfocus();
      super.dispose();
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    final _storage =
                                        const FlutterSecureStorage();
                                    Navigator.pop(context);
                                    await _storage.delete(key: 'isuser_myplo');
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            '/IsUserLoggedInOrNot',
                                            (Route<dynamic> route) => false);
                                  },
                                  child: Icon(
                                    Icons.location_on,
                                    color: Color(0xFF5B5B5B),
                                  ),
                                ),
                                Flexible(
                                  child: FittedBox(
                                    child: Consumer<AllInProvider>(
                                      builder: (context, value, child) {
                                        return Text(
                                          provider.address,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                            color: Color(0xFF5B5B5B),
                                            fontSize: 16,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    provider.getLongitudeLatitude(context);
                                  },
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: Color(0xFF5B5B5B),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          provider.getFavoritesdata(context);
                        },
                        child: Icon(
                          Icons.favorite_border,
                          color: Color(0xFF5B5B5B),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: InkWell(
                          onTap: () {
                            provider.getAllNotification(context);
                          },
                          child: Icon(
                            Icons.notifications_none_rounded,
                            color: Color(0xFF5B5B5B),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextField(
                    controller: searchValue,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontStyle: FontStyle.normal,
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: 'Search',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      hintStyle: GoogleFonts.poppins(
                        color: Color(0xFF828282),
                        fontSize: 18,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          print("Seach value ${searchValue.text}");

                          provider.searchProductTitle = searchValue.text;
                          provider.getAllProductOfCategory(
                              {"title": searchValue.text},
                              context,
                              searchValue.text,
                              false);
                        },
                        child: Icon(
                          Icons.search,
                          size: 24,
                          color: Color(0xFF999999),
                        ),
                      ),
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Color(0xFFDEDEDE),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide: BorderSide(
                          color: Color(0xFFDEDEDE),
                          style: BorderStyle.none,
                          width: 0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(22),
                        borderSide: BorderSide(
                          color: Color(0xFFDEDEDE),
                          style: BorderStyle.none,
                          width: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/bottom_navigation',
                                (route) => false,
                              );
                            },
                            child: Image.asset(
                              'assets/images/pactive.png',
                              width: 110,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/gig_bottom_bar',
                                (route) => false,
                              );
                            },
                            child: Image.asset(
                              'assets/images/gdactive.png',
                              width: 110,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: FittedBox(
                              child: Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                'Browse Categories',
                                style: CommonFontTheme.browseViewMoreRecent,
                              ),
                            ),
                          ),
                          Flexible(
                            child: FittedBox(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/view_more_categories',
                                  );
                                },
                                child: Text(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  'View More',
                                  style: CommonFontTheme.browseViewMoreRecent,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    RefreshIndicator(
                      onRefresh: () async {
                        await Future.delayed(Duration(milliseconds: 1500));
                        setState(() {});
                      },
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        child: Consumer<AllInProvider>(
                          builder: (context, value, _) {
                            return Row(
                              children: [
                                ...provider.categoriesForHomeScreen.map(
                                  (e) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        left: 18,
                                      ),
                                      child: Column(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              print(
                                                'Product category id :- ${e['id']}',
                                              );
                                              provider.getAllProductOfCategory({
                                                "categoryId":
                                                    int.parse(e['id']),
                                              }, context, e, true);
                                            },
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3.5,
                                              height: 90,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(18),
                                                child: Image.network(
                                                  e['image'],
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return Text(
                                                      'Image not available',
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: Text(
                                              e['name'],
                                              style: GoogleFonts.inter(
                                                color: Color(0xFF5B5B5B),
                                                fontSize: 12,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ).toList(),
                                SizedBox(
                                  width: 18,
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 11,
                                height: 30,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF0A6DFE).withOpacity(.5),
                                      Color(0xFFF903E3).withOpacity(.5),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 3,
                                  left: 5,
                                ),
                                child: Text(
                                  'Recent Listing',
                                  style: CommonFontTheme.browseViewMoreRecent,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Consumer<AllInProvider>(
                        builder: ((context, value, child) => provider
                                .allProductOfcategoryRecentListingDummy.isEmpty
                            ? Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Image.asset(
                                      'assets/images/error.png',
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                    ),
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
                                ),
                              )
                            : GridView.builder(
                                itemCount: provider
                                            .allProductOfcategoryRecentListingDummy
                                            .length >
                                        12
                                    ? 12
                                    : provider
                                        .allProductOfcategoryRecentListingDummy
                                        .length,
                                // itemCount: 11 >= 12 ? 12 : 4,
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                padding: EdgeInsets.only(
                                  left: 18,
                                  right: 18,
                                ),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 4,
                                  mainAxisSpacing: 4,
                                  childAspectRatio: .75,
                                ),
                                itemBuilder: (context, index) {
                                  if (provider
                                          .allProductOfcategoryRecentListingDummy
                                          .length !=
                                      0) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: index == 11
                                          ? InkWell(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  '/view_more_categories',
                                                );
                                              },
                                              child: Card(
                                                elevation: 3,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 40),
                                                  child: Column(
                                                    children: [
                                                      Image.asset(
                                                        'assets/images/plus.png',
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            6,
                                                      ),
                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                      Text('View All')
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          : InkWell(
                                              onTap: () {
                                                provider
                                                    .getProductDetailsWithRelatedProduct(
                                                  context,
                                                  int.parse(provider
                                                          .allProductOfcategoryRecentListingDummy[
                                                      index]['id']),
                                                );
                                                print(
                                                    'Recent list product id :- ${provider.allProductOfcategoryRecentListingDummy[index]['id']}');
                                              },
                                              child: Card(
                                                elevation: 3,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Column(
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    10),
                                                            topRight:
                                                                Radius.circular(
                                                                    10),
                                                          ),
                                                          child: Image.network(
                                                            '${provider.allProductOfcategoryRecentListingDummy[index]['images'][0]}',
                                                            height: 130,
                                                            width:
                                                                double.infinity,
                                                            fit: BoxFit.cover,
                                                            errorBuilder:
                                                                (context, error,
                                                                    stackTrace) {
                                                              return Text(
                                                                'Image not available',
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        Positioned(
                                                          right: 6,
                                                          bottom: 6,
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                Colors.white
                                                                    .withOpacity(
                                                                        .7),
                                                            radius: 15,
                                                            child: InkWell(
                                                              onTap: () {
                                                                provider
                                                                    .addItemsToFav(
                                                                  int.parse(
                                                                    provider.allProductOfcategoryRecentListingDummy[
                                                                            index]
                                                                        ['id'],
                                                                  ),
                                                                  index,
                                                                  context,
                                                                );
                                                              },
                                                              child: provider.allProductOfcategoryRecentListingDummy[
                                                                              index]
                                                                          [
                                                                          'isFav'] !=
                                                                      null
                                                                  ? Icon(
                                                                      provider.allProductOfcategoryRecentListingDummy[index]
                                                                              [
                                                                              'isFav']
                                                                          ? Icons
                                                                              .favorite
                                                                          : Icons
                                                                              .favorite_border_outlined,
                                                                      color: Colors
                                                                          .red,
                                                                      size: 25,
                                                                    )
                                                                  : Icon(
                                                                      Icons
                                                                          .favorite_border_outlined,
                                                                      color: Colors
                                                                          .red,
                                                                      size: 25,
                                                                    ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 10,
                                                        left: 8,
                                                        right: 8,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Flexible(
                                                            fit: FlexFit.loose,
                                                            child: Text(
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              '${provider.allProductOfcategoryRecentListingDummy[index]['title']}',
                                                              style: GoogleFonts
                                                                  .firaSans(
                                                                fontSize: 13,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                          Flexible(
                                                            fit: FlexFit.loose,
                                                            child: Text(
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              '\$ ${provider.allProductOfcategoryRecentListingDummy[index]['rate']}',
                                                              style: GoogleFonts
                                                                  .firaSans(
                                                                fontSize: 16,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 6,
                                                        left: 8,
                                                        right: 8,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Flexible(
                                                            fit: FlexFit.loose,
                                                            child: Text(
                                                              '${provider.allProductOfcategoryRecentListingDummy[index]['timeAgo']}',
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: GoogleFonts
                                                                  .firaSans(
                                                                color: Color(
                                                                    0xFFC1839F),
                                                                fontSize: 10,
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
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                    );
                                  } else
                                    return Container();
                                },
                              ))),
                    SizedBox(
                      height: 20,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 18),
                    //   child: Column(
                    //     children: [
                    //       Stack(
                    //         children: [
                    //           Container(
                    //             width: MediaQuery.of(context).size.width / 11,
                    //             height: 30,
                    //             decoration: BoxDecoration(
                    //               gradient: LinearGradient(
                    //                 colors: [
                    //                   Color(0xFF0A6DFE).withOpacity(.5),
                    //                   Color(0xFFF903E3).withOpacity(.5),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //           Padding(
                    //             padding: const EdgeInsets.only(
                    //               top: 3,
                    //               left: 5,
                    //             ),
                    //             child: Text(
                    //               'Recent Browse',
                    //               style: CommonFontTheme.browseViewMoreRecent,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 15,
                    // ),
                    // Consumer<AllInProvider>(
                    //     builder: ((context, value, child) => provider
                    //             .recentProductsList.isEmpty
                    //         ? Center(
                    //             child: Column(
                    //               crossAxisAlignment: CrossAxisAlignment.center,
                    //               children: [
                    //                 SizedBox(
                    //                   height: 20,
                    //                 ),
                    //                 Image.asset(
                    //                   'assets/images/error.png',
                    //                   width:
                    //                       MediaQuery.of(context).size.width / 2,
                    //                 ),
                    //                 SizedBox(
                    //                   height: 40,
                    //                 ),
                    //                 Text(
                    //                   'Nothing here...',
                    //                   style: GoogleFonts.firaSans(
                    //                     color: Color(0xFF003034),
                    //                     fontSize: 16,
                    //                     fontStyle: FontStyle.normal,
                    //                     fontWeight: FontWeight.w600,
                    //                   ),
                    //                 )
                    //               ],
                    //             ),
                    //           )
                    //         : Column(
                    //             children: [
                    //               ...provider.recentProductsList.map((e) {
                    //                 return InkWell(
                    //                   onTap: () {
                    //                     provider
                    //                         .getProductDetailsWithRelatedProduct(
                    //                       context,
                    //                       e['id'],
                    //                     );
                    //                     print(
                    //                         'Recent list product id :- ${e['id']}');
                    //                   },
                    //                   child: Container(
                    //                     color: Colors.white,
                    //                     padding: EdgeInsets.only(
                    //                       top: 20,
                    //                       bottom: 20,
                    //                       left: 15,
                    //                     ),
                    //                     margin: EdgeInsets.symmetric(
                    //                       vertical: 5,
                    //                       horizontal: 18,
                    //                     ),
                    //                     child: Row(
                    //                       crossAxisAlignment:
                    //                           CrossAxisAlignment.start,
                    //                       children: [
                    //                         ClipRRect(
                    //                           borderRadius:
                    //                               BorderRadius.circular(
                    //                             10,
                    //                           ),
                    //                           child: Image.network(
                    //                             '${e['image']}',
                    //                             width: MediaQuery.of(context)
                    //                                     .size
                    //                                     .width /
                    //                                 4,
                    //                             fit: BoxFit.cover,
                    //                             errorBuilder: (context, error,
                    //                                 stackTrace) {
                    //                               return Text(
                    //                                 'Image not available',
                    //                               );
                    //                             },
                    //                           ),
                    //                         ),
                    //                         Flexible(
                    //                           child: Padding(
                    //                             padding: const EdgeInsets.only(
                    //                                 left: 15),
                    //                             child: Column(
                    //                               crossAxisAlignment:
                    //                                   CrossAxisAlignment.start,
                    //                               mainAxisAlignment:
                    //                                   MainAxisAlignment.start,
                    //                               children: [
                    //                                 Text(
                    //                                   maxLines: 1,
                    //                                   overflow:
                    //                                       TextOverflow.ellipsis,
                    //                                   '${e['name']}',
                    //                                   style:
                    //                                       GoogleFonts.firaSans(
                    //                                     fontSize: 15,
                    //                                     fontStyle:
                    //                                         FontStyle.normal,
                    //                                     fontWeight:
                    //                                         FontWeight.w500,
                    //                                   ),
                    //                                 ),
                    //                                 Padding(
                    //                                   padding:
                    //                                       const EdgeInsets.only(
                    //                                           top: 5),
                    //                                   child: Text(
                    //                                     maxLines: 1,
                    //                                     overflow: TextOverflow
                    //                                         .ellipsis,
                    //                                     '${e['address']}',
                    //                                     style: GoogleFonts
                    //                                         .firaSans(
                    //                                       fontSize: 13,
                    //                                       fontStyle:
                    //                                           FontStyle.normal,
                    //                                       fontWeight:
                    //                                           FontWeight.w400,
                    //                                     ),
                    //                                   ),
                    //                                 ),
                    //                                 Padding(
                    //                                   padding:
                    //                                       const EdgeInsets.only(
                    //                                           top: 5),
                    //                                   child: Text(
                    //                                     '\$ ${e['price']}',
                    //                                     style: GoogleFonts
                    //                                         .firaSans(
                    //                                       fontSize: 16,
                    //                                       fontStyle:
                    //                                           FontStyle.normal,
                    //                                       fontWeight:
                    //                                           FontWeight.w700,
                    //                                     ),
                    //                                   ),
                    //                                 )
                    //                               ],
                    //                             ),
                    //                           ),
                    //                         )
                    //                       ],
                    //                     ),
                    //                   ),
                    //                 );
                    //               }),
                    //             ],
                    //           ))),
                    // SizedBox(
                    //   height: 15,
                    // ),
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
