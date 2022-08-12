import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdh_task/common/const_texts.dart';
import 'package:sdh_task/core/error/failure.dart';
import 'package:sdh_task/feature/domain/entities/drugs_list_entity.dart';
import 'package:sdh_task/feature/domain/uscases/get_drugs_list.dart';
import 'package:sdh_task/feature/presentation/bloc/drugs_list_cubit/drugs_list_state.dart';

class DrugsListCubit extends Cubit<DrugsListState> {
  final GetDrugsList getDrugsList;

  DrugsListCubit({required this.getDrugsList}) : super(DrugsListEmpty());

  int pageCount = 1;
  int pageNumber = 1;

  void loadDrugsList(int number) async {
    if (state is DrugsListLoading) return;

    final currentState = state;

    DrugsListEntity oldDrugsList = const DrugsListEntity(
      drugCount: 0,
      next: '',
      previous: '',
      result: [],
    );

    if (currentState is DrugsListLoaded) {
      oldDrugsList = currentState.drugsList;
      pageCount =  oldDrugsList.drugCount ~/ oldDrugsList.result.length;
    }

    emit(DrugsListLoading(
      oldDrugsList,
      pageCount,
      number,
      isFirstFetch: pageNumber == number,
    ));

    final failureOrDrugsList = await getDrugsList(
      DrugsListParams(page: number),
    );

    failureOrDrugsList.fold(
      (error) => emit(
        DrugsListError(
          message: _mapFailureToMessage(error),
        ),
      ),
      (drugs) {

        DrugsListEntity drugsList = (state as DrugsListLoading).drugsListEntity;
        drugsList = drugs;
        pageCount =  drugsList.drugCount ~/ drugsList.result.length;

        emit(
          DrugsListLoaded(
            drugsList,
            pageCount,
            number,
          ),
        );
      },
    );
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
