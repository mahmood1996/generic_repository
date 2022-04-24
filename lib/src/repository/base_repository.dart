import 'package:generic_repository/generic_repository.dart';

abstract class BaseRepository<EntityType extends Entity>
    implements
        Add<EntityType>,
        Update<EntityType>,
        Delete<EntityType>,
        ReadRepository<EntityType> {}
