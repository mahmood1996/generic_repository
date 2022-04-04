import 'package:generic_repository/domain/entity.dart';

abstract class IObjectMapper<ObjectType, MappingType> {
  ObjectType  decode (MappingType data);
  MappingType encode (ObjectType data);
}

abstract class EntityMapper<EntityType extends Entity> implements IObjectMapper<EntityType, Map<String, dynamic>> {}