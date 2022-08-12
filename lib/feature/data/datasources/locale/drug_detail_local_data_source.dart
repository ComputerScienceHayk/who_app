import 'dart:convert';
import 'package:sdh_task/common/const_texts.dart';
import 'package:sdh_task/core/error/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sdh_task/feature/data/models/drug_details_model.dart';

abstract class DrugDetailsLocalDataSource {
  Future<DrugDetailsModel> getLastDrugFromCache();
  Future<void> drugToCache(DrugDetailsModel drugDetailsModel);
}

class DrugDetailsLocalDataSourceImpl implements DrugDetailsLocalDataSource {
  final SharedPreferences sharedPreferences;
  DrugDetailsLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<DrugDetailsModel> getLastDrugFromCache() {
    final jsonDrugDetails =
        sharedPreferences.getString(ConstTexts.cachedDrugDetails);
    if (jsonDrugDetails?.isNotEmpty ?? false) {
      return Future.value(
        DrugDetailsModel.fromJson(
          json.decode(
            jsonDrugDetails ?? '',
          ),
        ),
      );
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> drugToCache(dynamic drug) {
    final jsonDrug = json.encode(
      drug.toJson(),
    );
    sharedPreferences.setString(
      ConstTexts.cachedDrugDetails,
      jsonDrug,
    );
    return Future.value();
  }
}
