import 'package:generic_repository/adapters/persistence/data_mappers/entity_mapper.dart';
import 'package:generic_repository/adapters/persistence/data_mappers/list_entity_mapper.dart';
import 'package:generic_repository/adapters/persistence/data_mappers/object_entity_mapper.dart';
import 'package:generic_repository/adapters/persistence/data_mappers/value_entity_mapper.dart';
import 'package:generic_repository/domain/entity.dart';

class GeneralEntityMapper {
  static late final Map<String, EntityMapper> _mappersMap =
      <String, EntityMapper>{
    'ObjectEntity': ObjectEntityMapper(),
    'ListEntity': ListEntityMapper(),
    'ValueEntity<String>': ValueEntityMapper<String>(),
    'ValueEntity<num>': ValueEntityMapper<num>(),
  };

  static void addEntityMappers(Iterable<EntityMapper> entityMapper) {}

  static Entity decode(Map<String, dynamic> data) {
    return _mappersMap[data['type']]!.decode(data);
  }

  static Map<String, dynamic> encode(Entity data) {
    return _mappersMap[data.runtimeType.toString()]!.encode(data);
  }
}
