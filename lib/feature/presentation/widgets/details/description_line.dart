import 'package:flutter/material.dart';
import 'package:sdh_task/common/app_colors.dart';
import 'package:sdh_task/feature/presentation/widgets/custom_text.dart';

class DescriptionLine extends StatelessWidget {
  const DescriptionLine({
    required this.description,
    required this.text,
    Key? key,
  }) : super(key: key);

  final String description;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 80.0,
      // margin: const EdgeInsets.only(left: 10.0, right: 10.0,),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: const BoxDecoration(
        border: Border(
            bottom: BorderSide(
              color: AppColors.greyTextColor,
            ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: description,
            color: AppColors.greyTextColor,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(
            height: 8.0,
          ),
          Expanded(child: CustomText(text: text),),
        ],
      ),
    );
  }
}
