import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final appCommonColor = Color(0xFFF903E3);

final appTagline = GoogleFonts.firaSans(
  color: Colors.black,
  fontSize: 12,
  fontStyle: FontStyle.normal,
  fontWeight: FontWeight.w500,
);

final btnCameras = GoogleFonts.dosis(
  color: Colors.white,
  fontSize: 20,
  fontStyle: FontStyle.normal,
);

class CommonFontTheme {
  static final authHeadTitle = GoogleFonts.dosis(
    color: Color(0xFF3C3C3C),
    fontSize: 40,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w800,
  );

  static final authHeadSubtitle = GoogleFonts.archivo(
    color: Color(0xFF828282),
    fontSize: 14,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
  );

  static final authTextFormFields = GoogleFonts.archivo(
    color: Color(0xFF6F6F6F),
    fontSize: 14,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
  );

  static final authbutton = GoogleFonts.dosis(
    color: Colors.white,
    fontSize: 24,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
  );

  static final onlineButtons = GoogleFonts.inter(
    color: Colors.black,
    fontSize: 14,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
  );

  static final authTextButtons = GoogleFonts.archivo(
    color: Color(0xFFF157A9),
    fontSize: 18,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
  );

  static final profileTileTitle = GoogleFonts.firaSans(
    color: Color(0xFF5F5F5F),
    fontSize: 18,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
  );

  static final profileTileSubtitle = GoogleFonts.firaSans(
    color: Color(0xFF5F5F5F),
    fontSize: 12,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
  );

  static final browseViewMoreRecent = GoogleFonts.firaSans(
    color: Colors.black,
    fontSize: 18,
    fontStyle: FontStyle.normal,
  );

  static final chatScreenSearchBar = GoogleFonts.dosis(
    color: Color(0xFF828282),
    fontSize: 18,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
  );
}

class LocationPageTheme {
  static final locationText = GoogleFonts.dosis(
    color: Color(0xFF3C3C3C),
    fontSize: 24,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
  );

  static final btnSetManually = GoogleFonts.dosis(
    color: Color(0xFF3C3C3C),
    fontSize: 24,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
  );
}

class HomepageTheme {
  static final browseViewMore = GoogleFonts.poppins(
    color: Color(0xFF5B5B5B),
    fontSize: 14,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
  );
}

class NotificationPageTheme {
  static final notification = GoogleFonts.firaSans(
    color: Color(0xFF3C3C3C),
    fontSize: 28,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
  );

  static final tileText = GoogleFonts.nunitoSans(
    color: Colors.black.withOpacity(0.6),
    fontSize: 16,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
  );

  static final timeText = GoogleFonts.nunitoSans(
    color: appCommonColor,
    fontSize: 10,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
  );
}

class AddItemsPageTheme {
  static final addItems = GoogleFonts.firaSans(
    color: Color(0xFF3C3C3C),
    fontSize: 25,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w700,
  );

  static final whatAreYouOffering = GoogleFonts.nunitoSans(
    color: Colors.black.withOpacity(0.6),
    fontSize: 14,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
  );
}

class ProductDetailPageTheme {
  static final productName = GoogleFonts.firaSans(
    color: Color(0xFF3C3C3C),
    fontSize: 24,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
  );

  static final productPrice = GoogleFonts.firaSans(
    color: Color(0xFF087E8B),
    fontSize: 24,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
  );

  static final productDetail = GoogleFonts.firaSans(
    color: Color(0xFF666666),
    fontSize: 14,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
  );
}

class AddAddressPageTheme {
  static final textFieldsLabel = GoogleFonts.firaSans(
    color: appCommonColor,
    fontSize: 12,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
  );

  static final dropdownLabel = GoogleFonts.firaSans(
    color: Color(0xFF3C3C3C),
    fontSize: 14,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
  );
}
