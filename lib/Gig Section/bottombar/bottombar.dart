import 'package:flutter/material.dart';
import 'package:myplo/controller/all_in_controller.dart';
import 'package:myplo/views/chat_screen/chat_screen.dart';
import 'package:myplo/views/home_screen.dart/home_screen.dart';
import 'package:myplo/views/order_screen/order_screen.dart';
import 'package:myplo/views/profile_screen/profile_screen.dart';
import 'package:provider/provider.dart';

import '../gighome/gighome.dart';

class GigBottomBarScreen extends StatefulWidget {
  const GigBottomBarScreen({super.key});

  @override
  State<GigBottomBarScreen> createState() => _GigBottomBarScreenState();
}

class _GigBottomBarScreenState extends State<GigBottomBarScreen> {
  late AllInProvider provider;
  List screens = [
    GigHomeScreen(),
    ChatScreen(),
    OrderScreen(),
    ProfileScreen(),
  ];
  int selectedIndex = 0;

  void updateScreens(int index) {
    print('index $index');
    print('selected index $selectedIndex');

    if (index == 0) {
      // Navigator.pushNamed(context, '/home_screen');
    } else if (index == 1) {
      Navigator.pushNamed(context, '/chat_screen');
      provider.getChatUserList(context);
    } else if (index == 4) {
      Navigator.pushNamed(context, '/sell_screen');
    } else if (index == 2) {
      Navigator.pushNamed(context, '/order_screen');
      provider.getUser(context);
    } else if (index == 3) {
      Navigator.pushNamed(context, '/profile_screen');

      FocusScope.of(context).unfocus();
      provider.getUser(context);
    }

    // setState(() {
    //   selectedIndex = index;
    //   print('object $index');
    // });
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AllInProvider>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: screens[selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: updateScreens,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xFF989BA5),
          unselectedItemColor: Color(0xFF989BA5),
          elevation: 0,
          backgroundColor: Colors.transparent,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              label: 'HOME',
              icon: ImageIcon(
                AssetImage('assets/images/home.png'),
                color: Color(0xFF989BA5),
              ),
            ),
            BottomNavigationBarItem(
              label: 'CHATS',
              icon: ImageIcon(
                AssetImage('assets/images/chat.png'),
                color: Color(0xFF989BA5),
              ),
            ),
            BottomNavigationBarItem(
              label: 'ORDERS',
              icon: ImageIcon(
                AssetImage('assets/images/bag.png'),
                color: Color(0xFF989BA5),
              ),
            ),
            BottomNavigationBarItem(
              label: 'PROFILE',
              icon: ImageIcon(
                AssetImage('assets/images/user.png'),
                color: Color(0xFF989BA5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
