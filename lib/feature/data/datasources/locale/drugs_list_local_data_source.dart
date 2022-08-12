import 'dart:convert';
import 'package:sdh_task/common/const_texts.dart';
import 'package:sdh_task/core/error/exception.dart';
import 'package:sdh_task/feature/data/models/drugs_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class DrugsListLocalDataSource {
  Future<DrugsListModel> getLastDrugsListFromCache();
  Future<void> drugsListToCache(DrugsListModel persons);
}

class DrugsListLocalDataSourceImpl implements DrugsListLocalDataSource {
  DrugsListLocalDataSourceImpl({required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  @override
  Future<DrugsListModel> getLastDrugsListFromCache() {
    final jsonDrugsList =
        sharedPreferences.getString(ConstTexts.cachedDrugsList);
    if (jsonDrugsList!.isNotEmpty) {
      return Future.value(
        DrugsListModel.fromJson(
          json.decode(jsonDrugsList),
        ),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> drugsListToCache(DrugsListModel drugsListModel) {
    final jsonDrugsListModel = json.encode(
      drugsListModel.toJson(),
    );
    sharedPreferences.setString(
      ConstTexts.cachedDrugsList,
      jsonDrugsListModel,
    );
    return Future.value();
  }
}
