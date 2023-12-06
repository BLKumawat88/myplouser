import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myplo/controller/all_in_controller.dart';
import 'package:myplo/model/profile_screen_model.dart';
import 'package:myplo/theme/font_theme.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  late AllInProvider provider;

  void logoutDialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Logout',
            style: GoogleFonts.firaSans(
              color: Colors.black,
              fontSize: 18,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
            ),
          ),
          content: Text(
            'Do you want to logout?',
            style: GoogleFonts.firaSans(
              color: Colors.black,
              fontSize: 15,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Color(0xFF3C3C3C),
                    ),
                    onPressed: () async {
                      final _storage = const FlutterSecureStorage();

                      await _storage.delete(key: 'isuser_myplo');
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/login', (route) => false);
                    },
                    child: Text('Logout'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Color(0xFF3C3C3C),
                      ),
                    ),
                  ),
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
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/edit_profile_screen',
                      );
                    },
                    child: Consumer<AllInProvider>(
                      builder: (context, value, child) => Row(
                        children: [
                          Center(
                            child: CircleAvatar(
                              backgroundColor: Color(0xFFC4C4C4),
                              radius: 30,
                              backgroundImage:
                                  // AssetImage('assets/images/profile.jpg'),
                                  NetworkImage(
                                      '${provider.userProfileData['profileImage']}'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  provider.userProfileData['userName'],
                                  style: GoogleFonts.firaSans(
                                    color: Color(0xFF5F5F5F),
                                    fontSize: 22,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  'View and edit Profile',
                                  style: GoogleFonts.firaSans(
                                    color: Color(0xFF5F5F5F),
                                    fontSize: 12,
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
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              color: Color(0xFFD9D9D9),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      ...profile.map(
                        (e) {
                          return InkWell(
                            onTap: () {
                              int index = profile.indexOf(e);
                              print(index);

                              if (index == 0) {
                                Navigator.pushNamed(
                                  context,
                                  '/selling_screen',
                                );
                              }
                              if (index == 1) {
                                Navigator.pushNamed(
                                  context,
                                  '/sold_screen',
                                );
                              }
                              if (index == 2) {
                                Navigator.pushNamed(
                                  context,
                                  '/sales_screen',
                                );
                              }
                              if (index == 3) {
                                Navigator.pushNamed(
                                  context,
                                  '/review_screen',
                                );
                              }
                              // if (index == 4) {
                              //   Navigator.pushNamed(
                              //     context,
                              //     '/setting_screen',
                              //   );
                              // }
                              if (index == 4) {
                                Navigator.pushNamed(
                                  context,
                                  '/support_password_screen',
                                );
                                provider.getSiteInfo();
                              }
                              if (index == 6) {
                                Navigator.pushNamed(
                                  context,
                                  '/about_screen',
                                );
                                provider.getStaticPageDetails(context);
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                color: Color(0xFFD4E4E6),
                                borderRadius: BorderRadius.circular(22),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 20,
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    e.icon,
                                    width: 25,
                                    color: Color(0xFF5F5F5F),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Flexible(
                                    fit: FlexFit.loose,
                                    flex: 1,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          e.title,
                                          style:
                                              CommonFontTheme.profileTileTitle,
                                        ),
                                        Text(
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          e.subtitle,
                                          style: CommonFontTheme
                                              .profileTileSubtitle,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ).toList(),
                      SizedBox(
                        height: 20,
                      ),
                      // IconButton(
                      //   onPressed: () {
                      //     // provider.sendMessage(context);
                      //     // provider.getMessage(context);
                      //     // provider.createRoom();
                      //   },
                      //   icon: Icon(Icons.send),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                logoutDialog(context);
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF0A6DFE),
                      Color(0xFFF903E3),
                    ],
                  ),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Logout',
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
            // Padding(
            //   padding: const EdgeInsets.only(
            //     top: 10,
            //     left: 20,
            //     right: 20,
            //     bottom: 10,
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       InkWell(
            //         onTap: () {},
            //         child: Container(
            //           width: MediaQuery.of(context).size.width / 2.5,
            //           padding: EdgeInsets.symmetric(vertical: 10),
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(12),
            //             border: Border.all(
            //               color: Color(0xFf3C3C3C),
            //             ),
            //           ),
            //           child: Text(
            //             textAlign: TextAlign.center,
            //             'Feedback',
            //             style: GoogleFonts.firaSans(
            //               color: Color(0xFF3C3C3C),
            //               fontSize: 18,
            //               fontStyle: FontStyle.normal,
            //               fontWeight: FontWeight.w500,
            //             ),
            //           ),
            //         ),
            //       ),
            //       InkWell(
            //         onTap: () {
            //           logoutDialog(context);
            //         },
            //         child: Container(
            //           width: MediaQuery.of(context).size.width / 2.5,
            //           padding: EdgeInsets.symmetric(vertical: 10),
            //           decoration: BoxDecoration(
            //             border: Border.all(
            //               color: Color(0xFF3C3C3C),
            //             ),
            //             color: Color(0xFF3C3C3C),
            //             borderRadius: BorderRadius.circular(12),
            //           ),
            //           child: Text(
            //             textAlign: TextAlign.center,
            //             'Logout',
            //             style: GoogleFonts.firaSans(
            //               color: Colors.white,
            //               fontSize: 18,
            //               fontStyle: FontStyle.normal,
            //               fontWeight: FontWeight.w500,
            //             ),
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
