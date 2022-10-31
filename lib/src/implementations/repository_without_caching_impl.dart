import 'package:dartz/dartz.dart';
import 'package:generic_repository/generic_repository.dart';

class RepositoryWithoutCachingImpl<EntityType extends Entity>
    implements Repository<EntityType> {
  late final AppConnectivity appConnectivity;
  late final RemoteDataSource<EntityType> remoteDataSource;

  RepositoryWithoutCachingImpl({
    required this.appConnectivity,
    required this.remoteDataSource,
  });

  /// [getAll] will get all entities from the [RemoteDataSource]
  /// But if the app is offline it will return [NetworkFailure]
  /// Also it will return [ServerFailure] if [RemoteDataSource] implementation throws [ServerException]
  /// And it will return [DataAccessFailure] if [RemoteDataSource] implementation throws [UnauthorizedAccessException]
  @override
  Future<Either<Failure, List<EntityType>>> getAll(
      [Params params = const NullParams()]) async {
    return await _catchExceptionsOrReturnResult(() async =>
        await _isAppOffline()
            ? Left(NetworkFailure())
            : Right(await remoteDataSource.getAll(params)!));
  }

  /// [getById] will get an entity by id from the [RemoteDataSource]
  /// But if the app is offline it will return [NetworkFailure]
  /// Also it will return [ServerFailure] if [RemoteDataSource] implementation throws [ServerException]
  /// And it will return [DataAccessFailure] if [RemoteDataSource] implementation throws [UnauthorizedAccessException]
  @override
  Future<Either<Failure, EntityType>> getById(int id) async {
    return await _catchExceptionsOrReturnResult(() async =>
        await _isAppOffline()
            ? Left(NetworkFailure())
            : Right(await remoteDataSource.getById(id)!));
  }

  Future<Either<Failure, ResultType>>
      _catchExceptionsOrReturnResult<ResultType>(
          Future<Either<Failure, ResultType>> Function() callback) async {
    try {
      return await callback();
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on UnauthorizedAccessException catch (e) {
      return Left(DataAccessFailure(message: e.message));
    }
  }

  Future<bool> _isAppOffline() async => !await appConnectivity.isOnline!;
}
