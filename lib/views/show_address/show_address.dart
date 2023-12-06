import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myplo/controller/all_in_controller.dart';
import 'package:provider/provider.dart';

class ShowAddressScreen extends StatelessWidget {
  ShowAddressScreen({super.key});

  late AllInProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AllInProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    'Address',
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
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Consumer<AllInProvider>(
                        builder: (context, value, child) {
                          return Column(
                            children: [
                              ...provider.alreadyAddedAddress.map(
                                (e) {
                                  return Card(
                                    elevation: 3,
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      margin: EdgeInsets.symmetric(vertical: 5),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  provider.getDataToEditAddress(
                                                    context,
                                                    e,
                                                  );
                                                },
                                                icon: Icon(Icons.edit),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  provider
                                                      .deleteShippingAddress(
                                                    context,
                                                    e['_id'],
                                                  );
                                                },
                                                icon: Icon(Icons.delete),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            e['Name'],
                                            style: GoogleFonts.firaSans(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontStyle: FontStyle.normal,
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: Text(
                                              e['address1'],
                                              style: GoogleFonts.firaSans(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontStyle: FontStyle.normal,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: RichText(
                                              text: TextSpan(
                                                text: '${e['city']} - ',
                                                style: GoogleFonts.firaSans(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontStyle: FontStyle.normal,
                                                ),
                                                children: [
                                                  TextSpan(
                                                    text: e['zipCode'],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: Text(
                                              e['state'],
                                              style: GoogleFonts.firaSans(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontStyle: FontStyle.normal,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: Text(
                                              e['country'],
                                              style: GoogleFonts.firaSans(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontStyle: FontStyle.normal,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 15,
                                              bottom: 10,
                                            ),
                                            child: Text(
                                              e['phoneNumber'],
                                              style: GoogleFonts.firaSans(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontStyle: FontStyle.normal,
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color(0xFFF903E3),
                                                ),
                                                onPressed: () {
                                                  provider.getShippingRate(
                                                      context,
                                                      provider
                                                          .alreadyAddedAddress
                                                          .indexOf(e));
                                                  // Navigator.pushNamed(
                                                  //   context,
                                                  //   '/proceed_to_payment_screen',
                                                  //   arguments: e,
                                                  // );
                                                },
                                                child: Text(
                                                  'Continue',
                                                  style: GoogleFonts.firaSans(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontStyle: FontStyle.normal,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
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
                      SizedBox(
                        height: 18,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
