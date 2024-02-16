// ignore_for_file: overridden_fields, annotate_overrides

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shared_preferences/shared_preferences.dart';

const kThemeModeKey = '__theme_mode__';
SharedPreferences? _prefs;

abstract class FlutterFlowTheme {
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static ThemeMode get themeMode {
    final darkMode = _prefs?.getBool(kThemeModeKey);
    return darkMode == null
        ? ThemeMode.system
        : darkMode
            ? ThemeMode.dark
            : ThemeMode.light;
  }

  static void saveThemeMode(ThemeMode mode) => mode == ThemeMode.system
      ? _prefs?.remove(kThemeModeKey)
      : _prefs?.setBool(kThemeModeKey, mode == ThemeMode.dark);

  static FlutterFlowTheme of(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? DarkModeTheme()
          : LightModeTheme();

  late Color primaryColor;
  late Color secondaryColor;
  late Color tertiaryColor;
  late Color alternate;
  late Color primaryBackground;
  late Color secondaryBackground;
  late Color primaryText;
  late Color secondaryText;

  late Color bGColor;
  late Color cTBdColor;
  late Color cTHdColor;
  late Color cTDtColor;
  late Color diBGColor;
  late Color cTSeColor;
  late Color enbColor;
  late Color dsbColor;
  late Color draColor1;
  late Color draColor2;
  late Color nBColor;
  late Color aBColor;
  late Color titColor;
  late Color sTitColor;
  late Color bTitColor;

  TextStyle get title1 => GoogleFonts.getFont(
        'Poppins',
        color: titColor,
        fontWeight: FontWeight.w600,
        fontSize: 24,
      );
  TextStyle get title2 => GoogleFonts.getFont(
        'Poppins',
        color: titColor,
        fontWeight: FontWeight.w500,
        fontSize: 22,
      );
  TextStyle get title3 => GoogleFonts.getFont(
        'Poppins',
        color: titColor,
        fontWeight: FontWeight.w500,
        fontSize: 20,
      );
  TextStyle get subtitle1 => GoogleFonts.getFont(
        'Poppins',
        color: sTitColor,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      );
  TextStyle get subtitle2 => GoogleFonts.getFont(
        'Poppins',
        color: sTitColor,
        fontWeight: FontWeight.normal,
        fontSize: 16,
      );
  TextStyle get bodyText1 => GoogleFonts.getFont(
        'Poppins',
        color: bTitColor,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
  TextStyle get bodyText2 => GoogleFonts.getFont(
        'Poppins',
        color: bTitColor,
        fontWeight: FontWeight.normal,
        fontSize: 14,
      );
}

class LightModeTheme extends FlutterFlowTheme {
  Color primaryColor = const Color(0xFF1512F6);
  Color secondaryColor = const Color(0xFFCC0307);
  Color tertiaryColor = const Color(0xFF2B02B7);
  Color alternate = const Color(0x00000000);
  Color primaryBackground = const Color(0x00000000);
  Color secondaryBackground = const Color(0x00000000);
  Color primaryText = const Color(0x00000000);
  Color secondaryText = const Color(0x00000000);

  Color bGColor = Color(0xFFFFFFFF);
  Color cTBdColor = Color(0xFFEEEEEE);
  Color cTHdColor = Color(0xFF59AB33);
  Color cTDtColor = Color(0xFF43948B);
  Color diBGColor = Color(0xFF2A1A58);
  Color cTSeColor = Color(0xFFF6C37F);
  Color enbColor = Color(0xFF59AB33);
  Color dsbColor = Color(0xFF8E8E93);
  Color draColor1 = Color(0xFF78084C);
  Color draColor2 = Color(0xFFB5AA22);
  Color nBColor = Color(0xFFFFFFFF);
  Color aBColor = Color(0xFFFFFFFF);
  Color titColor = Color(0xFFEEEEEE);
  Color sTitColor = Color(0xFF222222);
  Color bTitColor = Color(0xFF030A47);
}

class DarkModeTheme extends FlutterFlowTheme {
  Color primaryColor = const Color(0xFF1512F6);
  Color secondaryColor = const Color(0xFFCC0307);
  Color tertiaryColor = const Color(0xFF2B02B7);
  Color alternate = const Color(0x00000000);
  Color primaryBackground = const Color(0x00000000);
  Color secondaryBackground = const Color(0x00000000);
  Color primaryText = const Color(0x00000000);
  Color secondaryText = const Color(0x00000000);

  Color bGColor = Color(0xFF030A47);
  Color cTBdColor = Color(0xFFEEEEEE);
  Color cTHdColor = Color(0xFF8831FA);
  Color cTDtColor = Color(0xFF43948B);
  Color diBGColor = Color(0xFF2A1A58);
  Color cTSeColor = Color(0xFFF6C37F);
  Color enbColor = Color(0xFF7DAA2D);
  Color dsbColor = Color(0xFF8E8E93);
  Color draColor1 = Color(0xFF78084C);
  Color draColor2 = Color(0xFFB5AA22);
  Color nBColor = Color(0xFF010424);
  Color aBColor = Color(0xFF010424);
  Color titColor = Color(0xFFEEEEEE);
  Color sTitColor = Color(0xFF0003FF);
  Color bTitColor = Color(0xFF030A47);
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    bool useGoogleFonts = true,
    TextDecoration? decoration,
    double? lineHeight,
  }) =>
      useGoogleFonts
          ? GoogleFonts.getFont(
              fontFamily!,
              color: color ?? this.color,
              fontSize: fontSize ?? this.fontSize,
              fontWeight: fontWeight ?? this.fontWeight,
              fontStyle: fontStyle ?? this.fontStyle,
              decoration: decoration,
              height: lineHeight,
            )
          : copyWith(
              fontFamily: fontFamily,
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              decoration: decoration,
              height: lineHeight,
            );
}
