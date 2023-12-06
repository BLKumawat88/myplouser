import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myplo/controller/all_in_controller.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProceedToPaymentScreen extends StatelessWidget {
  ProceedToPaymentScreen({super.key});

  late AllInProvider provider;
  String tokenToSaveOnServer = "";
  Future<void> getSecrateKeyToPay(productid, context, argument) async {
    AllInProvider provider = Provider.of(context, listen: false);
    print("IF $productid ${productid.runtimeType}");
    var headers = {
      'Content-Type': 'application/json',
      "Cookie": provider.authToken
    };
    var request = http.Request('POST', Uri.parse('https://myplo.com/graphql'));
    request.body =
        '''{"query":"mutation createStripeClientToken(\$data: tokenInput) {createStripeClientToken(data: \$data) {clientSecret}}","variables":{ "data":{"productId":$productid,"type":"instantBuy"}}}''';
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      Map data = json.decode(await response.stream.bytesToString());
      print(data);
      String opppp =
          "${data['data']['createStripeClientToken']['clientSecret']}";

      print(
          "Scrate key ::  ${data['data']['createStripeClientToken']['clientSecret']}");
      makePaymentNow(
          "${data['data']['createStripeClientToken']['clientSecret']}",
          context,
          productid,
          argument);

      String result1 = opppp.substring(0, opppp.indexOf('_') + 25);
      tokenToSaveOnServer = result1.toString();
      provider.requiredData['tokenId'] = tokenToSaveOnServer;
      print("token ID $tokenToSaveOnServer");
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AllInProvider>(context, listen: false);
    final argument = ModalRoute.of(context)!.settings.arguments as Map;
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
                  Text(
                    '',
                    style: GoogleFonts.firaSans(
                      color: Color(0xFF3C3C3C),
                      fontSize: 25,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
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
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(
                      top: 20,
                      left: 10,
                      bottom: 20,
                      right: 10,
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFF087E8B).withOpacity(.14),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(9),
                          child: Image.network(
                            provider.productDetail['images'][0],
                            height: MediaQuery.of(context).size.width / 4.5,
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.loose,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  provider.productDetail['title'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.firaSans(
                                    color: Color(0xFF3C3C3C),
                                    fontSize: 20,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    "Seller : ${provider.productDetail['userName']}",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    'Price : \$ ${provider.productDetail['rate']}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.firaSans(
                                      color: Color(0xFF087E8B),
                                      fontSize: 18,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    'Platform Fee:\$ 5.99',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.firaSans(
                                      color: Color(0xFF087E8B),
                                      fontSize: 14,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    'Shipping Price:\$ ${provider.shippingFee}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.firaSans(
                                      color: Color(0xFF087E8B),
                                      fontSize: 14,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    'Order Total :\$ ${provider.totalAmount}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.firaSans(
                                      color: Color(0xFF087E8B),
                                      fontSize: 14,
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(
                      top: 15,
                      left: 10,
                      bottom: 15,
                      right: 10,
                    ),
                    margin: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Shipping address',
                          style: GoogleFonts.firaSans(
                            color: Color(0xFF3C3C3C),
                            fontSize: 18,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            top: 10,
                          ),
                          child: Text(
                            argument['Name'],
                            style: GoogleFonts.firaSans(
                              color: Color(0xFF606060),
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            top: 5,
                          ),
                          child: Text(
                            argument['address1'],
                            style: GoogleFonts.firaSans(
                              color: Color(0xFF606060),
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                            left: 10,
                          ),
                          child: RichText(
                            text: TextSpan(
                              text: '${argument['city']} - ',
                              style: GoogleFonts.firaSans(
                                color: Color(0xFF606060),
                                fontSize: 16,
                                fontStyle: FontStyle.normal,
                              ),
                              children: [
                                TextSpan(
                                  text: argument['zipCode'],
                                  style: GoogleFonts.firaSans(
                                    color: Color(0xFF606060),
                                    fontSize: 16,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                            left: 10,
                          ),
                          child: Text(
                            argument['state'],
                            style: GoogleFonts.firaSans(
                              color: Color(0xFF606060),
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                            left: 10,
                          ),
                          child: Text(
                            argument['country'],
                            style: GoogleFonts.firaSans(
                              color: Color(0xFF606060),
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                  ),
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'Ph: ',
                                      style: GoogleFonts.firaSans(
                                        color: Color(0xFF606060),
                                        fontSize: 16,
                                        fontStyle: FontStyle.normal,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: argument['phoneNumber'],
                                          style: GoogleFonts.firaSans(
                                            color: Color(0xFF606060),
                                            fontSize: 16,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   padding: EdgeInsets.only(
                  //     top: 15,
                  //     left: 10,
                  //     bottom: 15,
                  //     right: 10,
                  //   ),
                  //   margin: EdgeInsets.symmetric(
                  //     horizontal: 20,
                  //     vertical: 20,
                  //   ),
                  //   decoration: BoxDecoration(
                  //     color: Colors.white,
                  //     borderRadius: BorderRadius.circular(12),
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Text(
                  //         'Add New Address',
                  //         style: GoogleFonts.firaSans(
                  //           color: Color(0xFF3C3C3C),
                  //           fontSize: 18,
                  //           fontStyle: FontStyle.normal,
                  //           fontWeight: FontWeight.w500,
                  //         ),
                  //       ),
                  //       InkWell(
                  //         onTap: () {
                  //           Navigator.pushNamed(context, '/buy_product_screen');
                  //         },
                  //         child: Container(
                  //           width: MediaQuery.of(context).size.width / 10,
                  //           decoration: BoxDecoration(
                  //             shape: BoxShape.circle,
                  //             color: Colors.grey.withOpacity(.2),
                  //           ),
                  //           child: Image.asset(
                  //             'assets/images/add_address.png',
                  //             scale: 5,
                  //           ),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                // print("${argument['_id']}");
                getSecrateKeyToPay(
                    int.parse(provider.productDetail['id']), context, argument);
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
                    'Proceed to Payment',
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
          ],
        ),
      ),
    );
  }
}

Future<void> makePaymentNow(secretID, context, pid, argument) async {
  try {
    await Stripe.instance
        .initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: secretID,
            applePay: PaymentSheetApplePay(
              merchantCountryCode: 'IN',
            ),
            googlePay: PaymentSheetGooglePay(
              merchantCountryCode: 'IN',
              testEnv: true,
            ),
            // applePay: PaymentSheetApplePay(merchantCountryCode: '+92'),
            // googlePay: PaymentSheetGooglePay(testEnv: true,)
            merchantDisplayName: "MyPLo",
          ),
        )
        .then((value) => print(" Payment Success"));
    displayPaymentSheet(context, pid, argument);
  } catch (error) {
    print("error $error");
  }
}

Future<void> displayPaymentSheet(context, pid, argument) async {
  AllInProvider provider = Provider.of(context, listen: false);
  try {
    await Stripe.instance.presentPaymentSheet().then((_) {
      print("Success");
      provider.submitProductinstantBuy(
          context, "instantBuy", pid, argument['_id']);
    });
  } catch (error) {
    print("Error $error");
  }
}
