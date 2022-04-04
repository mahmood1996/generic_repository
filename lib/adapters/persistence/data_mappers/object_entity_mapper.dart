import 'package:generic_repository/adapters/persistence/data_mappers/entity_mapper.dart';
import 'package:generic_repository/domain/entity.dart';
import 'package:generic_repository/domain/object_entity.dart';

class ObjectEntityMapper implements EntityMapper<ObjectEntity> {
  final EntityMapper<Entity>? entityMapper;
  ObjectEntityMapper({this.entityMapper});

  @override
  ObjectEntity decode(Map<String, dynamic> data) {
    return ObjectEntity(_decodeFields(data['data']));
  }

  Map<String, Entity> _decodeFields(Map<String, dynamic> data) {
    var _decodingResult = <String, Entity> {};
    if (entityMapper == null) return _decodingResult;
    for (String key in data.keys) {
      _decodingResult[key] = entityMapper!.decode(data[key]);
    }
    return _decodingResult;
  }

  @override
  Map<String, dynamic> encode(ObjectEntity data) {
    return {
      'type': data.runtimeType.toString(),
      'data': _encodeFields(data),
    };
  }

  Map<String, dynamic> _encodeFields(ObjectEntity data) {
    var encodedMap = <String, dynamic> {};
    if (entityMapper == null) return encodedMap;
    for (String entityKey in data.keysOfEntities) {
      encodedMap[entityKey] = entityMapper!.encode(data.getEntity(entityKey)!);
    }
    return encodedMap;
  }
}
