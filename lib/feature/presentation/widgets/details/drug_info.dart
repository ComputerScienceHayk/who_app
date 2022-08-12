import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdh_task/feature/domain/entities/drug_details_entity.dart';
import 'package:sdh_task/feature/presentation/bloc/drug_details_cubit/drug_details_cubit.dart';
import 'package:sdh_task/feature/presentation/bloc/drug_details_cubit/drug_details_state.dart';
import 'package:sdh_task/feature/presentation/widgets/details/description_line.dart';
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
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.white, fontSize: 25),
            ),
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                DescriptionLine(
                  description: 'Trade label',
                  text: drugDetails?.tradeLabel ?? 'none',
                ),
                DescriptionLine(
                  description: 'Manufacture name',
                  text: drugDetails?.manufacturerName ?? 'none',
                ),
                DescriptionLine(
                  description: 'Packaging description',
                  text: drugDetails?.packagingDescription ?? 'none',
                ),
                DescriptionLine(
                  description: 'Composition description',
                  text: drugDetails?.compositionDescription ?? 'none',
                ),
                DescriptionLine(
                  description: 'Composition inn',
                  text: drugDetails?.compositionInn ?? 'none',
                ),
                DescriptionLine(
                  description: 'Composition pharm form',
                  text: drugDetails?.compositionPharmForm ?? 'none',
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
