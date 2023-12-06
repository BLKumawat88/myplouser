import 'dart:io';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:myplo/Gig%20Section/bottombar/bottombar.dart';
import 'package:myplo/auth/forgot_password/forgot_password.dart';
import 'package:myplo/auth/login/login.dart';
import 'package:myplo/auth/signup/signup.dart';
import 'package:myplo/controller/all_in_controller.dart';
import 'package:myplo/views/about_screen/about_detail_screen.dart';
import 'package:myplo/views/about_screen/about_screen.dart';
import 'package:myplo/views/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:myplo/views/categories_product_screen/categories_product_search_product.dart';
import 'package:myplo/views/categories_product_screen/categories_products.dart';
import 'package:myplo/views/change_password_screen/change_password_screen.dart';
import 'package:myplo/views/chat_screen/chat_screen.dart';
import 'package:myplo/views/chat_screen/user_chat_screen.dart';
import 'package:myplo/views/chat_screen/user_chat_screen_test.dart';
import 'package:myplo/views/contact_us_screen/contact_us_screen.dart';
import 'package:myplo/views/edit_profile_screen/edit_profile_screen.dart';
import 'package:myplo/views/faq_screen/faq_screen.dart';
import 'package:myplo/views/favorite_items_screen/favorite.dart';
import 'package:myplo/views/home_screen.dart/home_screen.dart';
import 'package:myplo/views/location_screen/location_screen.dart';
import 'package:myplo/views/make_featured_screen/make_featured_screen.dart';
import 'package:myplo/views/order_screen/order_detail_screen.dart';
import 'package:myplo/views/proceed_to_payment_screen/proceed_to_payment.dart';
import 'package:myplo/views/sell_screen/Congratulations_screen_after_add_product.dart';
import 'package:myplo/views/selling_screen/selling_product_detail_screen.dart';
import 'package:myplo/views/selling_screen/selling_screen.dart';
import 'package:myplo/views/notification_screen/notification_scree.dart';
import 'package:myplo/views/order_screen/order_screen.dart';
import 'package:myplo/views/pin_screen/pin_screen.dart';
import 'package:myplo/views/product_detail_screen/product_detail_screen.dart';
import 'package:myplo/views/profile_screen/profile_screen.dart';
import 'package:myplo/views/review_screen/review_screen.dart';
import 'package:myplo/views/sales_screen/more_info_screen.dart';
import 'package:myplo/views/sales_screen/sales_screen.dart';
import 'package:myplo/views/sell_screen/sell_screen.dart';
import 'package:myplo/views/setting_screen/setting_screen.dart';
import 'package:myplo/views/show_address/show_address.dart';
import 'package:myplo/views/sold_screen/sold_product_detail_screen.dart';
import 'package:myplo/views/sold_screen/sold_screen.dart';
import 'package:myplo/views/support_screen/support_screen.dart';
import 'package:myplo/views/update_listing_screen.dart';
import 'package:myplo/views/view_categories/view_categories.dart';
import 'package:provider/provider.dart';
import 'is_user_logged_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HttpOverrides.global = MyHttpOverrides();
  Stripe.publishableKey = "pk_test_txDJRlXoAFelCWzOrBdENCRS";
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight]);
    return ChangeNotifierProvider(
      create: (_) => AllInProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AnimatedSplashScreen(
          duration: 3000,
          splashIconSize: double.infinity,
          splash: Container(
            width: double.infinity,
            child: Image.asset(
              'assets/images/splash_screen.png',
              fit: BoxFit.cover,
            ),
          ),
          nextScreen: IsUserLoggedInOrNot(),
          // nextScreen: StateLessWidgetExample(),
          // nextScreen: StateFullWidgetExample(),
        ),
        routes: {
          '/login': (context) => Login(),
          // '/': (context) => CongratulationsScreen(),
          '/signup_screen': (context) => Signup(),
          '/IsUserLoggedInOrNot': (context) => IsUserLoggedInOrNot(),
          '/pin_screen': (context) => PinScreen(),
          '/location_screen': (context) => LocationScreen(),
          '/home_screen': (context) => HomeScreen(),
          '/sell_screen': (context) => SellScreen(),
          '/notification_screen': (context) => NotificationScreen(),
          '/profile_screen': (context) => ProfileScreen(),
          '/bottom_navigation': (context) => MyBottomNavigation(),
          // '/bottom_navigation': (context) => Curved(),
          '/product_detail_screen': (context) => ProductDetailScreen(),
          '/chat_screen': (context) => ChatScreen(),
          '/order_screen': (context) => OrderScreen(),
          '/order_detail_screen': (context) => OrderDetailScreen(),
          '/selling_screen': (context) => SellingScreen(),
          '/setting_screen': (context) => SettingScreen(),
          '/change_password_screen': (context) => ChangePasswordScreen(),
          '/support_password_screen': (context) => SupportScreen(),
          '/faq_screen': (context) => FAQScreen(),
          '/edit_profile_screen': (context) => EditProfileScreen(),
          '/forgot_password_screen': (context) => ForgotPassword(),
          '/sold_screen': (context) => SoldScreen(),
          '/sales_screen': (context) => SalesScreen(),
          '/review_screen': (context) => ReviewScreen(),
          '/favorite_screen': (context) => FavoriteScreen(),
          '/more_info_screen': (context) => MoreInfo(),
          '/update_listing_screen': (context) => UpdateListingScreen(),
          // '/add_items': (context) => AddItems(),
          '/view_more_categories': (context) => ViewMoreCategories(),
          '/categories_product_screen': (context) => CategoriesProductScreen(),
          '/category_search_product': (context) => CategorySearchProduct(),
          '/selling_product_detail_screen': (context) =>
              SellingProductDetailScreen(),
          '/sold_product_detail_screen': (context) => SoldProductDetailScreen(),
          '/proceed_to_payment_screen': (context) => ProceedToPaymentScreen(),
          '/make_featured_screen': (context) => MakeFeaturedScreen(),
          '/contact_us_screen': (context) => ContactUs(),
          '/about_screen': (context) => AboutScreen(),
          '/about_detail_screen': (context) => AboutDetailScreen(),
          '/user_chat_screen': (context) => UserChatScreen(),
          '/show_address_screen': (context) => ShowAddressScreen(),
          '/user_chat_screen_test': (context) => UserChatScreenTest(),
          '/cong_screen': (context) => CongratulationsScreen(),
          '/gig_bottom_bar': (context) => GigBottomBarScreen()
        },
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
