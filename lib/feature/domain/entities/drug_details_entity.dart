import 'package:equatable/equatable.dart';

class DrugDetailsEntity extends Equatable {
  final int id;
  final String tradeLabel;
  final String manufacturerName;
  final String packagingDescription;
  final String compositionDescription;
  final String compositionInn;
  final String compositionPharmForm;

  const DrugDetailsEntity({
    required this.id,
    required this.tradeLabel,
    required this.manufacturerName,
    required this.packagingDescription,
    required this.compositionDescription,
    required this.compositionInn,
    required this.compositionPharmForm,
  });

  @override
  List<Object> get props => [
        id,
        tradeLabel,
        manufacturerName,
        packagingDescription,
        compositionDescription,
        compositionInn,
        compositionPharmForm,
      ];
}
