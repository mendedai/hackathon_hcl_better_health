import 'package:flutter/material.dart';

part './extensions/text_extension.dart';

// Idea for this comes from
// https://blog.gskinner.com/archives/2020/03/flutter-tame-those-textstyles.html
class Fonts {
  static String get body => 'Roboto';
  static String get title => 'Montserrat';
}

class FontSizes {
  static double scale = 1;

  static double get body => 14 * scale;
  static double get bodySm => 12 * scale;
  static double get bodyLg => 16 * scale;

  static double get title => 16 * scale;
  static double get sectionTitle => 20 * scale;
  static double get pageTitle => 26 * scale;
}

class TextStyles {
  static TextStyle get bodyFont => TextStyle(fontFamily: Fonts.body);
  static TextStyle get titleFont => TextStyle(fontFamily: Fonts.title);

  static TextStyle get title => titleFont.copyWith(fontSize: FontSizes.title);
  static TextStyle get titleLight =>
      title.copyWith(fontWeight: FontWeight.w300);

  static TextStyle get sectionTitle => titleFont.copyWith(
        fontSize: FontSizes.sectionTitle,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get pageTitle => titleFont.copyWith(
        fontSize: FontSizes.pageTitle,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get body => bodyFont.copyWith(
        fontSize: FontSizes.body,
        fontWeight: FontWeight.w300,
      );
  static TextStyle get bodySm => body.copyWith(fontSize: FontSizes.bodySm);
  static TextStyle get bodyLg => body.copyWith(fontSize: FontSizes.bodyLg);
}
