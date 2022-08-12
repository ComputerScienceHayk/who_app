import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sdh_task/core/error/failure.dart';
import 'package:sdh_task/core/usecases/usecase.dart';
import 'package:sdh_task/feature/domain/entities/drug_details_entity.dart';
import 'package:sdh_task/feature/domain/repositories/drug_details_repository.dart';

class GetDrugDetails extends UseCase<DrugDetailsEntity, DrugDetailsParams> {
  final DrugDetailsRepository repository;

  GetDrugDetails(this.repository);

  @override
  Future<Either<Failure, DrugDetailsEntity>> call(
      DrugDetailsParams params) async {
    return await repository.getDrugDetails(params.id);
  }
}

class DrugDetailsParams extends Equatable {
  final int id;

  const DrugDetailsParams({
    required this.id,
  });

  @override
  List<Object> get props => [
        id,
      ];
}
