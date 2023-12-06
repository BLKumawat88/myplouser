import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myplo/controller/all_in_controller.dart';
import 'package:myplo/theme/common_theme.dart';
import 'package:provider/provider.dart';

class ReviewScreen extends StatelessWidget {
  ReviewScreen({super.key});

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
                  'Reviews',
                  style: appbarTitle,
                )
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
                    return provider.reviewsdata.isEmpty
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
                              ...provider.reviewsdata.map(
                                (e) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                      left: 30,
                                      right: 30,
                                      bottom: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF8D69E3).withOpacity(.1),
                                      borderRadius: BorderRadius.circular(9),
                                    ),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(e['imageUrl']),
                                      ),
                                      title: Text(
                                        e['fromName'],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.nunitoSans(
                                          color: Colors.black.withOpacity(.6),
                                          fontSize: 16,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 2,
                                          bottom: 2,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  size: 11,
                                                  color: Color(0xFFF903E3),
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  size: 11,
                                                  color: Color(0xFFF903E3),
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  size: 11,
                                                  color: Color(0xFFF903E3),
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  size: 11,
                                                  color: Color(0xFFF903E3),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              e['comment'],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.nunitoSans(
                                                color: Colors.black
                                                    .withOpacity(.6),
                                                fontSize: 12,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            )
                                          ],
                                        ),
                                      ),
                                      trailing: Padding(
                                        padding: const EdgeInsets.only(top: 40),
                                        child: Text(
                                          e['timeAgo'],
                                          style: GoogleFonts.nunitoSans(
                                            color: Color(0xFF828282),
                                            fontSize: 10,
                                            fontStyle: FontStyle.normal,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
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
