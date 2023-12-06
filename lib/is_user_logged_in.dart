import 'package:flutter/material.dart';
import 'package:myplo/views/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:myplo/views/go_next_screen.dart';
import 'package:provider/provider.dart';
import 'auth/login/login.dart';
import 'controller/all_in_controller.dart';

class IsUserLoggedInOrNot extends StatefulWidget {
  const IsUserLoggedInOrNot({super.key});

  @override
  State<IsUserLoggedInOrNot> createState() => _IsUserLoggedInOrNotState();
}

class _IsUserLoggedInOrNotState extends State<IsUserLoggedInOrNot> {
  @override
  Widget build(BuildContext context) {
    AllInProvider provider = Provider.of<AllInProvider>(context, listen: false);
    return FutureBuilder(
      future: provider.isUserLogedIn(),
      builder: (contect, authResult) {
        if (authResult.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (authResult.data == true) {
            return GOTOHome();
          }
          return const Login();
        }
      },
    );
  }
}
