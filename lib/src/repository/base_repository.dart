import 'package:generic_repository/generic_repository.dart';

abstract class BaseRepository<EntityId>
    implements
        Add<Entity<EntityId>>,
        Update<Entity<EntityId>>,
        Delete<Entity<EntityId>>,
        ReadRepository<EntityId> {}
