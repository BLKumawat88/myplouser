import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myplo/controller/all_in_controller.dart';
import 'package:provider/provider.dart';

class SideNavigationDrawer extends StatefulWidget {
  final argument;
  SideNavigationDrawer({super.key, required this.argument});

  @override
  State<SideNavigationDrawer> createState() => _SideNavigationDrawerState();
}

class _SideNavigationDrawerState extends State<SideNavigationDrawer> {
  List filterData = [];

  @override
  void initState() {
    super.initState();
    filterData.addAll(widget.argument['fields']);
  }

  late AllInProvider provider;

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   width: MediaQuery.of(context).size.width / 1.5,
    //   decoration: BoxDecoration(
    //     color: Colors.white,
    //     borderRadius: BorderRadius.circular(12),
    //   ),
    //   child: SingleChildScrollView(
    //     physics: BouncingScrollPhysics(),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Padding(
    //           padding: const EdgeInsets.only(
    //             left: 20,
    //             right: 20,
    //             top: 20,
    //           ),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Text(
    //                 'FILTERS',
    //                 style: GoogleFonts.firaSans(
    //                   color: Color(0xFF3C3C3C),
    //                   fontSize: 16,
    //                   fontStyle: FontStyle.normal,
    //                   fontWeight: FontWeight.w500,
    //                 ),
    //               ),
    //               InkWell(
    //                 onTap: () {
    //                   setState(() {
    //                     x3 = false;
    //                     x4 = false;
    //                     cClass = false;
    //                     glsClass = false;
    //                     model3 = false;
    //                     modelS = false;
    //                     used = false;
    //                     newPurchase = false;
    //                   });
    //                 },
    //                 child: Text(
    //                   'Clear Filters',
    //                   style: GoogleFonts.firaSans(
    //                     color: Color(0xFFF903E3),
    //                     fontSize: 16,
    //                     fontStyle: FontStyle.normal,
    //                     fontWeight: FontWeight.w500,
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.only(left: 20, top: 15),
    //           child: Text(
    //             'BMW',
    //             style: GoogleFonts.firaSans(
    //               color: Color(0xFF3C3C3C),
    //               fontSize: 16,
    //               fontStyle: FontStyle.normal,
    //               fontWeight: FontWeight.w500,
    //             ),
    //           ),
    //         ),
    //         Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Row(
    //               children: [
    //                 Checkbox(
    //                   shape: RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.circular(4),
    //                   ),
    //                   value: x3,
    //                   onChanged: (value) {
    //                     setState(() {
    //                       x3 = value as bool;
    //                     });
    //                     print(value);
    //                   },
    //                 ),
    //                 Text(
    //                   'X3',
    //                   style: GoogleFonts.firaSans(
    //                     color: Color(0xFF3C3C3C),
    //                     fontSize: 16,
    //                     fontStyle: FontStyle.normal,
    //                     fontWeight: FontWeight.w400,
    //                   ),
    //                 )
    //               ],
    //             ),
    //             Row(
    //               children: [
    //                 Checkbox(
    //                   shape: RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.circular(4),
    //                   ),
    //                   value: x4,
    //                   onChanged: (value) {
    //                     setState(() {
    //                       x4 = value as bool;
    //                     });
    //                   },
    //                 ),
    //                 Text(
    //                   'X4',
    //                   style: GoogleFonts.firaSans(
    //                     color: Color(0xFF3C3C3C),
    //                     fontSize: 16,
    //                     fontStyle: FontStyle.normal,
    //                     fontWeight: FontWeight.w400,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.only(left: 20, top: 15),
    //           child: Text(
    //             'Benz',
    //             style: GoogleFonts.firaSans(
    //               color: Color(0xFF3C3C3C),
    //               fontSize: 16,
    //               fontStyle: FontStyle.normal,
    //               fontWeight: FontWeight.w500,
    //             ),
    //           ),
    //         ),
    //         Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Row(
    //               children: [
    //                 Checkbox(
    //                   shape: RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.circular(4),
    //                   ),
    //                   value: cClass,
    //                   onChanged: (value) {
    //                     setState(() {
    //                       cClass = value as bool;
    //                     });
    //                   },
    //                 ),
    //                 Text(
    //                   'C-Class',
    //                   style: GoogleFonts.firaSans(
    //                     color: Color(0xFF3C3C3C),
    //                     fontSize: 16,
    //                     fontStyle: FontStyle.normal,
    //                     fontWeight: FontWeight.w400,
    //                   ),
    //                 )
    //               ],
    //             ),
    //             Row(
    //               children: [
    //                 Checkbox(
    //                   shape: RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.circular(4),
    //                   ),
    //                   value: glsClass,
    //                   onChanged: (value) {
    //                     setState(() {
    //                       glsClass = value as bool;
    //                     });
    //                   },
    //                 ),
    //                 Text(
    //                   'GLS- Class',
    //                   style: GoogleFonts.firaSans(
    //                     color: Color(0xFF3C3C3C),
    //                     fontSize: 16,
    //                     fontStyle: FontStyle.normal,
    //                     fontWeight: FontWeight.w400,
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ],
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.only(left: 20, top: 15),
    //           child: Text(
    //             'Tesla',
    //             style: GoogleFonts.firaSans(
    //               color: Color(0xFF3C3C3C),
    //               fontSize: 16,
    //               fontStyle: FontStyle.normal,
    //               fontWeight: FontWeight.w500,
    //             ),
    //           ),
    //         ),
    //         Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Row(
    //               children: [
    //                 Checkbox(
    //                   shape: RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.circular(4),
    //                   ),
    //                   value: model3,
    //                   onChanged: (value) {
    //                     setState(() {
    //                       model3 = value as bool;
    //                     });
    //                   },
    //                 ),
    //                 Text(
    //                   'Model 3',
    //                   style: GoogleFonts.firaSans(
    //                     color: Color(0xFF3C3C3C),
    //                     fontSize: 16,
    //                     fontStyle: FontStyle.normal,
    //                     fontWeight: FontWeight.w400,
    //                   ),
    //                 )
    //               ],
    //             ),
    //             Row(
    //               children: [
    //                 Checkbox(
    //                   shape: RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.circular(4),
    //                   ),
    //                   value: modelS,
    //                   onChanged: (value) {
    //                     setState(() {
    //                       modelS = value as bool;
    //                     });
    //                   },
    //                 ),
    //                 Text(
    //                   'Model S',
    //                   style: GoogleFonts.firaSans(
    //                     color: Color(0xFF3C3C3C),
    //                     fontSize: 16,
    //                     fontStyle: FontStyle.normal,
    //                     fontWeight: FontWeight.w400,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.only(left: 20, top: 15),
    //           child: Text(
    //             'Condition',
    //             style: GoogleFonts.firaSans(
    //               color: Color(0xFF3C3C3C),
    //               fontSize: 16,
    //               fontStyle: FontStyle.normal,
    //               fontWeight: FontWeight.w500,
    //             ),
    //           ),
    //         ),
    //         Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Row(
    //               children: [
    //                 Checkbox(
    //                   shape: RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.circular(4),
    //                   ),
    //                   value: used,
    //                   onChanged: (value) {
    //                     setState(() {
    //                       used = value as bool;
    //                     });
    //                   },
    //                 ),
    //                 Text(
    //                   'Used',
    //                   style: GoogleFonts.firaSans(
    //                     color: Color(0xFF3C3C3C),
    //                     fontSize: 16,
    //                     fontStyle: FontStyle.normal,
    //                     fontWeight: FontWeight.w400,
    //                   ),
    //                 )
    //               ],
    //             ),
    //             Row(
    //               children: [
    //                 Checkbox(
    //                   shape: RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.circular(4),
    //                   ),
    //                   value: newPurchase,
    //                   onChanged: (value) {
    //                     setState(() {
    //                       newPurchase = value as bool;
    //                     });
    //                   },
    //                 ),
    //                 Text(
    //                   'New',
    //                   style: GoogleFonts.firaSans(
    //                     color: Color(0xFF3C3C3C),
    //                     fontSize: 16,
    //                     fontStyle: FontStyle.normal,
    //                     fontWeight: FontWeight.w400,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.only(
    //             left: 20,
    //             top: 15,
    //           ),
    //           child: Text(
    //             'Mileage (MI)',
    //             style: GoogleFonts.firaSans(
    //               color: Color(0xFF3C3C3C),
    //               fontSize: 16,
    //               fontStyle: FontStyle.normal,
    //               fontWeight: FontWeight.w400,
    //             ),
    //           ),
    //         ),
    //         Slider(
    //           value: value.toDouble(),
    //           min: 1,
    //           max: 10000,
    //           activeColor: Color(0xFFF903E3),
    //           inactiveColor: Color(0xFFF903E3),
    //           onChanged: (values) {
    //             setState(() {
    //               value = values.round();
    //             });
    //             print(value);
    //           },
    //           // semanticFormatterCallback: (double newValue) {
    //           //   return '${newValue.round()} dollars';
    //           // },
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.only(top: 10, bottom: 15),
    //           child: Center(
    //             child: Container(
    //               width: MediaQuery.of(context).size.width / 2,
    //               padding: EdgeInsets.symmetric(vertical: 12),
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(8),
    //                 gradient: LinearGradient(
    //                   colors: [
    //                     Color(0xFF0A6DFE),
    //                     Color(0xFFF903E3),
    //                   ],
    //                 ),
    //               ),
    //               child: Text(
    //                 textAlign: TextAlign.center,
    //                 'Save Filters',
    //                 style: GoogleFonts.firaSans(
    //                   color: Colors.white,
    //                   fontSize: 16,
    //                   fontStyle: FontStyle.normal,
    //                   fontWeight: FontWeight.w400,
    //                 ),
    //               ),
    //             ),
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
    provider = Provider.of<AllInProvider>(context, listen: false);
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      // height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'FILTERS',
                    style: GoogleFonts.firaSans(
                      color: Color(0xFF3C3C3C),
                      fontSize: 16,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'Clear Filters',
                      style: GoogleFonts.firaSans(
                        color: Color(0xFFF903E3),
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...filterData.map((data) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      data['inputTag'] == 'multilevel'
                          ? Column(
                              children: [
                                ...data['values']
                                    .map(
                                      (multilevelData) => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, top: 15),
                                            child: Text(
                                              '${multilevelData['valueParent']}',
                                              style: GoogleFonts.firaSans(
                                                color: Color(0xFF3C3C3C),
                                                fontSize: 16,
                                                fontStyle: FontStyle.normal,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          ...multilevelData['valueChild']
                                              .map((multilevelValueChild) {
                                            return Row(
                                              children: [
                                                Checkbox(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  value: multilevelValueChild[
                                                      'valueChildSelected'],
                                                  onChanged: (value) {
                                                    print(
                                                      'multilevel id ${multilevelValueChild['valueChildId']}',
                                                    );
                                                    setState(() {
                                                      multilevelValueChild[
                                                              'valueChildSelected'] =
                                                          value!;
                                                    });
                                                  },
                                                ),
                                                Text(
                                                  multilevelValueChild[
                                                      'valueChildData'],
                                                  style: GoogleFonts.firaSans(
                                                    color: Color(0xFF3C3C3C),
                                                    fontSize: 16,
                                                    fontStyle: FontStyle.normal,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            );
                                          }).toList()
                                        ],
                                      ),
                                    )
                                    .toList(),
                              ],
                            )
                          : data['inputTag'] == 'dropdown'
                              ? Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, top: 15),
                                          child: Text(
                                            '${data['name']}',
                                            style: GoogleFonts.firaSans(
                                              color: Color(0xFF3C3C3C),
                                              fontSize: 16,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        ...data['values'][0]['valueChild']
                                            .map((multilevelValueChild) {
                                          return Row(
                                            children: [
                                              Checkbox(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                value: multilevelValueChild[
                                                    'valueChildSelected'],
                                                onChanged: (value) {
                                                  print(
                                                    'dropdown id ${multilevelValueChild['valueChildId']}',
                                                  );
                                                  setState(
                                                    () {
                                                      multilevelValueChild[
                                                              'valueChildSelected'] =
                                                          value!;
                                                    },
                                                  );
                                                },
                                              ),
                                              Text(
                                                multilevelValueChild[
                                                    'valueChildData'],
                                                style: GoogleFonts.firaSans(
                                                  color: Color(0xFF3C3C3C),
                                                  fontSize: 16,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          );
                                        }).toList()
                                      ],
                                    ),
                                  ],
                                )
                              // : data['inputTag'] == 'range'
                              //     ? Column(
                              //         crossAxisAlignment:
                              //             CrossAxisAlignment.start,
                              //         children: [
                              //           Padding(
                              //             padding: const EdgeInsets.only(
                              //                 left: 20, top: 15),
                              //             child: Text(
                              //               '${data['name']}',
                              //               style: GoogleFonts.firaSans(
                              //                 color: Color(0xFF3C3C3C),
                              //                 fontSize: 16,
                              //                 fontStyle: FontStyle.normal,
                              //                 fontWeight: FontWeight.w500,
                              //               ),
                              //             ),
                              //           ),
                              //           Consumer<AllInProvider>(
                              //             builder: (context, value, child) {
                              //               return RangeSlider(
                              //                 divisions: data['max'],
                              //                 values:
                              //                     provider.currentRangeValues,
                              //                 min: data['min'].toDouble(),
                              //                 max: data['max'].toDouble(),
                              //                 labels: RangeLabels(
                              //                   provider
                              //                       .currentRangeValues.start
                              //                       .round()
                              //                       .toString(),
                              //                   provider.currentRangeValues.end
                              //                       .round()
                              //                       .toString(),
                              //                   // data['min'].round().toString(),
                              //                   // data['max'].round().toString(),
                              //                 ),
                              //                 onChanged: (value) {
                              //                   provider
                              //                       .updateRangeValue(value);
                              //                 },
                              //               );
                              //             },
                              //           ),
                              //         ],
                              //       )
                              : SizedBox(),
                    ],
                  );
                }).toList(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(" Save Filters "),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
