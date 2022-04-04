import 'package:flutter_test/flutter_test.dart';
import 'package:generic_repository/adapters/persistence/data_mappers/general_entity_mapper.dart';
import 'package:generic_repository/adapters/persistence/data_mappers/list_entity_mapper.dart';
import 'package:generic_repository/domain/list_entity.dart';
import 'package:generic_repository/domain/object_entity.dart';

class ListEntityMapperTest {
  static late ListEntityMapper _listEntityMapper;

  static void testListEntityMapper() {
    setUp(() {
      _listEntityMapper = ListEntityMapper(entityMapper: GeneralEntityMapper());
    });
    group('List Entity Mapper Tests', () {
      _testEncoding();
      _testDecoding();
    });
  }

  static void _testEncoding() {
    test('Testing encode -with-no-elements', () {
      expect(_listEntityMapper.encode(ListEntity([])),
          {'type': '$ListEntity', 'data': []});
    });
    test('Testing encode -with-elements', () {
      expect(
          _listEntityMapper
              .encode(ListEntity([ListEntity([])])),
          {
            'type': '$ListEntity',
            'data': [
              {'type': '$ListEntity', 'data': []}
            ]
          });
      expect(
          _listEntityMapper
              .encode(ListEntity([ListEntity([]), ObjectEntity({})])),
          {
            'type': '$ListEntity',
            'data': [
              {'type': '$ListEntity'  , 'data': []},
              {'type': '$ObjectEntity', 'data': {}},
            ]
          });
    });
  }

  static void _testDecoding() {}
}
