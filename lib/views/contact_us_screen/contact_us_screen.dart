import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myplo/controller/all_in_controller.dart';
import 'package:myplo/theme/common_theme.dart';
import 'package:myplo/theme/font_theme.dart';
import 'package:myplo/theme/text_form_fields_theme.dart';
import 'package:provider/provider.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  late AllInProvider provider;
  final formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController description = TextEditingController();
  String name = '';

  String? helpData;
  String selecthowCanWeHelpYou = "";
  List howCanWeHelpYouData = [
    {"helpData": "Technical Issues", "value": "TI"},
    {"helpData": "Shipping & Delivery Issues", "value": "SDI"},
    {"helpData": "Cancellation & Refunds", "value": "CR"},
    {"helpData": "Payment", "value": "PAY"},
  ];

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
                        'Contact Us',
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
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Contact Us',
                          style: GoogleFonts.firaSans(
                            color: Color(0xFF3C3C3C),
                            fontSize: 20,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            'Please tell us more about your request..',
                            style: GoogleFonts.firaSans(
                              color: Color(0xFF3C3C3C),
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Your Email Address',
                          style: GoogleFonts.firaSans(
                            color: Colors.black,
                            fontSize: 18,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: email,
                          decoration: InputDecoration(
                            border: AddressTextFormFieldsBorderTheme.border,
                            focusedBorder:
                                AddressTextFormFieldsBorderTheme.focusBorder,
                            enabledBorder:
                                AddressTextFormFieldsBorderTheme.enableBorder,
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: appCommonColor),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter email address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'How Can We Help You ?',
                          style: GoogleFonts.firaSans(
                            color: Colors.black,
                            fontSize: 18,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InputDecorator(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFEEF2F3),
                            contentPadding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 17,
                              bottom: 17,
                            ),
                            focusedBorder:
                                AddressTextFormFieldsBorderTheme.focusBorder,
                            enabledBorder:
                                AddressTextFormFieldsBorderTheme.enableBorder,
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: appCommonColor),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              icon: Icon(Icons.keyboard_arrow_down_sharp),
                              isDense: true,
                              value: selecthowCanWeHelpYou,
                              isExpanded: true,
                              menuMaxHeight: 350,
                              items: [
                                DropdownMenuItem(
                                  child: Text(
                                    "Select one...",
                                    style: AddAddressPageTheme.dropdownLabel,
                                  ),
                                  value: "",
                                ),
                                ...howCanWeHelpYouData
                                    .map<DropdownMenuItem<String>>((data) {
                                  return DropdownMenuItem(
                                    child: Text('${data['helpData']}'),
                                    value: data['helpData'],
                                  );
                                }).toList(),
                              ],
                              onChanged: (value) {
                                print("selected Value $value");
                                setState(() {
                                  helpData = value!;
                                  selecthowCanWeHelpYou = helpData.toString();
                                  print(helpData);
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          'Description',
                          style: GoogleFonts.firaSans(
                            color: Colors.black,
                            fontSize: 18,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          maxLines: 2,
                          controller: description,
                          decoration: InputDecoration(
                            border: AddressTextFormFieldsBorderTheme.border,
                            focusedBorder:
                                AddressTextFormFieldsBorderTheme.focusBorder,
                            enabledBorder:
                                AddressTextFormFieldsBorderTheme.enableBorder,
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: appCommonColor),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter description';
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: InkWell(
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                Map contactUsDetails = {
                                  'name': name,
                                  'email': email.text,
                                  'selectHowWecanHelpYou':
                                      selecthowCanWeHelpYou,
                                  'feedback': description.text,
                                };
                                provider.getAddContactUs(
                                    contactUsDetails, context);
                              }
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
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Send',
                                  style: GoogleFonts.firaSans(
                                    color: Color(0xFFECECEC),
                                    fontSize: 20,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
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
