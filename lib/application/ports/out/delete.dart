import 'dart:async';
import 'package:generic_repository/common/interfaces/spec.dart';

abstract class Delete<EntityType> {
  FutureOr<void>? delete(EntityType entityType);
  FutureOr<void>? deleteBySpec(Spec<EntityType> spec);
  FutureOr<void>? deleteAll();
}