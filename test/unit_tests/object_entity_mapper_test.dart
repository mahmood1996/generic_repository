import 'package:flutter_test/flutter_test.dart';
import 'package:generic_repository/adapters/persistence/data_mappers/general_entity_mapper.dart';
import 'package:generic_repository/adapters/persistence/data_mappers/object_entity_mapper.dart';
import 'package:generic_repository/domain/entity.dart';
import 'package:generic_repository/domain/object_entity.dart';

class ObjectEntityMapperTest {
  static late ObjectEntityMapper _objectEntityMapper;

  static void testObjectEntityMapper() {
    setUp(() {
      _objectEntityMapper =
          ObjectEntityMapper(entityMapper: GeneralEntityMapper());
    });
    group('Object Entity Mapper Tests', () {
      _testEncoding();
      _testDecoding();
    });
  }

  static void _testEncoding() {
    test('Testing encode -with-no-variables', () {
      expect(_objectEntityMapper.encode(ObjectEntity({})),
          {'type': '$ObjectEntity', 'data': {}});
    });
    test('Testing encode -with-object-variables', () {
      var expectedResult = {
        'type': '$ObjectEntity',
        'data': {
          'object1': {'type': '$ObjectEntity', 'data': {}},
        }
      };
      expect(
          _objectEntityMapper
              .encode(ObjectEntity({'object1': ObjectEntity({})})),
          expectedResult);

      expectedResult = {
        'type': '$ObjectEntity',
        'data': {
          'object1': {'type': '$ObjectEntity', 'data': {}},
          'object2': {
            'type': '$ObjectEntity',
            'data': {
              'object3': {'type': '$ObjectEntity', 'data': {}}
            }
          },
        }
      };
      expect(
          _objectEntityMapper.encode(ObjectEntity({
            'object1': ObjectEntity({}),
            'object2': ObjectEntity({'object3': ObjectEntity({})})
          })),
          expectedResult);
    });
  }
  static void _testDecoding() {
    test('Testing decode -with-no-variables', () {
      expect(
          _objectEntityMapper
              .decode({'type': '$ObjectEntity', 'data': <String, dynamic>{}}),
          ObjectEntity(<String, Entity>{}));
    });
    test('Testing decode -with-object-variables', () {
      expect(
          _objectEntityMapper.decode({
            'type': '$ObjectEntity',
            'data': {
              'object1': {'type': '$ObjectEntity', 'data': <String, dynamic>{}},
            }
          }),
          ObjectEntity({'object1': ObjectEntity({})}));
    });
  }
}
