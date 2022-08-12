import 'package:equatable/equatable.dart';
import 'package:sdh_task/feature/domain/entities/drug_details_entity.dart';

abstract class DrugDetailsState extends Equatable {
  const DrugDetailsState();

  @override
  List<Object> get props => [];
}

class DrugDetailsEmpty extends DrugDetailsState {
  @override
  List<Object> get props => [];
}

class DrugDetailsLoading extends DrugDetailsState {
  final DrugDetailsEntity drugDetailsEntity;
  final bool isFirstFetch;

  const DrugDetailsLoading(this.drugDetailsEntity, {this.isFirstFetch = false});

  @override
  List<Object> get props => [drugDetailsEntity];
}

class DrugDetailsLoaded extends DrugDetailsState {
  final DrugDetailsEntity drugDetailsEntity;

  const DrugDetailsLoaded(this.drugDetailsEntity);

  @override
  List<Object> get props => [drugDetailsEntity];
}

class DrugDetailsError extends DrugDetailsState {
  final String message;

  const DrugDetailsError({required this.message});

  @override
  List<Object> get props => [message];
}
