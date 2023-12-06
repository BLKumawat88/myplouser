import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myplo/controller/all_in_controller.dart';
import 'package:myplo/theme/common_theme.dart';
import 'package:myplo/theme/font_theme.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  late AllInProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AllInProvider>(context, listen: false);
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   provider.getAllNotification(context);
    // });
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
                  padding: const EdgeInsets.only(left: 30),
                  child: InkWell(
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
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Notification',
                    style: appbarTitle,
                  ),
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
                child: Consumer<AllInProvider>(
                  builder: (context, value, child) {
                    return provider.notificationList.isEmpty
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
                              ...provider.notificationList.map(
                                (e) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 30,
                                      vertical: 5,
                                    ),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromRGBO(141, 105, 227, 0.1),
                                        borderRadius: BorderRadius.circular(9),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 10,
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10),
                                                  child: CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(
                                                      e['imageUrl'],
                                                    ),
                                                  ),
                                                ),
                                                Flexible(
                                                  fit: FlexFit.loose,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Text(
                                                      e['message'],
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style:
                                                          NotificationPageTheme
                                                              .tileText,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              right: 10,
                                              bottom: 5,
                                            ),
                                            child: Text(
                                              e['timeAgo'],
                                              style: NotificationPageTheme
                                                  .timeText,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
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
