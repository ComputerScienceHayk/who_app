import 'package:dartz/dartz.dart';
import 'package:sdh_task/core/error/failure.dart';
import 'package:sdh_task/feature/domain/entities/drugs_list_entity.dart';

abstract class DrugsListRepository {
  Future<Either<Failure, DrugsListEntity>> getDrugsList(int page);
}