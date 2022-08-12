import 'package:dartz/dartz.dart';
import 'package:sdh_task/core/error/failure.dart';
import 'package:sdh_task/feature/domain/entities/drug_details_entity.dart';

abstract class DrugDetailsRepository {
  Future<Either<Failure, DrugDetailsEntity>> getDrugDetails(int page);
}