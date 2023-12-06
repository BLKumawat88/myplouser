import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myplo/controller/all_in_controller.dart';
import 'package:myplo/theme/common_theme.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatelessWidget {
  SupportScreen({super.key});
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
                  Flexible(
                    child: FittedBox(
                      child: Text(
                        'Help & Support',
                        style: appbarTitle,
                      ),
                    ),
                  )
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
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, '/faq_screen');
                      },
                      title: Text(
                        'Help Center',
                        style: GoogleFonts.firaSans(
                          color: Color(0xFF3C3C3C),
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      subtitle: Text(
                        'See FAQ and contact support',
                        style: GoogleFonts.firaSans(
                          color: Color(0xFF656565),
                          fontSize: 14,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Divider(
                      color: Color(0xFFD9D9D9),
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, '/contact_us_screen');
                      },
                      title: Text(
                        'Contact Us',
                        style: GoogleFonts.firaSans(
                          color: Color(0xFF3C3C3C),
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      subtitle: Text(
                        'Please tell us more about your request..',
                        style: GoogleFonts.firaSans(
                          color: Color(0xFF656565),
                          fontSize: 14,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Divider(
                      color: Color(0xFFD9D9D9),
                    ),
                    ListTile(
                      title: Text(
                        'Rate us',
                        style: GoogleFonts.firaSans(
                          color: Color(0xFF3C3C3C),
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      subtitle: Text(
                        'If you love our app, please take a moment to rate it',
                        style: GoogleFonts.firaSans(
                          color: Color(0xFF656565),
                          fontSize: 14,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Divider(
                      color: Color(0xFFD9D9D9),
                    ),
                    ListTile(
                      onTap: () {},
                      title: Text(
                        'Version',
                        style: GoogleFonts.firaSans(
                          color: Color(0xFF3C3C3C),
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      subtitle: Text(
                        '18.18.18',
                        style: GoogleFonts.firaSans(
                          color: Color(0xFF656565),
                          fontSize: 14,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Divider(
                      color: Color(0xFFD9D9D9),
                    ),
                    ListTile(
                      onTap: () async {
                        final Uri urlFacebook =
                            Uri.parse(provider.onlineLinks['facebook']);

                        await launchUrl(urlFacebook);
                      },
                      title: Text(
                        'Facebook',
                        style: GoogleFonts.firaSans(
                          color: Color(0xFF3C3C3C),
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      trailing: Icon(
                        Icons.facebook,
                        color: Color(0xFF087AEA),
                        size: MediaQuery.of(context).size.width / 14,
                      ),
                    ),
                    Divider(
                      color: Color(0xFFD9D9D9),
                    ),
                    ListTile(
                      onTap: () async {
                        provider.onlineLinks['twitter'];

                        final Uri urlTwitter =
                            Uri.parse(provider.onlineLinks['twitter']);

                        await launchUrl(urlTwitter);
                      },
                      title: Text(
                        'Twitter',
                        style: GoogleFonts.firaSans(
                          color: Color(0xFF3C3C3C),
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      trailing: Image.asset(
                        'assets/images/twitter.png',
                        width: MediaQuery.of(context).size.width / 14,
                      ),
                    ),
                    Divider(
                      color: Color(0xFFD9D9D9),
                    ),
                    ListTile(
                      onTap: () async {
                        final Uri urlInastagram =
                            Uri.parse(provider.onlineLinks['instagram']);

                        await launchUrl(urlInastagram);
                      },
                      title: Text(
                        'Instagram',
                        style: GoogleFonts.firaSans(
                          color: Color(0xFF3C3C3C),
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      trailing: Image.asset(
                        'assets/images/instagram.png',
                        width: MediaQuery.of(context).size.width / 14,
                      ),
                    ),
                    Divider(
                      color: Color(0xFFD9D9D9),
                    ),
                    ListTile(
                      onTap: () async {
                        final Uri urlYoutube =
                            Uri.parse(provider.onlineLinks['youtube']);

                        await launchUrl(urlYoutube);
                      },
                      title: Text(
                        'Youtube',
                        style: GoogleFonts.firaSans(
                          color: Color(0xFF3C3C3C),
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      trailing: Image.asset(
                        'assets/images/youtube.png',
                        width: MediaQuery.of(context).size.width / 14,
                      ),
                    ),
                    Divider(
                      color: Color(0xFFD9D9D9),
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
