import 'dart:async';
import 'package:generic_repository/common/interfaces/spec.dart';

abstract class Get<EntityType> {
  FutureOr<Iterable<EntityType>?>? getAll();
  FutureOr<EntityType?>? getFirst();
  FutureOr<Iterable<EntityType>?>? getBySpec(Spec<EntityType> spec);
}
