import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myplo/controller/all_in_controller.dart';
import 'package:myplo/theme/common_theme.dart';
import 'package:provider/provider.dart';

class MoreInfo extends StatelessWidget {
  MoreInfo({super.key});
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
    final argument =
        ModalRoute.of(context)!.settings.arguments as List<Map<String, String>>;
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
                child: Column(
                  children: [
                    Container(
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: FittedBox(
                                  child: RichText(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      text: 'Buyer : ',
                                      style: title,
                                      children: [
                                        TextSpan(
                                          text: '${argument[0]['buyer']}',
                                          style: subtitle,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: '${argument[0]['status_completed']}',
                                  style: GoogleFonts.firaSans(
                                    color: Color(0xFF009E06),
                                    fontSize: 12,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          FittedBox(
                            child: RichText(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                text: 'Order Id : ',
                                style: title,
                                children: [
                                  TextSpan(
                                    text: '${argument[0]['orderId']}',
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
                                text: 'Order Date : ',
                                style: title,
                                children: [
                                  TextSpan(
                                    text: '${argument[0]['orderDate']}',
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
                                text: 'Amount :  ',
                                style: title,
                                children: [
                                  TextSpan(
                                    text: '\$ ${argument[0]['amount']}',
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
                                text: 'Status : ',
                                style: title,
                                children: [
                                  TextSpan(
                                    text: '${argument[0]['status']}',
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
                                text: 'Payout Status : ',
                                style: title,
                                children: [
                                  TextSpan(
                                    text: '${argument[0]['payoutStatus']}',
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
                                text: 'Shipment Date : ',
                                style: title,
                                children: [
                                  TextSpan(
                                    text: '${argument[0]['shipmentDate']}',
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
                                text: 'Shipment Fee : ',
                                style: title,
                                children: [
                                  TextSpan(
                                    text: '\$ ${argument[0]['shipmentFee']}',
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
                                text: 'Transaction Id : ',
                                style: title,
                                children: [
                                  TextSpan(
                                    text: '${argument[0]['transactionId']}',
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
                                text: 'Delevery Confirmed Date : ',
                                style: title,
                                children: [
                                  TextSpan(
                                    text:
                                        '${argument[0]['deliveryConfirmedDate']}',
                                    style: subtitle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          RichText(
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              text: 'Shipment Address : ',
                              style: title,
                              children: [
                                TextSpan(
                                  text: '${argument[0]['shipmentAddress']}',
                                  style: subtitle,
                                ),
                              ],
                            ),
                          ),
                          FittedBox(
                            child: RichText(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                text: 'Phone No : ',
                                style: title,
                                children: [
                                  TextSpan(
                                    text: '${argument[0]['phoneNo']}',
                                    style: subtitle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Container(
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
                          Text(
                            'Tracking Details',
                            style: title,
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Shipment Date : ',
                              style: title,
                              children: [
                                TextSpan(
                                  text: '${argument[1]['shipmentDate']}',
                                  style: subtitle,
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Shipment Method : ',
                              style: title,
                              children: [
                                TextSpan(
                                  text: '${argument[1]['shipmentMethod']}',
                                  style: subtitle,
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Tracking ID : ',
                              style: title,
                              children: [
                                TextSpan(
                                  text: '${argument[1]['trackingID']}',
                                  style: subtitle,
                                ),
                              ],
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Note : ',
                              style: title,
                              children: [
                                TextSpan(
                                  text: '${argument[1]['Note']}',
                                  style: subtitle,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
