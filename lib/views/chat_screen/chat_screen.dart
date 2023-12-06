import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myplo/controller/all_in_controller.dart';
import 'package:myplo/theme/common_theme.dart';
import 'package:myplo/theme/font_theme.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late AllInProvider provider;
  int currentIndex = 1;

  static final chatScreenTitle = GoogleFonts.inter(
    color: Color(0xFF033134),
    fontSize: 10,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
  );

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AllInProvider>(context, listen: false);
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   provider.getChatData();
    // });
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
                    'Chats',
                    style: appbarTitle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width,
              color: Color(0xFFD9D9D9),
            ),
            currentIndex == 1
                ? Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Consumer<AllInProvider>(
                          builder: (context, value, child) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                TextField(
                                  onChanged: (value) {},
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontStyle: FontStyle.normal,
                                  ),
                                  decoration: InputDecoration(
                                    isDense: true,
                                    hintText: 'Search in messagess',
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 15,
                                      horizontal: 15,
                                    ),
                                    hintStyle:
                                        CommonFontTheme.chatScreenSearchBar,
                                    suffixIcon: Icon(
                                      Icons.search,
                                      size: 24,
                                      color: Color(0xFF999999),
                                    ),
                                    border: InputBorder.none,
                                    filled: true,
                                    fillColor: Color(0xFFDEDEDE),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(22),
                                      borderSide: BorderSide(
                                        color: Color(0xFFDEDEDE),
                                        style: BorderStyle.none,
                                        width: 0,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(22),
                                      borderSide: BorderSide(
                                        color: Color(0xFFDEDEDE),
                                        style: BorderStyle.none,
                                        width: 0,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Consumer(
                                  builder: (context, value, child) {
                                    return Column(
                                      children: [
                                        ...provider.chatUserListData.map(
                                          (e) {
                                            return InkWell(
                                              onTap: () {
                                                print(e['userId'].runtimeType);

                                                Map createRoomRequiredData = {
                                                  "productId": e['productId'],
                                                  "productuserId":
                                                      int.parse(e['userId']),
                                                  "userId": int.parse(
                                                      provider.userId),
                                                };
                                                provider.userProfile =
                                                    e['profileImage'];
                                                provider.userName =
                                                    e['userName'];
                                                provider.createRoom(
                                                  createRoomRequiredData,
                                                  context,
                                                  true,
                                                );
                                                provider.getUserChatData();
                                              },
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                  top: 0,
                                                  left: 10,
                                                  right: 10,
                                                  bottom: 5,
                                                ),
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 5),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 30,
                                                          backgroundImage:
                                                              NetworkImage(
                                                            '${e['profileImage']}',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Flexible(
                                                      fit: FlexFit.loose,
                                                      flex: 8,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          top: 10,
                                                          left: 10,
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  '${e['productName']}|',
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    color: Color(
                                                                        0xFF3C3C3C),
                                                                    fontSize:
                                                                        16,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .normal,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  '${e['userName']}',
                                                                  style:
                                                                      GoogleFonts
                                                                          .inter(
                                                                    color: Color(
                                                                        0xFF828282),
                                                                    fontSize:
                                                                        16,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .normal,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            RichText(
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              text: TextSpan(
                                                                text:
                                                                    '${e['userName']} : ',
                                                                style:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  color: Color(
                                                                      0xFF828282),
                                                                  fontSize: 13,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                                children: [
                                                                  TextSpan(
                                                                    text: e[
                                                                        'role'],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            // Text(
                                                            //   maxLines: 2,
                                                            //   overflow: TextOverflow.ellipsis,
                                                            //   'You: Does it come with an additional box?',
                                                            //   style: GoogleFonts.inter(
                                                            //     color: Color(0xFF828282),
                                                            //     fontSize: 13,
                                                            //     fontStyle: FontStyle.normal,
                                                            //     fontWeight: FontWeight.w400,
                                                            //   ),
                                                            // ),
                                                            // Align(
                                                            //   alignment: Alignment
                                                            //       .bottomRight,
                                                            //   child: Text(
                                                            //     e['time'],
                                                            //     maxLines: 1,
                                                            //     overflow:
                                                            //         TextOverflow
                                                            //             .ellipsis,
                                                            //     style:
                                                            //         GoogleFonts
                                                            //             .inter(
                                                            //       height: 2,
                                                            //       color: Color(
                                                            //           0xFF828282),
                                                            //       fontSize: 12,
                                                            //       fontStyle:
                                                            //           FontStyle
                                                            //               .normal,
                                                            //       fontWeight:
                                                            //           FontWeight
                                                            //               .w300,
                                                            //     ),
                                                            //   ),
                                                            // ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: PopupMenuButton(
                                                        onSelected: (value) {
                                                          print(
                                                            'Values $value',
                                                          );
                                                          if (value ==
                                                              'BlockUser') {
                                                            print(
                                                                'User id in block user ${e['userId']}');
                                                            provider.blockUser(
                                                              context,
                                                              int.parse(
                                                                e['userId'],
                                                              ),
                                                            );
                                                          }
                                                          if (value ==
                                                              'DeleteChat') {
                                                            provider.deleteChat(
                                                                e['groupName']);
                                                          }
                                                        },
                                                        itemBuilder: (context) {
                                                          return <
                                                              PopupMenuEntry>[
                                                            PopupMenuItem(
                                                              value:
                                                                  'BlockUser',
                                                              child: Text(
                                                                'Block User',
                                                              ),
                                                            ),
                                                            PopupMenuItem(
                                                              value:
                                                                  'DeleteChat',
                                                              child: Text(
                                                                'Delete Chat',
                                                              ),
                                                            ),
                                                          ];
                                                        },
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
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  )
                : currentIndex == 2
                    ? Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Consumer<AllInProvider>(
                              builder: (context, value, child) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    TextField(
                                      onChanged: (value) {},
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontStyle: FontStyle.normal,
                                      ),
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: 'Search in messages',
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 15,
                                          horizontal: 15,
                                        ),
                                        hintStyle:
                                            CommonFontTheme.chatScreenSearchBar,
                                        suffixIcon: Icon(
                                          Icons.search,
                                          size: 24,
                                          color: Color(0xFF999999),
                                        ),
                                        border: InputBorder.none,
                                        filled: true,
                                        fillColor: Color(0xFFDEDEDE),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(22),
                                          borderSide: BorderSide(
                                            color: Color(0xFFDEDEDE),
                                            style: BorderStyle.none,
                                            width: 0,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(22),
                                          borderSide: BorderSide(
                                            color: Color(0xFFDEDEDE),
                                            style: BorderStyle.none,
                                            width: 0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Image.asset(
                                      'assets/images/buying_chat.png',
                                      fit: BoxFit.cover,
                                      width: 250,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text('You’ve got no chat history so far.'),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      )
                    : currentIndex == 3
                        ? Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Consumer<AllInProvider>(
                                  builder: (context, value, child) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        TextField(
                                          onChanged: (value) {},
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontStyle: FontStyle.normal,
                                          ),
                                          decoration: InputDecoration(
                                            isDense: true,
                                            hintText: 'Search in messages',
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              vertical: 15,
                                              horizontal: 15,
                                            ),
                                            hintStyle: CommonFontTheme
                                                .chatScreenSearchBar,
                                            suffixIcon: Icon(
                                              Icons.search,
                                              size: 24,
                                              color: Color(0xFF999999),
                                            ),
                                            border: InputBorder.none,
                                            filled: true,
                                            fillColor: Color(0xFFDEDEDE),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(22),
                                              borderSide: BorderSide(
                                                color: Color(0xFFDEDEDE),
                                                style: BorderStyle.none,
                                                width: 0,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(22),
                                              borderSide: BorderSide(
                                                color: Color(0xFFDEDEDE),
                                                style: BorderStyle.none,
                                                width: 0,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Image.asset(
                                          'assets/images/buying_chat.png',
                                          fit: BoxFit.cover,
                                          width: 250,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                            'You’ve got no chat history so far.'),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
          ],
        ),
      ),
    );
  }
}
