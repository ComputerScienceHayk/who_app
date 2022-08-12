import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'package:sdh_task/common/app_colors.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    required this.text,
    this.color = AppColors.textColor,
    this.fontSize = 14.0,
    this.fontWeight = FontWeight.normal,
    Key? key,
  }) : super(key: key);

  final String text;
  final Color color;
  final double fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: Platform.isAndroid
            ? 'Roboto'
            : Platform.isIOS
                ? 'SanFrancisco'
                : 'Roboto',
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
