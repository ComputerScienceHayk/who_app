import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdh_task/common/app_colors.dart';
import 'package:sdh_task/common/const_texts.dart';
import 'package:sdh_task/feature/presentation/bloc/connection_checker_cubit/connection_checker_cubit.dart';
import 'package:sdh_task/feature/presentation/bloc/connection_checker_cubit/connection_checker_state.dart';
import 'package:sdh_task/feature/presentation/widgets/custom_text.dart';
import 'package:sdh_task/feature/presentation/widgets/drugs/bottom_nav_numbers.dart';
import 'package:sdh_task/feature/presentation/widgets/drugs/drugs_list.dart';
import 'package:sdh_task/feature/presentation/widgets/drugs/drugs_list_app_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrugsScreen extends StatefulWidget {
  const DrugsScreen({Key? key}) : super(key: key);

  @override
  State<DrugsScreen> createState() => _DrugsScreenState();
}

class _DrugsScreenState extends State<DrugsScreen> {

  @override
  void initState() {
    checkCache();
    super.initState();
  }

  final ScrollController scrollController = ScrollController();
  String? cachedDrugsList;

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
      cachedDrugsList = prefs.getString(ConstTexts.cachedDrugsList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectionCheckerCubit, ConnectionCheckerState>(
        builder: (context, state) {
          if (state is Disconnected) {
            if(cachedDrugsList == null) {
              showToast(ConstTexts.noInternetConnection);
            } else {
              showToast(ConstTexts.offlineVersion);
            }
          }
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.mainBackground,
              body: CustomScrollView(
                controller: scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: const[
                  DrugsListAppBar(),
                  DrugsList(),
                ],
              ),
              bottomNavigationBar: BottomNavNumbers(controller: scrollController),
            ),
          );
        },
    );
  }
}
