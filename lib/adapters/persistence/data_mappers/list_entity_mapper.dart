import 'package:generic_repository/adapters/persistence/data_mappers/entity_mapper.dart';
import 'package:generic_repository/domain/entity.dart';
import 'package:generic_repository/domain/list_entity.dart';

class ListEntityMapper implements EntityMapper<ListEntity> {
  final EntityMapper<Entity>? entityMapper;
  ListEntityMapper({this.entityMapper});

  @override
  ListEntity decode(Map<String, dynamic> data) {
    // ToDo: Add decoding functionality
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> encode(ListEntity data) {
    var expectedResult = {'type': '$ListEntity', 'data': []};
    if (entityMapper == null) return expectedResult;
    expectedResult['data'] = [
      ...data.allEntities.map((entity) => entityMapper!.encode(entity))
    ];
    return expectedResult;
  }
}
