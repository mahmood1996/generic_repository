import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Todo: Get All Entities with(out) params
// Todo:
// Todo:
// Todo: should
// Todo: should

void main() {
  late AppConnectivity appConnectivity;
  late Repository<Entity> repository;
  late RemoteDataSource<Entity> remoteDataSource;

  setUp(() {
    appConnectivity = MockAppConnectivity();
    remoteDataSource = MockRemoteDataSource();
    repository = RepositoryWithoutCachingImpl(
        appConnectivity: appConnectivity, remoteDataSource: remoteDataSource);
  });

  void _makeAppOffline() {
    when(appConnectivity.isOnline).thenAnswer((_) => Future.value(false));
  }

  void _makeAppOnline() {
    when(appConnectivity.isOnline).thenAnswer((_) => Future.value(true));
  }

  group('Repository without caching should', () {
    test('return network failure when app is offline', () async {
      _makeAppOffline();

      Either<Failure, List<Entity>> result = await repository.getAll();

      var failure = result.fold((failure) => failure, (success) => null);
      expect(failure, isA<NetworkFailure>());
    });
    test('return all entities', () async {
      _makeAppOnline();
      var expectedEntities = [Entity(), Entity(), Entity()];

      when(remoteDataSource.getAll()).thenAnswer((_) async => expectedEntities);

      Either<Failure, List<Entity>> result = await repository.getAll();

      var entities = result.fold((failure) => null, (success) => success);
      expect(entities, expectedEntities);
    });
    test('return server failure when server failed to return result', () async {
      _makeAppOnline();
      var message = 'fake message from server';

      when(remoteDataSource.getAll()).thenThrow(ServerException(
        message: message
      ));

      Either<Failure, List<Entity>> result = await repository.getAll();

      var failure = result.fold((failure) => failure, (success) => success);
      expect(failure, isA<ServerFailure> ());
      expect((failure as Failure).message, message);
    });
    test('return data-access failure when access is unauthorized', () async {
      _makeAppOnline();
      var message = 'fake message from server';

      when(remoteDataSource.getAll()).thenThrow(UnauthorizedAccessException(
        message: message
      ));

      Either<Failure, List<Entity>> result = await repository.getAll();

      var failure = result.fold((failure) => failure, (success) => success);
      expect(failure, isA<DataAccessFailure> ());
      expect((failure as Failure).message, message);
    });
  });
}

class DataAccessFailure extends Failure {
  @override
  final String message;
  DataAccessFailure({this.message = ''});
}

class UnauthorizedAccessException implements Exception {
  final String message;
  UnauthorizedAccessException({this.message = ''});
}

class ServerFailure extends Failure {
  @override
  final String message;

  ServerFailure({this.message  = ''});
}

class ServerException implements Exception {
  final String message;
  ServerException({this.message  = ''});
}

class MockRemoteDataSource extends Mock implements RemoteDataSource<Entity> {}

abstract class RemoteDataSource<EntityType> {
  Future<List<EntityType>>? getAll();
}

class NetworkFailure extends Failure {}

class Failure {
  String get message => '';
}

class RepositoryWithoutCachingImpl implements Repository<Entity> {
  late final AppConnectivity appConnectivity;
  late final RemoteDataSource<Entity> remoteDataSource;

  RepositoryWithoutCachingImpl({
    required this.appConnectivity,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Entity>>> getAll() async {
    try {
      if (await appConnectivity.isOnline!) {
        return Right(await remoteDataSource.getAll()!);
      }
      return Left(NetworkFailure());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on UnauthorizedAccessException catch(e) {
      return Left(DataAccessFailure(message: e.message));
    }
  }
}

class Entity {}

abstract class Repository<EntityType> {
  Future<Either<Failure, List<EntityType>>> getAll();
}

class MockAppConnectivity extends Mock implements AppConnectivity {}

abstract class AppConnectivity {
  Future<bool>? get isOnline;
}
