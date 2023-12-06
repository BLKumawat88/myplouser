import 'package:flutter/material.dart';

import '../giguserprofile/profile.dart';

class BuyGigScreem extends StatelessWidget {
  const BuyGigScreem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    Image.asset(
                      'assets/images/app_logo.png',
                      scale: 8,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "New Gig",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "7+ years of Experience in (SEO, Google Adwords, SMM & Reputation  Managementwith expertise in optimizing CMS websites Wordpress, Magento,  Shopify, Joomla,WIX, HTM/PHPWebstes etc. My aim is to provide High-Quality Serviceswith smart solutions",
                              style: TextStyle(color: Color(0xFFA9A9A9)),
                            ),
                            Text(
                              "₹ 499",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0XFF087E8B)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(children: [
                              Text("00-00-2023"),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.calendar_month,
                                color: Color(0XFFF903E3),
                              )
                            ]),
                          ),
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(children: [
                              Text("00-00-2023"),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.watch_later,
                                color: Color(0XFFF903E3),
                              )
                            ]),
                          ),
                        ),
                      ],
                    ),
                    Card(
                      child: ListTile(
                        title: Text(
                          "Owner",
                          style: TextStyle(color: Color(0xFF0A6DFE)),
                        ),
                        subtitle: Text(
                          'Anshul K',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        trailing: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GigUserProfile()),
                            );
                          },
                          child: Image.asset(
                            "assets/images/gigprofile.png",
                            width: 100,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Image.asset('assets/images/gigpaynow.png')
      ]),
    );
  }
}
