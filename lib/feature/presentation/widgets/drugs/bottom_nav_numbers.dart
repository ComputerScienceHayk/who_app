import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_pagination/number_pagination.dart';
import 'package:sdh_task/common/app_colors.dart';
import 'package:sdh_task/feature/presentation/bloc/drugs_list_cubit/drugs_list_cubit.dart';
import 'package:sdh_task/feature/presentation/bloc/drugs_list_cubit/drugs_list_state.dart';

class BottomNavNumbers extends StatelessWidget {
  const BottomNavNumbers({
    required this.controller,
    Key? key,
  }) : super(key: key);
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DrugsListCubit, DrugsListState>(
      builder: (context, state) {
        int pageCount = 1;
        int pageNumber = 1;
        if (state is DrugsListLoading) {
          pageCount = state.pagesCount;
          pageNumber = state.pageNumber;
        } else if (state is DrugsListLoaded) {
          pageCount = state.pagesCount;
          pageNumber = state.pageNumber;
        }
        return NumberPagination(
          threshold: Platform.isIOS ? 4 : 5,
          controlButton: const SizedBox.shrink(),
          iconNext: const Padding(
            padding: EdgeInsets.all(5.0),
            child: Icon(
              Icons.arrow_forward_ios,
              color: AppColors.iconColor,
              size: 18,
            ),
          ),
          iconPrevious: const Padding(
            padding: EdgeInsets.all(5.0),
            child: Icon(
              Icons.arrow_back_ios,
              color: AppColors.iconColor,
              size: 18,
            ),
          ),
          iconToLast: const SizedBox.shrink(),
          iconToFirst: const SizedBox.shrink(),
          onPageChanged: (int pageNumber) {
            controller.animateTo(
              0,
              duration: const Duration(milliseconds: 1),
              curve: Curves.linear,
            );
            context.read<DrugsListCubit>().loadDrugsList(pageNumber);
          },
          fontFamily: Platform.isAndroid
              ? 'Roboto'
              : Platform.isIOS
                  ? 'SanFrancisco'
                  : 'Roboto',
          pageTotal: pageCount,
          pageInit: pageNumber,
          colorPrimary: AppColors.buttonUnselectedForeground,
          colorSub: AppColors.buttonUnselectedBackground,
        );
      },
    );
  }
}
