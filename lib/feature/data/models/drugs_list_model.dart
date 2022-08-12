import 'package:sdh_task/feature/domain/entities/drugs_list_entity.dart';

class DrugsListModel extends DrugsListEntity {
  const DrugsListModel({
    required drugCount,
    required next,
    required previous,
    required result,
  }) : super(
          drugCount: drugCount,
          next: next,
          previous: previous,
          result: result,
        );

  factory DrugsListModel.fromJson(Map<String, dynamic> json) {
    return DrugsListModel(
      drugCount: json['count'],
      next: json['next'],
      previous: json['previous'],
      result: json['results'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': drugCount,
      'next': next,
      'previous': previous,
      'results': result,
    };
  }
}
