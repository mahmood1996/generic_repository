import 'package:generic_repository/generic_repository.dart';

abstract class ReadRepository<EntityId> implements Get<Entity<EntityId>> {}
