import 'package:flutter/material.dart';
import 'package:sdh_task/common/app_colors.dart';
import 'package:sdh_task/common/const_texts.dart';
import 'package:sdh_task/feature/presentation/widgets/details/drug_info.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.drugsListItemBg,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: AppColors.drugsListItemBg,
          title: const Text(ConstTexts.details),
        ),
        body: const DrugInfo(),
      ),
    );
  }
}
