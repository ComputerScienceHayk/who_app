import 'package:flutter/material.dart';
import 'package:sdh_task/common/app_colors.dart';
import 'package:sdh_task/common/app_icons.dart';
import 'package:sdh_task/common/const_size.dart';
import 'package:sdh_task/common/const_texts.dart';
import 'package:sdh_task/feature/presentation/widgets/custom_text.dart';

class DrugsListAppBar extends StatelessWidget {
  const DrugsListAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
          backgroundColor: AppColors.mainBackground,
          title: const CustomText(
            text: ConstTexts.appShortTitle,
            color: AppColors.drugsListItemBg,
          ),
          pinned: true,
          expandedHeight: ConstSize.expandedHeight,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(AppIcons.logo),
          ),
        );
  }
}
