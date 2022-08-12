import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sdh_task/common/base_url.dart';
import 'package:sdh_task/core/error/exception.dart';
import 'package:sdh_task/feature/data/models/drugs_list_model.dart';

abstract class DrugsListRemoteDataSource {
  Future<DrugsListModel> getDrugsList(int page);
}

class DrugsListRemoteDataSourceImpl implements DrugsListRemoteDataSource {
  final http.Client client;

  DrugsListRemoteDataSourceImpl({required this.client});

  @override
  Future<DrugsListModel> getDrugsList(int page) => _getDrugsListFromUrl(
        '${BaseUrl.host}?page=$page',
      );

  Future<DrugsListModel> _getDrugsListFromUrl(String url) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'charset': 'utf-8',
      },
    );
    if (response.statusCode == 200) {
      var responseJson = jsonDecode(
        utf8.decode(
          response.bodyBytes,
        ),
      ) as Map<String, dynamic>;
      return DrugsListModel.fromJson(responseJson);
    } else {
      throw ServerException();
    }
  }
}
