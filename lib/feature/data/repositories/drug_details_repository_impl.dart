import 'package:dartz/dartz.dart';
import 'package:sdh_task/core/error/exception.dart';
import 'package:sdh_task/core/error/failure.dart';
import 'package:sdh_task/core/platform/network_info.dart';
import 'package:sdh_task/feature/data/datasources/locale/drug_detail_local_data_source.dart';
import 'package:sdh_task/feature/data/datasources/remote/drug_details_remote_data_source.dart';
import 'package:sdh_task/feature/data/models/drug_details_model.dart';
import 'package:sdh_task/feature/domain/entities/drug_details_entity.dart';
import 'package:sdh_task/feature/domain/repositories/drug_details_repository.dart';

class DrugDetailsRepositoryImpl implements DrugDetailsRepository {
  final DrugDetailsRemoteDataSource remoteDataSource;
  final DrugDetailsLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  DrugDetailsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, DrugDetailsEntity>> getDrugDetails(int id) async {
    return await _getDrugDetails(() {
      return remoteDataSource.getDrugDetails(id);
    });
  }

  Future<Either<Failure, DrugDetailsModel>> _getDrugDetails(
      Future<DrugDetailsModel> Function() getDrugDetails) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteDrugDetails = await getDrugDetails();
        localDataSource.drugToCache(remoteDrugDetails);
        return Right(remoteDrugDetails);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localDrugDetails = await localDataSource.getLastDrugFromCache();
        return Right(localDrugDetails);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
