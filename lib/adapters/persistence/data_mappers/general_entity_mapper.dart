import 'package:generic_repository/adapters/persistence/data_mappers/entity_mapper.dart';
import 'package:generic_repository/adapters/persistence/data_mappers/list_entity_mapper.dart';
import 'package:generic_repository/adapters/persistence/data_mappers/object_entity_mapper.dart';
import 'package:generic_repository/domain/entity.dart';

class GeneralEntityMapper extends EntityMapper {
  late final Map<String, EntityMapper> _mappersMap;

  GeneralEntityMapper() {
    _mappersMap = <String, EntityMapper> {
      'ObjectEntity' : ObjectEntityMapper(entityMapper: this),
      'ListEntity'   : ListEntityMapper(entityMapper: this)
    };
  }

  @override
  Entity decode(Map<String, dynamic> data) {
    return _mappersMap[data['type']]!.decode(data);
  }

  @override
  Map<String, dynamic> encode(Entity data) {
    return _mappersMap[data.runtimeType.toString()]!.encode(data);
  }
}