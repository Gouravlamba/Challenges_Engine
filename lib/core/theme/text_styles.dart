import 'package:flutter/material.dart';
import 'app_colors.dart';

class TextStyles {
  static const String fontFamily = 'Poppins';

  static final TextStyle headline = TextStyle(
      fontFamily: fontFamily,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.text);

  static final TextStyle body =
      TextStyle(fontFamily: fontFamily, fontSize: 14, color: AppColors.text);

  static final TextStyle small =
      TextStyle(fontFamily: fontFamily, fontSize: 12, color: AppColors.text);
}
