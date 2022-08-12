import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sdh_task/common/base_url.dart';
import 'package:sdh_task/core/error/exception.dart';
import 'package:sdh_task/feature/data/models/drug_details_model.dart';

abstract class DrugDetailsRemoteDataSource {
  Future<DrugDetailsModel> getDrugDetails(int id);
}

class DrugDetailsRemoteDataSourceImpl implements DrugDetailsRemoteDataSource {
  final http.Client client;

  DrugDetailsRemoteDataSourceImpl({required this.client});

  @override
  Future<DrugDetailsModel> getDrugDetails(int id) => _getDrugDetailsFromUrl(
        '${BaseUrl.host}$id',
      );

  Future<DrugDetailsModel> _getDrugDetailsFromUrl(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'charset': 'utf-8',
      },
    );
    if (response.statusCode == 200) {
      var responseJson = jsonDecode(
        utf8.decode(response.bodyBytes),
      ) as Map<String, dynamic>;
      return DrugDetailsModel.fromJson(responseJson);
    } else {
      throw ServerException();
    }
  }
}
