import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myplo/controller/all_in_controller.dart';
import 'package:provider/provider.dart';

class UserChatScreenTest extends StatelessWidget {
  UserChatScreenTest({super.key});

  late AllInProvider provider;

  final formKey = GlobalKey<FormState>();
  TextEditingController message = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   provider.getUserChatData();
    // });
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
                  Expanded(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                '${provider.userProfile}',
                              ),
                            ),
                            // Positioned(
                            //   bottom: 0,
                            //   right: 5,
                            //   child: Container(
                            //     width: 14,
                            //     height: 14,
                            //     decoration: BoxDecoration(
                            //       color: argument['status']
                            //           ? Colors.green
                            //           : Colors.grey,
                            //       shape: BoxShape.circle,
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text('${provider.userName}'),
                        )
                      ],
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
              thickness: 1,
            ),
            Text(
              'Today',
              style: GoogleFonts.nunitoSans(
                color: Color(0xFF9A9A9A),
                fontSize: 14,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400,
              ),
            ),
            Consumer<AllInProvider>(
              builder: (context, value, child) {
                return Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          ...provider.chatMessageData['message'].map((e) {
                            return Row(
                              mainAxisAlignment:
                                  e['userId'] != int.parse(provider.userId)
                                      ? MainAxisAlignment.start
                                      : MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                e['userId'] != int.parse(provider.userId)
                                    ? CircleAvatar(
                                        radius: 20,
                                        backgroundImage: NetworkImage(
                                          '${e['profileImage']}',
                                        ),
                                      )
                                    : SizedBox(),
                                Flexible(
                                  child: Card(
                                    margin: EdgeInsets.only(
                                      top: 20,
                                      left: 10,
                                      right: 10,
                                    ),
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: e['userId'] !=
                                              int.parse(provider.userId)
                                          ? BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                            )
                                          : BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                            ),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: e['userId'] !=
                                                int.parse(provider.userId)
                                            ? Colors.white
                                            : Color(0xFFF903E3),
                                        borderRadius: e['userId'] !=
                                                int.parse(provider.userId)
                                            ? BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              )
                                            : BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                                bottomLeft: Radius.circular(10),
                                              ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            e['message'],
                                            style: GoogleFonts.nunitoSans(
                                              color: e['userId'] !=
                                                      int.parse(provider.userId)
                                                  ? Color(0xFF9A9A9A)
                                                  : Colors.white,
                                              fontSize: 14,
                                              fontStyle: FontStyle.normal,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          // e['userId'] !=
                                          //         int.parse(provider.userId)
                                          //     ? Text(
                                          //         '9:43 AM',
                                          //         style: GoogleFonts.nunitoSans(
                                          //           color: Color(0xFF9A9A9A),
                                          //           fontSize: 14,
                                          //           fontStyle: FontStyle.normal,
                                          //           fontWeight: FontWeight.w400,
                                          //         ),
                                          //       )
                                          //     : Text(
                                          //         '',
                                          //         style: GoogleFonts.nunitoSans(
                                          //           color: Colors.white
                                          //               .withOpacity(.5),
                                          //           fontSize: 14,
                                          //           fontStyle: FontStyle.normal,
                                          //           fontWeight: FontWeight.w400,
                                          //         ),
                                          //       ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // e['chat'] == 1 ? Text(e['time']) : SizedBox(),
                              ],
                            );
                          }).toList(),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 15,
                ),
                child: TextFormField(
                  controller: message,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(22),
                      borderSide: BorderSide(
                        color: Color(0xFFA1A1A1),
                      ),
                    ),
                    hintText: 'Write your message',
                    hintStyle: TextStyle(
                      color: Color(0xFFA1A1A1),
                    ),
                    suffixIcon: InkWell(
                      onTap: () {
                        print('object ${message.text}');
                        if (message.text != "") {
                          Map requiredDataSendMessage = {
                            "message": message.text,
                            "room": int.parse(argument['roomId'])
                          };
                          print(requiredDataSendMessage);
                          provider.sendMessage(
                              requiredDataSendMessage, context, true);

                          message.text = "";
                        }

                        // provider.getMessage(
                        //   context,
                        //   int.parse(argument['groupId']),
                        // );
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 5),
                        decoration: BoxDecoration(
                          color: Color(0xFFF903E3),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
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
