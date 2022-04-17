import 'dart:async';
import 'package:generic_repository/generic_repository.dart';

abstract class Get<EntityType> {
  FutureOr<Iterable<EntityType>?>? getAll();
  FutureOr<Iterable<EntityType>?>? getBySpec(Spec<EntityType> spec);
}
