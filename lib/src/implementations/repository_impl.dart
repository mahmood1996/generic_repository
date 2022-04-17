import 'dart:async';
import 'package:generic_repository/generated/objectbox.g.dart';
import 'package:generic_repository/generic_repository.dart';
import 'package:generic_repository/src/interfaces/entity/entity.dart';
import 'package:objectbox/objectbox.dart';

class RepositoryImpl<EntityType extends BaseEntity>
    implements BaseRepository<EntityType> {
  final Box<EntityType> storeBox;
  RepositoryImpl({required this.storeBox});

  @override
  FutureOr<void> add(EntityType entity) async {
    storeBox.put(entity, mode: PutMode.insert);
  }

  @override
  FutureOr<void>? addAll(Iterable<EntityType> entities) {
    storeBox.putMany(List.from(entities), mode: PutMode.insert);
  }

  @override
  FutureOr<void>? delete(EntityType entityType) {
    storeBox.remove(entityType.id);
  }

  @override
  FutureOr<void>? deleteAll() {
    storeBox.removeAll();
  }

  @override
  FutureOr<Iterable<EntityType>?>? getAll() {
    return storeBox.getAll();
  }

  @override
  FutureOr<Iterable<EntityType>?>? getBySpec(Spec<EntityType> spec) {
    throw UnimplementedError();
  }

  @override
  FutureOr<void>? deleteBySpec(Spec<EntityType> spec) {
    throw UnimplementedError();
  }

  @override
  FutureOr<void> updateBySpec(Spec<EntityType> spec, EntityType data) {
    throw UnimplementedError();
  }

  @override
  FutureOr<void> update(EntityType data) {
    storeBox.put(data, mode: PutMode.update);
  }
}
