import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myplo/controller/all_in_controller.dart';
import 'package:myplo/theme/common_theme.dart';
import 'package:myplo/views/side_navigation_drawer/side_navigation_drawer.dart';
import 'package:provider/provider.dart';

class CategorySearchProduct extends StatelessWidget {
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
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(
                            left: 30,
                            right: 5,
                          ),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 8,
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
                                    left: 5,
                                  ),
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    provider.searchProductTitle,
                                    style: appbarTitle,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Color(0xFFD9D9D9),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    provider.allProductOfcategory.isEmpty
                        ? Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Image.asset(
                                  'assets/images/error.png',
                                  width: MediaQuery.of(context).size.width / 2,
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
                        : Consumer<AllInProvider>(
                            builder: (context, value, child) {
                              return GridView.builder(
                                itemCount: provider.allProductOfcategory.length,
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
                                  childAspectRatio: .8,
                                ),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      provider
                                          .getProductDetailsWithRelatedProduct(
                                        context,
                                        int.parse(
                                          provider.allProductOfcategory[index]
                                              ['id'],
                                        ),
                                      );
                                    },
                                    child: Card(
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        children: [
                                          Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(10),
                                                ),
                                                child: Image.network(
                                                  '${provider.allProductOfcategory[index]['images'][0]}',
                                                  height: 130,
                                                  width: double.infinity,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (context, error,
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
                                                  backgroundColor: Colors.white
                                                      .withOpacity(.7),
                                                  radius: 15,
                                                  child: InkWell(
                                                    onTap: () {
                                                      provider.addItemsToFav(
                                                        int.parse(
                                                          provider.allProductOfcategory[
                                                              index]['id'],
                                                        ),
                                                        index,
                                                        context,
                                                      );
                                                    },
                                                    child:
                                                        provider.allProductOfcategory[
                                                                        index]
                                                                    ['isFav'] !=
                                                                null
                                                            ? Icon(
                                                                provider.allProductOfcategory[
                                                                            index]
                                                                        [
                                                                        'isFav']
                                                                    ? Icons
                                                                        .favorite
                                                                    : Icons
                                                                        .favorite_border_outlined,
                                                                color:
                                                                    Colors.red,
                                                                size: 25,
                                                              )
                                                            : Icon(
                                                                Icons
                                                                    .favorite_border_outlined,
                                                                color:
                                                                    Colors.red,
                                                                size: 25,
                                                              ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
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
                                                        TextOverflow.ellipsis,
                                                    '${provider.allProductOfcategory[index]['title']}',
                                                    style: GoogleFonts.firaSans(
                                                      fontSize: 13,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                Flexible(
                                                  fit: FlexFit.loose,
                                                  child: Text(
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    '\$ ${provider.allProductOfcategory[index]['rate']}',
                                                    style: GoogleFonts.firaSans(
                                                      fontSize: 16,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 6,
                                              left: 8,
                                              right: 8,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${provider.allProductOfcategory[index]['timeAgo']}',
                                                  style: GoogleFonts.firaSans(
                                                    color: Color(0xFFC1839F),
                                                    fontSize: 10,
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Flexible(
                                                  fit: FlexFit.loose,
                                                  child: Text(
                                                    '${provider.allProductOfcategory[index]['location']['city']}',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.firaSans(
                                                      color: Color(0xFFC1839F),
                                                      fontSize: 10,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
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
