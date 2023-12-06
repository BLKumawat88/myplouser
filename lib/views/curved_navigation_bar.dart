import 'package:flutter/material.dart';
import 'package:curved_nav_bar/curved_bar/curved_action_bar.dart';
import 'package:curved_nav_bar/fab_bar/fab_bottom_app_bar_item.dart';
import 'package:curved_nav_bar/flutter_curved_bottom_nav_bar.dart';
import 'package:myplo/views/chat_screen/chat_screen.dart';
import 'package:myplo/views/home_screen.dart/home_screen.dart';
import 'package:myplo/views/order_screen/order_screen.dart';
import 'package:myplo/views/profile_screen/profile_screen.dart';
import 'package:myplo/views/sell_screen/sell_screen.dart';

class Curved extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CurvedNavBar(
      actionButton: CurvedActionBar(
        onTab: (value) {
          print(value);
        },
        activeIcon: InkWell(
          onTap: () {
            SellScreen();
          },
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFF903E3),
                  Color(0xFF0A6DFE),
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.camera_alt,
              size: 30,
              color: Colors.white,
            ),
          ),
        ),
        // inActiveIcon: Container(
        //   padding: EdgeInsets.all(8),
        //   decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       colors: [
        //         Color(0xFFF903E3),
        //         Color(0xFF0A6DFE),
        //       ],
        //     ),
        //     shape: BoxShape.circle,
        //   ),
        //   child: Icon(
        //     Icons.camera_alt,
        //     size: 30,
        //     color: Colors.white,
        //   ),
        // ),
        text: 'SELL',
      ),
      // activeColor: Color(0xFFF903E3),
      navBarBackgroundColor: Colors.white,
      inActiveColor: Color(0xFF989BA5),
      appBarItems: [
        FABBottomAppBarItem(
          activeIcon: ImageIcon(
            AssetImage('assets/images/home.png'),
            color: Colors.grey,
          ),
          inActiveIcon: ImageIcon(
            AssetImage('assets/images/home.png'),
            color: Colors.grey,
          ),
          text: 'HOME',
        ),
        FABBottomAppBarItem(
          activeIcon: ImageIcon(
            AssetImage('assets/images/chat.png'),
            color: Colors.grey,
          ),
          inActiveIcon: ImageIcon(
            AssetImage('assets/images/chat.png'),
            color: Colors.grey,
          ),
          text: 'CHAT',
        ),
        FABBottomAppBarItem(
          activeIcon: ImageIcon(
            AssetImage('assets/images/bag.png'),
            color: Colors.grey,
          ),
          inActiveIcon: ImageIcon(
            AssetImage('assets/images/bag.png'),
            color: Colors.grey,
          ),
          text: 'ORDERS',
        ),
        FABBottomAppBarItem(
          activeIcon: ImageIcon(
            AssetImage('assets/images/user.png'),
            color: Colors.grey,
          ),
          inActiveIcon: ImageIcon(
            AssetImage('assets/images/user.png'),
            color: Colors.grey,
          ),
          text: 'PROFILE',
        ),
      ],
      bodyItems: [
        // Container(
        //   height: MediaQuery.of(context).size.height,
        //   color: Colors.amber,
        // ),
        HomeScreen(),
        // Container(
        //   height: MediaQuery.of(context).size.height,
        //   color: Colors.blue,
        // ),
        ChatScreen(),
        // Container(
        //   height: MediaQuery.of(context).size.height,
        //   color: Colors.pinkAccent,
        // ),
        OrderScreen(),
        // Container(
        //   height: MediaQuery.of(context).size.height,
        //   color: Colors.brown,
        // ),

        ProfileScreen(),
      ],
    );
  }
}
