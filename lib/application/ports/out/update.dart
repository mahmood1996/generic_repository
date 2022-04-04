import 'dart:async';
import 'package:generic_repository/common/interfaces/spec.dart';

abstract class Update<EntityType> {
  FutureOr<void> updateBySpec(Spec<EntityType> spec, EntityType data);
}