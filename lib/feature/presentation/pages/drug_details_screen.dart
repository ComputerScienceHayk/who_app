import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdh_task/common/app_colors.dart';
import 'package:sdh_task/common/const_texts.dart';
import 'package:sdh_task/feature/presentation/bloc/connection_checker_cubit/connection_checker_cubit.dart';
import 'package:sdh_task/feature/presentation/bloc/connection_checker_cubit/connection_checker_state.dart';
import 'package:sdh_task/feature/presentation/widgets/custom_text.dart';
import 'package:sdh_task/feature/presentation/widgets/details/drug_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String? cachedDrugDetails;

  void showToast(String text) {
    BotToast.showCustomText(
      toastBuilder: (_) => Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomText(
            text: text,
            color: AppColors.errorColor,
          ),
        ),
      ),
    );
  }

  Future<void> checkCache() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      cachedDrugDetails = prefs.getString(ConstTexts.cachedDrugDetails);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectionCheckerCubit, ConnectionCheckerState>(
      builder: (context, state) {
        if (state is Disconnected) {
          if(cachedDrugDetails == null) {
            showToast(ConstTexts.noInternetConnection);
          } else {
            showToast(ConstTexts.offlineVersion);
          }
        }
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
      },
    );
  }
}
