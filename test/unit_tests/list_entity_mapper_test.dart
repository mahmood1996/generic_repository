import 'package:flutter_test/flutter_test.dart';
import 'package:generic_repository/adapters/persistence/data_mappers/list_entity_mapper.dart';
import 'package:generic_repository/domain/list_entity.dart';

class ListEntityMapperTest {
  static late ListEntityMapper _listEntityMapper;

  static void testListEntityMapper() {
    setUp(() {
      _listEntityMapper = ListEntityMapper();
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
      expect(_listEntityMapper.encode(ListEntity([ListEntity([])])), {
        'type': '$ListEntity',
        'data': [
          {'type': '$ListEntity', 'data': []}
        ]
      });
    });
  }

  static void _testDecoding() {
    test('Testing decode -with-no-elements', () {
      expect(_listEntityMapper.decode({'type': '$ListEntity', 'data': []}),
          ListEntity([]));
    });
    test('Testing decode -with-elements', () {
      expect(
          _listEntityMapper.decode({
            'type': '$ListEntity',
            'data': [
              {'type': '$ListEntity', 'data': []},
              {'type': '$ListEntity', 'data': []}
            ]
          }),
          ListEntity([ListEntity([]), ListEntity([])]));
      expect(
          _listEntityMapper.decode({
            'type': '$ListEntity',
            'data': [
              {
                'type': '$ListEntity',
                'data': [
                  {'type': '$ListEntity', 'data': []}
                ]
              },
              {'type': '$ListEntity', 'data': []}
            ]
          }),
          ListEntity([
            ListEntity([ListEntity([])]),
            ListEntity([])
          ]));
    });
  }
}
