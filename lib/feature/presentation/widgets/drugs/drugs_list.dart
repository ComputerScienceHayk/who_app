import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdh_task/common/const_texts.dart';
import 'package:sdh_task/feature/domain/entities/drugs_list_entity.dart';
import 'package:sdh_task/feature/presentation/bloc/drugs_list_cubit/drugs_list_cubit.dart';
import 'package:sdh_task/feature/presentation/bloc/drugs_list_cubit/drugs_list_state.dart';
import 'package:sdh_task/feature/presentation/widgets/drugs/drugs_list_item.dart';
import 'package:sdh_task/feature/presentation/widgets/error_message.dart';
import 'package:sdh_task/feature/presentation/widgets/loading_indicator.dart';

class DrugsList extends StatelessWidget {
  const DrugsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DrugsListCubit, DrugsListState>(
      builder: (context, state) {
        DrugsListEntity? drugsList;
        if (state is DrugsListLoading && state.isFirstFetch) {
          return const LoadingIndicator();
        } else if (state is DrugsListLoading) {
          drugsList = state.drugsListEntity;
        } else if (state is DrugsListLoaded) {
          drugsList = state.drugsList;
        } else if (state is DrugsListError) {
          return SliverToBoxAdapter(
            child: ErrorMessage(
              errorType: state.message,
            ),
          );
        }
        return SliverList(
          delegate: SliverChildListDelegate(
            [
              for (int i = 0; i < (drugsList?.result.length ?? 0); i++)
                DrugsListItem(
                  id: drugsList?.result[i]['id'],
                  tradeLabelName: drugsList?.result[i]['trade_label']
                          ?['name'] ??
                      ConstTexts.noInformation,
                  manufactureName: drugsList?.result[i]['manufacturer']
                          ?['name'] ??
                      ConstTexts.noInformation,
                ),
            ],
          ),
        );
      },
    );
  }
}
