import 'dart:async';

import 'package:generic_repository/generic_repository.dart';
import 'package:isar/isar.dart';

class ReadRepositoryImpl<EntityType> implements ReadRepository<EntityType> {
  final IsarCollection<EntityType> isarCollection;
  ReadRepositoryImpl({required this.isarCollection});

  @override
  FutureOr<Iterable<EntityType>?>? getAll() async {
    return await isarCollection.where().findAll();
  }

  @override
  FutureOr<Iterable<EntityType>?>? getBySpec(Spec<EntityType> spec) async {
    return await isarCollection.buildQuery<EntityType>().findAll();
  }

  @override
  FutureOr<EntityType?>? getFirst() async {
    return await isarCollection.where().findFirst();
  }
}
