import 'dart:async';

import 'package:generic_repository/generic_repository.dart';
import 'package:isar/isar.dart';

class BaseRepositoryImpl<EntityType> implements BaseRepository<EntityType> {
  late final ReadRepository<EntityType> _readRepository;
  final IsarCollection<EntityType> isarCollection;

  BaseRepositoryImpl({required this.isarCollection}) {
    _readRepository = ReadRepositoryImpl(isarCollection: isarCollection);
  }

  @override
  FutureOr<void>? add(EntityType entity) {
    throw UnimplementedError();
  }

  @override
  FutureOr<void>? addAll(Iterable<EntityType> entities) {
    throw UnimplementedError();
  }

  @override
  FutureOr<void>? delete(EntityType entityType) {
    throw UnimplementedError();
  }

  @override
  FutureOr<void>? deleteAll() {
    throw UnimplementedError();
  }

  @override
  FutureOr<void>? deleteBySpec(Spec<EntityType> spec) {
    throw UnimplementedError();
  }

  @override
  FutureOr<Iterable<EntityType>?>? getAll() async {
    return await _readRepository.getAll();
  }

  @override
  FutureOr<Iterable<EntityType>?>? getBySpec(Spec<EntityType> spec) async {
    return await _readRepository.getBySpec(spec);
  }

  @override
  FutureOr<EntityType?>? getFirst() async {
    return await _readRepository.getFirst();
  }

  @override
  FutureOr<void> updateBySpec(Spec<EntityType> spec, EntityType data) {
    throw UnimplementedError();
  }
}
