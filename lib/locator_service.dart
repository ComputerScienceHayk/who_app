import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sdh_task/feature/data/datasources/remote/drug_details_remote_data_source.dart';
import 'package:sdh_task/feature/data/repositories/drug_details_repository_impl.dart';
import 'package:sdh_task/feature/data/repositories/drugs_list_repository_impl.dart';
import 'package:sdh_task/feature/domain/repositories/drug_details_repository.dart';
import 'package:sdh_task/feature/domain/repositories/drugs_list_repository.dart';
import 'package:sdh_task/feature/domain/uscases/get_drug_details.dart';
import 'package:sdh_task/feature/domain/uscases/get_drugs_list.dart';
import 'package:sdh_task/feature/presentation/bloc/drugs_list_cubit/drugs_list_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sdh_task/core/platform/network_info.dart';
import 'package:sdh_task/feature/data/datasources/remote/drugs_list_remote_data_source.dart';
import 'package:sdh_task/feature/presentation/bloc/drug_details_cubit/drug_details_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:sdh_task/feature/presentation/bloc/connection_checker_cubit/connection_checker_cubit.dart';
import 'package:sdh_task/feature/data/datasources/locale/drugs_list_local_data_source.dart';

import 'feature/data/datasources/locale/drug_detail_local_data_source.dart';

final sl = GetIt.instance;

Future<void> init() async {

  // BLoC / Cubit
  sl.registerFactory(
        () => DrugsListCubit(getDrugsList: sl()),
  );

  sl.registerFactory(
        () => DrugDetailsCubit(getDrugDetails: sl()),
  );

  sl.registerFactory(
        () => ConnectionCheckerCubit(),
  );

  sl.registerLazySingleton(() => GetDrugsList(sl()));

  sl.registerLazySingleton(() => GetDrugDetails(sl()));


  // Repository
  sl.registerLazySingleton<DrugsListRepository>(
        () => DrugsListRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Repository
  sl.registerLazySingleton<DrugDetailsRepository>(
        () => DrugDetailsRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<DrugsListRemoteDataSource>(
        () => DrugsListRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  sl.registerLazySingleton<DrugDetailsRemoteDataSource>(
        () => DrugDetailsRemoteDataSourceImpl(
      client: sl(),
    ),
  );

  // locale

  sl.registerLazySingleton<DrugsListLocalDataSource>(
        () => DrugsListLocalDataSourceImpl(sharedPreferences: sl()),
  );

  sl.registerLazySingleton<DrugDetailsLocalDataSource>(
        () => DrugDetailsLocalDataSourceImpl(sharedPreferences: sl()),
  );


  // Core
  sl.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImp(sl()),
  );

  // External
  final  sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
