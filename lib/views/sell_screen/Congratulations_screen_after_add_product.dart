import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:myplo/controller/all_in_controller.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CongratulationsScreen extends StatefulWidget {
  const CongratulationsScreen({super.key});
  @override
  State<CongratulationsScreen> createState() => _CongratulationsScreenState();
}

class _CongratulationsScreenState extends State<CongratulationsScreen> {
  String tokenToSaveOnServer = "";

  Future<void> getSecrateKeyToPay(featuredId, context) async {
    AllInProvider provider = Provider.of(context, listen: false);

    print("featuredId $featuredId");

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST', Uri.parse('http://myplo.itworkshop.in:4000/graphql'));
    request.body =
        '''{"query":"mutation createStripeClientToken(\$data: tokenInput) {\\r\\n        createStripeClientToken(data: \$data) {\\r\\n            clientSecret\\r\\n        }\\r\\n    }","variables":{"data":{"featuredId":$featuredId}}}''';

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
          context);

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
    AllInProvider provider = Provider.of(context, listen: false);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("APP"),
        leading: InkWell(
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/bottom_navigation',
              (route) => false,
            );
          },
          child: Icon(
            Icons.close,
            color: Colors.black,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      "Congratulations!",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Your listing has been posted!"),
                    SizedBox(
                      height: 20,
                    ),
                    Text("REACH MORE BUYERS AND SELL FASTER"),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Upgrade your Product to a top position"),
                    SizedBox(
                      height: 20,
                    ),
                    Consumer<AllInProvider>(
                      builder: ((context, value, child) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ...provider.listOfFeatured
                                  .map(
                                    (e) => InkWell(
                                      onTap: () {
                                        setState(
                                          () {
                                            provider.activatedButtonStatus =
                                                e['name'];
                                            provider.feeToPay = e['price'];
                                            provider.payId = e['id'];
                                          },
                                        );
                                      },
                                      child: Container(
                                        height: 40,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 2,
                                            color: Color(0xFFe71de1),
                                          ),
                                          color:
                                              provider.activatedButtonStatus ==
                                                      e['name']
                                                  ? Color(0xFFe71de1)
                                                  : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        child: Center(
                                          child: Text(
                                            e['name'],
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color:
                                                  provider.activatedButtonStatus ==
                                                          e['name']
                                                      ? Colors.white
                                                      : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text("Featured tag shown for 24 hours only!!"),
                  ],
                ),
                Image.asset('assets/images/cong.png'),
                Consumer<AllInProvider>(
                  builder: ((context, value, child) => InkWell(
                        onTap: () {
                          getSecrateKeyToPay(provider.payId, context);
                        },
                        child: Container(
                          height: 50,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Color(0xFFe71de1),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              "Feature It For \$ ${provider.feeToPay}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Future<void> makePaymentNow(secretID, context) async {
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
    displayPaymentSheet(context);
  } catch (error) {
    print("error $error");
  }
}

Future<void> displayPaymentSheet(context) async {
  AllInProvider provider = Provider.of(context, listen: false);
  try {
    await Stripe.instance.presentPaymentSheet().then((_) {
      print("Success");
      provider.submitProductBoostDataAfterPaymentSuccess(context, "featured");
    });
  } catch (error) {
    print("Error $error");
  }
}
