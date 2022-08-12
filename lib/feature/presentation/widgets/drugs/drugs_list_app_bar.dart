import 'package:flutter/material.dart';
import 'package:sdh_task/common/app_colors.dart';
import 'package:sdh_task/common/app_icons.dart';
import 'package:sdh_task/common/const_size.dart';
import 'package:sdh_task/common/const_texts.dart';
import 'package:sdh_task/feature/presentation/widgets/custom_text.dart';

class DrugsListAppBar extends StatelessWidget {
  const DrugsListAppBar({
    required this.scrolled,
    Key? key,
  }) : super(key: key);

  final bool scrolled;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: AppColors.mainBackground,
      title: Row(
        children: [
          scrolled
              ? SizedBox(
                  width: 50.0,
                  child: Image.asset(AppIcons.logo),
                )
              : const SizedBox.shrink(),
          Padding(
            padding: EdgeInsets.only(left: scrolled ? 10.0 : 0.0),
            child: const CustomText(
              text: ConstTexts.appShortTitle,
              color: AppColors.drugsListItemBg,
            ),
          ),
        ],
      ),
      pinned: true,
      expandedHeight: ConstSize.expandedHeight,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset(AppIcons.logo),
      ),
    );
  }
}
