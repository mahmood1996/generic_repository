import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:generic_repository/src/entities/entity.dart';
import 'package:mocktail/mocktail.dart';

// Todo: Save all entities with page index
// Todo: Save an entity
// Todo: Get all entities of specific page index

void main() {
  late StorageAdapter _storageAdapter;
  late LocalDataSource _localDataSource;
  late Deserializer<Entity> _entityDeserializer;

  setUp(() {
    _storageAdapter     = MockStorageAdapter();
    _entityDeserializer = MockEntityDeserializer();
    _localDataSource    = LocalDataSource(
      storageAdapter: _storageAdapter,
      deserializer: _entityDeserializer
    );
  });

  group('Local Data Source', () {
    test('Delete all entities', () async {
      when(() => _storageAdapter.deleteAll()).thenAnswer((_) async {});

      await _localDataSource.deleteAll();

      verify(() => _storageAdapter.deleteAll()).called(1);
    });
    test('Delete an entity by id', () async {
      int anyId = 0;
      when(() => _storageAdapter.delete(anyId)).thenAnswer((_) async {});

      await _localDataSource.delete(anyId);

      verify(() => _storageAdapter.delete(anyId)).called(1);
    });
    test('Delete all entities of specific page index', () async {
      var pageIndex = 0;
      when(() => _storageAdapter.deleteEntitiesOfPage(pageIndex)).thenAnswer((invocation) async {});
      await _localDataSource.deleteEntitiesOfPage(pageIndex);
      verify(() => _storageAdapter.deleteEntitiesOfPage(pageIndex));
    });
    test('Get an entity by id', () async {
      int anyId = 0;
      var expected = Entity(id: anyId);

      when(() => _storageAdapter.getById(anyId)).thenAnswer((_) async => json.encode({'id' : 0}));
      when(() => _entityDeserializer.deserialize({'id' : 0})).thenAnswer((_) => expected);

      var result = await _localDataSource.getById(anyId);
      expect(result, expected);
    });
    test('Throw EntityNotFoundException when getting entity with nonexistent id', () async {
      int anyId = 0;
      when(() => _storageAdapter.getById(anyId)).thenThrow(EntityNotFoundException());
      expect(() async => await _localDataSource.getById(anyId), throwsA(isA<EntityNotFoundException> ()));
    });
    test('Get all entities of specific page index', () async {
      int pageIndex = 0;
      var expectedEntity = Entity(id: 0);
      var expected = [expectedEntity];
      when(() => _storageAdapter.getEntitiesOfPage(pageIndex)).thenAnswer((_) async => json.encode([{
        'id' : 0
      }]));
      when(() => _entityDeserializer.deserialize({
        'id' : 0
      })).thenAnswer((_) => expectedEntity);

      var result = await _localDataSource.getEntitiesOfPage(pageIndex);

      expect(result, equals(expected));
    });
  }, skip: true);
}

class EntityNotFoundException implements Exception {}

class MockEntityDeserializer extends Mock implements Deserializer<Entity> {

}

abstract class Deserializer<ResultType> {
  ResultType deserialize(Map<String, dynamic> json);
}

class MockStorageAdapter extends Mock implements StorageAdapter {

}

class LocalDataSource<EntityType extends Entity> {
  late final StorageAdapter _storageAdapter;
  late final Deserializer<EntityType> _deserializer;

  LocalDataSource({
    required StorageAdapter storageAdapter,
    required Deserializer<EntityType> deserializer
  }) : _storageAdapter = storageAdapter, _deserializer = deserializer;

  Future<void> deleteAll() async => await _storageAdapter.deleteAll();

  Future<void> delete(int id) async => await _storageAdapter.delete(id);

  Future<void> deleteEntitiesOfPage(int pageIndex) async => await _storageAdapter.deleteEntitiesOfPage(pageIndex);

  Future<EntityType> getById(int id) async {
    return _deserializer.deserialize(json.decode(await _storageAdapter.getById(id)));
  }

  Future<List<EntityType>> getEntitiesOfPage(int pageIndex) async {
    return [
      _deserializer.deserialize({'id' : 0})
    ];
  }
}

abstract class StorageAdapter {
  Future<void>   deleteAll();
  Future<void>   delete(int id);
  Future<void>   deleteEntitiesOfPage(int pageIndex);
  Future<String> getById(int id);
  Future<String> getEntitiesOfPage(int pageIndex);
}