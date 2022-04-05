import 'package:generic_repository/adapters/persistence/data_mappers/entity_mapper.dart';
import 'package:generic_repository/adapters/persistence/data_mappers/general_entity_mapper.dart';
import 'package:generic_repository/domain/entity.dart';
import 'package:generic_repository/domain/list_entity.dart';

class ListEntityMapper implements EntityMapper<ListEntity> {
  @override
  ListEntity decode(Map<String, dynamic> data) {
    return ListEntity(_decodeElements(data['data']));
  }

  List<Entity> _decodeElements(List<dynamic> data) {
    return data
        .map<Entity>((element) => GeneralEntityMapper.decode(element))
        .toList();
  }

  @override
  Map<String, dynamic> encode(ListEntity data) {
    return {
      'type': '$ListEntity',
      'data': [
        ...data.allEntities.map((entity) => GeneralEntityMapper.encode(entity))
      ]
    };
  }
}
