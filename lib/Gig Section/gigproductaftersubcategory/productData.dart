import 'package:flutter/material.dart';
import 'package:myplo/controller/all_in_controller.dart';
import 'package:myplo/theme/common_theme.dart';
import 'package:myplo/views/side_navigation_drawer/side_navigation_drawer.dart';
import 'package:provider/provider.dart';

import '../gigdetails/gig_details.dart';

class GigsDataScreen extends StatelessWidget {
  late AllInProvider provider;
  final List categoriesList = const [
    {'image': 'assets/images/gigs.png', 'title': 'Baby Shower'},
    {'image': 'assets/images/gigs.png', 'title': 'Bechelor Party'},
    {'image': 'assets/images/gigs.png', 'title': 'Birthday'},
    {'image': 'assets/images/gigs.png', 'title': 'Baby Shower'},
    {'image': 'assets/images/gigs.png', 'title': 'Bechelor Party'},
    {'image': 'assets/images/gigs.png', 'title': 'Birthday'},
  ];

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AllInProvider>(context, listen: false);
    // final argument = ModalRoute.of(context)!.settings.arguments as Map;

    final argument = "ABCD";

    return Scaffold(
      endDrawer: SideNavigationDrawer(
        argument: argument,
      ),
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
                                    argument,
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
            Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, mainAxisSpacing: 10),
                  itemCount: 8,
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GigDetailsScreen()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * .135,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15)),
                                  ),
                                  child: Image.asset(
                                    'assets/images/gridImage.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        'Gig Name',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF3C3C3C)),
                                      ),
                                      Text(
                                        '₹ 899',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF3C3C3C)),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: const [
                                      Text(
                                        '22 Hours Ago',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFFC1839F)),
                                      ),
                                      Text(
                                        'Karnatka,India',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFFC1839F)),
                                      ),
                                    ],
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                //   child: Row(
                                //     mainAxisAlignment: MainAxisAlignment.start,
                                //     children: [
                                //       Image.asset(
                                //         'assets/images/rating.png',
                                //         width: 60,
                                //       ),
                                //     ],
                                //   ),
                                // )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
