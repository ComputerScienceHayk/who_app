import 'package:flutter/material.dart';
import 'package:sdh_task/common/app_colors.dart';
import 'package:sdh_task/common/const_size.dart';
import 'package:sdh_task/common/const_texts.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({
    required this.errorType,
    Key? key
  }) : super(key: key);

  final String errorType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
      MediaQuery.of(context).size.height - ConstSize.expandedHeight,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: '$errorType\n\n\n',
          style: const TextStyle(
            fontSize: 20,
            color: AppColors.errorColor,
          ),
          children: const <TextSpan>[
            TextSpan(
              text: ConstTexts.helpMessage,
              style: TextStyle(
                color: AppColors.errorColor,
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
