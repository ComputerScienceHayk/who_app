import 'package:dartz/dartz.dart';
import 'package:sdh_task/core/error/failure.dart';
import 'package:sdh_task/core/error/exception.dart';
import 'package:sdh_task/core/platform/network_info.dart';
import 'package:sdh_task/feature/data/models/drugs_list_model.dart';
import 'package:sdh_task/feature/domain/entities/drugs_list_entity.dart';
import 'package:sdh_task/feature/domain/repositories/drugs_list_repository.dart';
import 'package:sdh_task/feature/data/datasources/locale/drugs_list_local_data_source.dart';
import 'package:sdh_task/feature/data/datasources/remote/drugs_list_remote_data_source.dart';

class DrugsListRepositoryImpl implements DrugsListRepository {
  final DrugsListRemoteDataSource remoteDataSource;
  final DrugsListLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  DrugsListRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, DrugsListEntity>> getDrugsList(int page) async {
    return await _getDrugsList(() {
      return remoteDataSource.getDrugsList(page);
    });
  }

  Future<Either<Failure, DrugsListModel>> _getDrugsList(
      Future<DrugsListModel> Function() getDrugsList) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteDrugsList = await getDrugsList();
        localDataSource.drugsListToCache(remoteDrugsList);
        return Right(remoteDrugsList);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localDrugsList =
            await localDataSource.getLastDrugsListFromCache();
        return Right(localDrugsList);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
