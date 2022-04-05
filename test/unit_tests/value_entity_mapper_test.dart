import 'package:flutter_test/flutter_test.dart';
import 'package:generic_repository/adapters/persistence/data_mappers/value_entity_mapper.dart';
import 'package:generic_repository/domain/value_entity.dart';

class ValueEntityMapperTest {
  static late ValueEntityMapper _valueEntityMapper;

  static void testValueEntityMapper() {
    setUp(() {
      _valueEntityMapper = ValueEntityMapper();
    });

    group('Value Entity Mapper Tests', () {
      _testEncoding();
      _testDecoding();
    });
  }

  static void _testEncoding() {
    test('Testing encode', () {
      var stringValueEntity = ValueEntity('hello');
      expect(_valueEntityMapper.encode(stringValueEntity),
          {'type': '${stringValueEntity.runtimeType}', 'data': 'hello'});

      var intValueEntity = ValueEntity(2);
      expect(_valueEntityMapper.encode(intValueEntity),
          {'type': '${intValueEntity.runtimeType}', 'data': 2});
    });
  }

  static void _testDecoding() {
    test('Testing decode', () {
      expect(
          _valueEntityMapper
              .decode({'type': '${ValueEntity<String>}', 'data': 'hello'}),
          ValueEntity('hello'));

      expect(
          _valueEntityMapper
              .decode({'type': '${ValueEntity<int>}', 'data': 1}),
          ValueEntity(1));
    });
  }
}
