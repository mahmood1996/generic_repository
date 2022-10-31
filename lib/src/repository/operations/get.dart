import 'dart:async';
import 'package:generic_repository/generic_repository.dart';

abstract class Get<EntityType> {
  FutureOr<Iterable<EntityType>?>? getAll();
  FutureOr<EntityType?>? getFirst();
  FutureOr<Iterable<EntityType>?>? getBySpec(Spec<EntityType> spec);
}
