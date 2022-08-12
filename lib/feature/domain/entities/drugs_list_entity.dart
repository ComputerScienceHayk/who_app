import 'package:equatable/equatable.dart';

class DrugsListEntity extends Equatable {
  final int drugCount;
  final String? next;
  final String? previous;
  final List<dynamic> result;

  const DrugsListEntity({
    required this.drugCount,
    required this.next,
    required this.previous,
    required this.result,
  });

  @override
  List<Object> get props => [
        drugCount,
        next ?? '',
        previous ?? '',
        result,
      ];
}
