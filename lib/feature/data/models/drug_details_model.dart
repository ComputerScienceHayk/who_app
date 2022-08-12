import 'package:sdh_task/feature/domain/entities/drug_details_entity.dart';

class DrugDetailsModel extends DrugDetailsEntity {
  const DrugDetailsModel({
    required id,
    required tradeLabel,
    required manufacturerName,
    required packagingDescription,
    required compositionDescription,
    required compositionInn,
    required compositionPharmForm,
  }) : super(
          id: id,
          tradeLabel: tradeLabel,
          manufacturerName: manufacturerName,
          packagingDescription: packagingDescription,
          compositionDescription: compositionDescription,
          compositionInn: compositionInn,
          compositionPharmForm: compositionPharmForm,
        );

  factory DrugDetailsModel.fromJson(Map<String, dynamic> json) {
    return DrugDetailsModel(
      id: json['id'],
      tradeLabel: json['trade_label']['name'],
      manufacturerName: json['manufacturer']['name'],
      packagingDescription: json['packaging']['description'],
      compositionDescription: json['composition']['description'],
      compositionInn: json['composition']['inn']['name'],
      compositionPharmForm: json['composition']['pharm_form']['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tradeLabel': tradeLabel,
      'manufacturerName': manufacturerName,
      'packagingDescription': packagingDescription,
      'compositionDescription': compositionPharmForm,
      'compositionInn': compositionInn,
      'compositionPharmForm': compositionPharmForm,
    };
  }
}
