import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:generic_repository/generic_repository.dart';

void main() {
  late AppConnectivity appConnectivity;
  late Repository<Entity> repository;
  late RemoteDataSource<Entity> remoteDataSource;

  setUp(() {
    appConnectivity = MockAppConnectivity();
    remoteDataSource = MockRemoteDataSource();
    repository = RepositoryWithoutCachingImpl(
      appConnectivity: appConnectivity,
      remoteDataSource: remoteDataSource
    );
  });

  void _makeAppOffline() {
    when(appConnectivity.isOnline).thenAnswer((_) => Future.value(false));
  }

  void _makeAppOnline() {
    when(appConnectivity.isOnline).thenAnswer((_) => Future.value(true));
  }

  group('Repository without caching', () {
    void _testReturningNetworkFailureWhenAppIsOfflineOn(
        Future<Either<Failure, dynamic>> Function() action) {
      test('return network failure when app is offline', () async {
        _makeAppOffline();

        var result = await action();

        var failure = result.fold((failure) => failure, (success) => null);
        expect(failure, isA<NetworkFailure>());
      });
    }

    group('when get all entities then', () {
      _testReturningNetworkFailureWhenAppIsOfflineOn(
          () async => await repository.getAll());
      test('return all entities', () async {
        _makeAppOnline();
        var expectedEntities = [Entity(id: 0), Entity(id: 1), Entity(id: 2)];
        Params params = const NullParams();
        when(remoteDataSource.getAll(params))
            .thenAnswer((_) async => expectedEntities);

        Either<Failure, List<Entity>> result = await repository.getAll(params);

        var entities = result.fold((failure) => null, (success) => success);
        expect(entities, expectedEntities);
      });
      test('return server failure when server fails to return the result',
          () async {
        _makeAppOnline();
        var message = 'fake message from server';

        when(remoteDataSource.getAll())
            .thenThrow(ServerException(message: message));

        Either<Failure, List<Entity>> result = await repository.getAll();

        var failure = result.fold((failure) => failure, (success) => success);
        expect(failure, isA<ServerFailure>());
        expect((failure as Failure).message, message);
      });
      test('return data-access failure when access is unauthorized', () async {
        _makeAppOnline();
        var message = 'fake message from server';

        when(remoteDataSource.getAll())
            .thenThrow(UnauthorizedAccessException(message: message));

        Either<Failure, List<Entity>> result = await repository.getAll();

        var failure = result.fold((failure) => failure, (success) => success);
        expect(failure, isA<DataAccessFailure>());
        expect((failure as Failure).message, message);
      });
    });

    group('when get an entity by id then', () {
      _testReturningNetworkFailureWhenAppIsOfflineOn(() async {
        int anyId = 0;
        return await repository.getById(anyId);
      });
      test('return an entity by id', () async {
        _makeAppOnline();
        int anyId = 0;
        var expectedEntity = Entity(id: anyId);

        when(remoteDataSource.getById(anyId))
            .thenAnswer((_) => Future.value(expectedEntity));

        Either<Failure, Entity> result = await repository.getById(anyId);

        var entities = result.fold((failure) => null, (success) => success);
        expect(entities, expectedEntity);
      });
      test('return server failure when server fails to return the result',
          () async {
        _makeAppOnline();
        var message = 'fake message from server';
        int anyId = 0;
        when(remoteDataSource.getById(anyId))
            .thenThrow(ServerException(message: message));

        var result = await repository.getById(anyId);

        var failure = result.fold((failure) => failure, (success) => null);
        expect(failure, isA<ServerFailure>());
        expect((failure as Failure).message, message);
      });
      test('return data-access failure when access is unauthorized', () async {
        _makeAppOnline();
        var message = 'fake message from server';
        int anyId = 0;
        when(remoteDataSource.getById(anyId))
            .thenThrow(UnauthorizedAccessException(message: message));

        var result = await repository.getById(anyId);

        var failure = result.fold((failure) => failure, (success) => null);
        expect(failure, isA<DataAccessFailure>());
        expect((failure as Failure).message, message);
      });
    });
  });
}

class MockRemoteDataSource extends Mock implements RemoteDataSource<Entity> {}

class MockAppConnectivity extends Mock implements AppConnectivity {}
