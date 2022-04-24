import 'package:generic_repository/generic_repository.dart';

abstract class ReadRepository<EntityType extends Entity> implements Get<EntityType> {}
