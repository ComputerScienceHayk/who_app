import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdh_task/common/const_texts.dart';
import 'package:sdh_task/feature/domain/entities/drug_details_entity.dart';
import 'package:sdh_task/feature/presentation/bloc/drug_details_cubit/drug_details_cubit.dart';
import 'package:sdh_task/feature/presentation/bloc/drug_details_cubit/drug_details_state.dart';
import 'package:sdh_task/feature/presentation/widgets/details/description_line.dart';
import 'package:sdh_task/feature/presentation/widgets/error_message.dart';
import 'package:sdh_task/feature/presentation/widgets/loading_indicator.dart';

class DrugInfo extends StatelessWidget {
  const DrugInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DrugDetailsCubit, DrugDetailsState>(
      builder: (context, state) {
        DrugDetailsEntity? drugDetails;
        if (state is DrugDetailsLoading && state.isFirstFetch) {
          return const LoadingIndicator();
        } else if (state is DrugDetailsLoading) {
          drugDetails = state.drugDetailsEntity;
        } else if (state is DrugDetailsLoaded) {
          drugDetails = state.drugDetailsEntity;
        } else if (state is DrugDetailsError) {
          return ErrorMessage(
            errorType: state.message,
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                DescriptionLine(
                  description: ConstTexts.tradeLabel,
                  text: drugDetails?.tradeLabel ?? 'none',
                ),
                DescriptionLine(
                  description: ConstTexts.manufactureName,
                  text: drugDetails?.manufacturerName ?? ConstTexts.noInformation,
                ),
                DescriptionLine(
                  description: ConstTexts.packagingDescription,
                  text: drugDetails?.packagingDescription ?? ConstTexts.noInformation,
                ),
                DescriptionLine(
                  description: ConstTexts.compositionDescription,
                  text: drugDetails?.compositionDescription ?? ConstTexts.noInformation,
                ),
                DescriptionLine(
                  description: ConstTexts.compositionInn,
                  text: drugDetails?.compositionInn ?? ConstTexts.noInformation,
                ),
                DescriptionLine(
                  description: ConstTexts.compositionPharmForm,
                  text: drugDetails?.compositionPharmForm ?? ConstTexts.noInformation,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
