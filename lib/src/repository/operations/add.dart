import 'dart:async';

abstract class Add<EntityType> {
  FutureOr<void>? add(EntityType entity);
  FutureOr<void>? addAll(Iterable<EntityType> entities);
}