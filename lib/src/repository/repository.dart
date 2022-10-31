import 'package:dartz/dartz.dart';
import 'package:generic_repository/generic_repository.dart';

abstract class Repository<EntityType> {
  Future<Either<Failure, List<EntityType>>> getAll(
      [Params params = const NullParams()]);

  Future<Either<Failure, EntityType>> getById(int id);
}
