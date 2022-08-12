import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdh_task/common/const_texts.dart';
import 'package:sdh_task/core/error/failure.dart';
import 'package:sdh_task/feature/domain/entities/drug_details_entity.dart';
import 'package:sdh_task/feature/domain/uscases/get_drug_details.dart';
import 'package:sdh_task/feature/presentation/bloc/drug_details_cubit/drug_details_state.dart';

class DrugDetailsCubit extends Cubit<DrugDetailsState> {
  final GetDrugDetails getDrugDetails;

  DrugDetailsCubit({required this.getDrugDetails}) : super(DrugDetailsEmpty());

  void loadDrugDetails(int id) async {
    if (state is DrugDetailsLoading) return;

    final currentState = state;

    DrugDetailsEntity oldDrugsList = const DrugDetailsEntity(
      id: 1,
      compositionPharmForm: '',
      compositionDescription: '',
      compositionInn: '',
      tradeLabel: '',
      packagingDescription: '',
      manufacturerName: '',
    );

    if (currentState is DrugDetailsLoaded) {
      oldDrugsList = currentState.drugDetailsEntity;
    }

    emit(DrugDetailsLoading(oldDrugsList, isFirstFetch: id == 0));

    final failureOrDrugDetails = await getDrugDetails(
      DrugDetailsParams(id: id),
    );

    failureOrDrugDetails.fold(
        (error) => emit(DrugDetailsError(message: _mapFailureToMessage(error))),
        (drug) {
      DrugDetailsEntity drugDetails =
          (state as DrugDetailsLoading).drugDetailsEntity;
      drugDetails = drug;
      emit(DrugDetailsLoaded(drugDetails));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return ConstTexts.serverFailureMessage;
      case CacheFailure:
        return ConstTexts.cachedFailureMessage;
      default:
        return ConstTexts.unexpectedErrorMessage;
    }
  }
}
