import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myplo/controller/all_in_controller.dart';
import 'package:myplo/theme/common_theme.dart';
import 'package:provider/provider.dart';

class SalesScreen extends StatelessWidget {
  SalesScreen({super.key});

  late AllInProvider provider;

  final title = GoogleFonts.firaSans(
    color: Color(0xFF616161),
    fontSize: 16,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
  );

  final subtitle = GoogleFonts.firaSans(
    color: Color(0xFF616161),
    fontSize: 16,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
  );

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AllInProvider>(context, listen: false);
    //First widget make then getting user data
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.getSalesData();
    });

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
                  'Sales',
                  style: appbarTitle,
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Color(0xFFD9D9D9),
              thickness: 1,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Consumer<AllInProvider>(
                  builder: (context, value, child) {
                    return Column(
                      children: [
                        ...provider.salesData.map(
                          (e) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              margin: EdgeInsets.symmetric(
                                horizontal: 25,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFFD4E4E6),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: FittedBox(
                                          child: RichText(
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            text: TextSpan(
                                              text: 'Buyer :   ',
                                              style: title,
                                              children: [
                                                TextSpan(
                                                  text: e[0]['buyer'],
                                                  style: subtitle,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          print(
                                            'Instance of sales data :- $e',
                                          );
                                          Navigator.pushNamed(
                                            context,
                                            '/more_info_screen',
                                            arguments: e,
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              ' More Info',
                                              style: GoogleFonts.firaSans(
                                                color: Color(0xFF009E06),
                                                fontSize: 12,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: 11,
                                              color: Color(0xFF009E06),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  FittedBox(
                                    child: RichText(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      text: TextSpan(
                                        text: 'Order Id :   ',
                                        style: title,
                                        children: [
                                          TextSpan(
                                            text: e[0]['orderId'],
                                            style: subtitle,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  FittedBox(
                                    child: RichText(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      text: TextSpan(
                                        text: 'Order Date :   ',
                                        style: title,
                                        children: [
                                          TextSpan(
                                            text: e[0]['orderDate'],
                                            style: subtitle,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  FittedBox(
                                    child: RichText(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      text: TextSpan(
                                        text: 'Amount :   ',
                                        style: title,
                                        children: [
                                          TextSpan(
                                            text: '\$ ${e[0]['amount']}',
                                            style: subtitle,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  FittedBox(
                                    child: RichText(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      text: TextSpan(
                                        text: 'Status :   ',
                                        style: title,
                                        children: [
                                          TextSpan(
                                            text: e[0]['status'],
                                            style: subtitle,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  FittedBox(
                                    child: RichText(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      text: TextSpan(
                                        text: 'Payout Status :   ',
                                        style: title,
                                        children: [
                                          TextSpan(
                                            text: e[0]['payoutStatus'],
                                            style: subtitle,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
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
