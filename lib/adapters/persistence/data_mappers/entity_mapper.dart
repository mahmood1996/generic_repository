import 'package:generic_repository/domain/entity.dart';

abstract class _IObjectMapper<ObjectType, MappingType> {
  ObjectType  decode (MappingType data);
  MappingType encode (ObjectType data);
}

abstract class EntityMapper<EntityType extends Entity> implements _IObjectMapper<EntityType, Map<String, dynamic>> {}