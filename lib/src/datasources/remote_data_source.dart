import 'package:generic_repository/generic_repository.dart';

abstract class RemoteDataSource<EntityType> {
  /// [getAll] will get all entities
  /// it should throws [ServerException] if server failed to return result
  /// And it should throws [UnauthorizedAccessException] if access is unauthorized
  Future<List<EntityType>>? getAll([Params params = const NullParams()]);

  /// [getById] will get an entity by [id]
  /// But if the app is offline it will return [NetworkFailure]
  /// it should throws [ServerException] if server failed to return result
  /// And it should throws [UnauthorizedAccessException] if access is unauthorized
  Future<EntityType>? getById(int id);
}
