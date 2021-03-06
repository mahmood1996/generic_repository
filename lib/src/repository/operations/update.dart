import 'dart:async';
import 'package:generic_repository/generic_repository.dart';

abstract class Update<EntityType> {
  FutureOr<void> update(EntityType entity);
}
