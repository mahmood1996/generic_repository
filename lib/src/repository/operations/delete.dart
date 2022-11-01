import 'dart:async';
import 'package:generic_repository/generic_repository.dart';

abstract class Delete<EntityType> {
  FutureOr<void>? delete(EntityType entityType);
  FutureOr<void>? deleteBySpec(Spec<EntityType> spec);
  FutureOr<void>? deleteAll();
}