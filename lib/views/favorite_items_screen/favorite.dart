import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myplo/controller/all_in_controller.dart';
import 'package:myplo/theme/common_theme.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});

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
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(
                      left: 30,
                      right: 20,
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
                Text(
                  'Favorites',
                  style: appbarTitle,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Color(0xFFD9D9D9),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Consumer<AllInProvider>(
                  builder: (context, value, child) {
                    return provider.favoritesItems.isEmpty
                        ? Column(
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
                            ],
                          )
                        : Column(
                            children: [
                              ...provider.favoritesItems.map(
                                (e) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.all(12),
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF087E8B).withOpacity(.14),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(9),
                                          child: Image.network(
                                            e['images'][0],
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3.5,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 22),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  e['title'],
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: GoogleFonts.firaSans(
                                                    color: Color(0xFF616161),
                                                    fontSize: 18,
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5),
                                                  child: Text(
                                                    e['description'],
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.firaSans(
                                                      color: Color(0xFF898989),
                                                      fontSize: 18,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 5,
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        '\$ ${e['rate']}',
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: GoogleFonts
                                                            .firaSans(
                                                          color:
                                                              Color(0xFF616161),
                                                          fontSize: 18,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.all(4),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Icon(
                                                          Icons.favorite,
                                                          color: Colors.red,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        // Expanded(
                                        //   child: Row(
                                        //     mainAxisAlignment:
                                        //         MainAxisAlignment.end,
                                        //     children: [
                                        //       Padding(
                                        //         padding: const EdgeInsets.only(
                                        //             left: 0),
                                        //         child: Container(
                                        //           padding: EdgeInsets.all(2),
                                        //           decoration: BoxDecoration(
                                        //             color: Colors.white,
                                        //             shape: BoxShape.circle,
                                        //           ),
                                        //           child: Icon(
                                        //             Icons.favorite,
                                        //             color: Colors.red,
                                        //           ),
                                        //         ),
                                        //       )
                                        //     ],
                                        //   ),
                                        // )
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
            ),
          ],
        ),
      ),
    );
  }
}
