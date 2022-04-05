import 'package:generic_repository/adapters/persistence/data_mappers/entity_mapper.dart';
import 'package:generic_repository/adapters/persistence/data_mappers/general_entity_mapper.dart';
import 'package:generic_repository/domain/entity.dart';
import 'package:generic_repository/domain/object_entity.dart';

class ObjectEntityMapper implements EntityMapper<ObjectEntity> {
  @override
  ObjectEntity decode(Map<String, dynamic> data) {
    return ObjectEntity(_decodeFields(data['data']));
  }

  Map<String, Entity> _decodeFields(Map<String, dynamic> data) {
    return Map.fromEntries(data.keys.map<MapEntry<String, Entity>>(
        (entityKey) =>
            MapEntry(entityKey, GeneralEntityMapper.decode(data[entityKey]))));
  }

  @override
  Map<String, dynamic> encode(ObjectEntity data) {
    return {
      'type': '$ObjectEntity',
      'data': _encodeFields(data),
    };
  }

  Map<String, dynamic> _encodeFields(ObjectEntity data) {
    return Map.fromEntries(data.keysOfEntities.map<MapEntry<String, dynamic>>(
        (entityKey) => MapEntry(entityKey,
            GeneralEntityMapper.encode(data.getEntity(entityKey)!))));
  }
}
