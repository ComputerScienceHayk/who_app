import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sdh_task/core/error/failure.dart';
import 'package:sdh_task/core/usecases/usecase.dart';
import 'package:sdh_task/feature/domain/entities/drugs_list_entity.dart';
import 'package:sdh_task/feature/domain/repositories/drugs_list_repository.dart';

class GetDrugsList extends UseCase<DrugsListEntity, DrugsListParams> {
  final DrugsListRepository drugsListRepository;

  GetDrugsList(this.drugsListRepository);

  @override
  Future<Either<Failure, DrugsListEntity>> call(DrugsListParams params) async {
    return await drugsListRepository.getDrugsList(params.page);
  }
}

class DrugsListParams extends Equatable {
  final int page;

  const DrugsListParams({
    required this.page,
  });

  @override
  List<Object> get props => [
        page,
      ];
}
