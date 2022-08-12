import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdh_task/common/app_colors.dart';
import 'package:sdh_task/common/const_size.dart';
import 'package:sdh_task/feature/presentation/bloc/connection_checker_cubit/connection_checker_state.dart';
import 'package:sdh_task/feature/presentation/widgets/custom_text.dart';
import 'package:sdh_task/feature/presentation/widgets/drugs/bottom_nav_numbers.dart';
import 'package:sdh_task/feature/presentation/widgets/drugs/drugs_list.dart';
import 'package:sdh_task/feature/presentation/widgets/drugs/drugs_list_app_bar.dart';
import 'package:sdh_task/feature/presentation/bloc/connection_checker_cubit/connection_checker_cubit.dart';
import 'package:sdh_task/common/const_texts.dart';


class DrugsScreen extends StatefulWidget {
  const DrugsScreen({Key? key}) : super(key: key);

  @override
  State<DrugsScreen> createState() => _DrugsScreenState();
}

class _DrugsScreenState extends State<DrugsScreen> {

  final ScrollController scrollController = ScrollController();
  bool scrolled = false;
  bool scrollLogic(UserScrollNotification notification) {
    if (scrollController.position.pixels > ConstSize.expandedHeight) {
      setState(() {
        scrolled = true;
      });
    } else {
      setState(() {
        scrolled = false;
      });
    }
    return true;
  }

  void showToast() {
    BotToast.showCustomText(
      toastBuilder: (_) => const Card(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: CustomText(
            text: ConstTexts.noInternetConnection,
            color: AppColors.errorColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectionCheckerCubit, ConnectionCheckerState>(
        builder: (context, state) {
          if(state is Disconnected) {
             showToast();
          }
          return SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.mainBackground,
              body: NotificationListener<UserScrollNotification>(
                onNotification: scrollLogic,
                child: CustomScrollView(
                  controller: scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    DrugsListAppBar(scrolled: scrolled),
                    const DrugsList(),
                  ],
                ),
              ),
              bottomNavigationBar: const BottomNavNumbers(),
            ),
          );
        },
    );
  }
}
