import 'package:flutter/material.dart';
import 'package:myplo/theme/font_theme.dart';

class TextFormFieldsBorderTheme {
  static OutlineInputBorder focusedBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(22),
    borderSide: BorderSide(
      width: 0,
      style: BorderStyle.none,
    ),
  );
  static OutlineInputBorder enabledBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(22),
    borderSide: BorderSide(
      width: 0,
      style: BorderStyle.none,
    ),
  );
}

class AddressTextFormFieldsBorderTheme {
  static OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: appCommonColor),
  );

  static OutlineInputBorder focusBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: appCommonColor),
  );

  static OutlineInputBorder enableBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: appCommonColor),
  );
}

class ChangePasswordTextFormFieldsBorderTheme {
  static OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: appCommonColor),
  );

  static OutlineInputBorder focusBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: appCommonColor),
  );

  static OutlineInputBorder enableBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: appCommonColor),
  );
}

class EditProfileTextFormFieldsBorderTheme {
  static OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: appCommonColor),
  );

  static OutlineInputBorder focusBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: appCommonColor),
  );

  static OutlineInputBorder enableBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: appCommonColor),
  );
}
