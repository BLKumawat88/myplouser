import 'package:flutter/material.dart';
import 'package:myplo/theme/common_theme.dart';
import 'package:myplo/theme/font_theme.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  verifyLocation() {
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/bottom_navigation',
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Image.asset(
                'assets/images/app_logo.png',
                scale: 6,
              ),
              Text(
                'The Genius Way to Buy & Sell Party Leftovers',
                style: appTagline,
              ),
              Image.asset(
                'assets/images/current_locations.png',
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 75),
                child: Text(
                  textAlign: TextAlign.center,
                  'Where do you want to buy/sell products?',
                  style: LocationPageTheme.locationText,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              AppCommonButtonWithIcon(
                actionMethod: verifyLocation,
                image: 'assets/images/location.png',
                title: 'Around Me',
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Set Manually',
                style: LocationPageTheme.btnSetManually,
              )
            ],
          ),
        ),
      ),
    );
  }
}
