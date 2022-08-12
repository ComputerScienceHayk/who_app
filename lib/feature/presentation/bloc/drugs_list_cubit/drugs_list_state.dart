import 'package:equatable/equatable.dart';
import 'package:sdh_task/feature/domain/entities/drugs_list_entity.dart';

abstract class DrugsListState extends Equatable {
  const DrugsListState();

  @override
  List<Object> get props => [];
}

class DrugsListEmpty extends DrugsListState {
  @override
  List<Object> get props => [];
}

class DrugsListLoading extends DrugsListState {
  final DrugsListEntity drugsListEntity;
  final bool isFirstFetch;
  final int pagesCount;
  final int pageNumber;

  const DrugsListLoading(this.drugsListEntity, this.pagesCount, this.pageNumber,
      {this.isFirstFetch = false});

  @override
  List<Object> get props => [
        drugsListEntity,
        pagesCount,
        pageNumber,
      ];
}

class DrugsListLoaded extends DrugsListState {
  final DrugsListEntity drugsList;
  final int pagesCount;
  final int pageNumber;

  const DrugsListLoaded(
    this.drugsList,
    this.pagesCount,
    this.pageNumber,
  );

  @override
  List<Object> get props => [
        drugsList,
        pagesCount,
        pageNumber,
      ];
}

class DrugsListError extends DrugsListState {
  final String message;

  const DrugsListError({required this.message});

  @override
  List<Object> get props => [message];
}
