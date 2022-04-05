import 'package:flutter_test/flutter_test.dart';
import 'package:generic_repository/adapters/persistence/data_mappers/general_entity_mapper.dart';
import 'package:generic_repository/domain/list_entity.dart';
import 'package:generic_repository/domain/object_entity.dart';
import 'package:generic_repository/domain/value_entity.dart';

class GeneralEntityMapperTest {
  static void testGeneralEntityMapper() {
    group('General Entity Mapper Tests', () {
      test('Testing encode', () {
        expect(
            GeneralEntityMapper.encode(ObjectEntity({
              'id': ValueEntity<num>(1),
              'name': ValueEntity('ok'),
              'items': ListEntity([
                ObjectEntity({
                  'id': ValueEntity<num>(2),
                  'name': ValueEntity('item1'),
                }),
                ObjectEntity({
                  'id': ValueEntity<num>(3),
                  'name': ValueEntity('item2'),
                }),
              ]),
              'obj1': ObjectEntity({
                'id': ValueEntity<num>(3),
                'name': ValueEntity('ok2'),
              })
            })),
            {
              'type': '$ObjectEntity',
              'data': {
                'id': {'type': '${ValueEntity<num>}', 'data': 1},
                'name': {'type': '${ValueEntity<String>}', 'data': 'ok'},
                'items': {
                  'type': '$ListEntity',
                  'data': [
                    {
                      'type': '$ObjectEntity',
                      'data': {
                        'id': {'type': '${ValueEntity<num>}', 'data': 2},
                        'name': {
                          'type': '${ValueEntity<String>}',
                          'data': 'item1'
                        },
                      }
                    },
                    {
                      'type': '$ObjectEntity',
                      'data': {
                        'id': {'type': '${ValueEntity<num>}', 'data': 3},
                        'name': {
                          'type': '${ValueEntity<String>}',
                          'data': 'item2'
                        },
                      }
                    },
                  ]
                },
                'obj1': {
                  'type': '$ObjectEntity',
                  'data': {
                    'id': {'type': '${ValueEntity<num>}', 'data': 3},
                    'name': {'type': '${ValueEntity<String>}', 'data': 'ok2'},
                  }
                },
              }
            });
      });
      test('Testing decode', () {
        expect(
            GeneralEntityMapper.decode({
              'type': '$ObjectEntity',
              'data': {
                'id': {'type': '${ValueEntity<num>}', 'data': 1},
                'name': {'type': '${ValueEntity<String>}', 'data': 'ok'},
                'items': {
                  'type': '$ListEntity',
                  'data': [
                    {
                      'type': '$ObjectEntity',
                      'data': {
                        'id': {'type': '${ValueEntity<num>}', 'data': 2},
                        'name': {
                          'type': '${ValueEntity<String>}',
                          'data': 'item1'
                        },
                      }
                    },
                    {
                      'type': '$ObjectEntity',
                      'data': {
                        'id': {'type': '${ValueEntity<num>}', 'data': 3},
                        'name': {
                          'type': '${ValueEntity<String>}',
                          'data': 'item2'
                        },
                      }
                    },
                  ]
                },
                'obj1': {
                  'type': '$ObjectEntity',
                  'data': {
                    'id': {'type': '${ValueEntity<num>}', 'data': 3},
                    'name': {'type': '${ValueEntity<String>}', 'data': 'ok2'},
                  }
                },
              }
            }),
            ObjectEntity({
              'id': ValueEntity(1),
              'name': ValueEntity('ok'),
              'items': ListEntity([
                ObjectEntity({
                  'id': ValueEntity(2),
                  'name': ValueEntity('item1'),
                }),
                ObjectEntity({
                  'id': ValueEntity(3),
                  'name': ValueEntity('item2'),
                }),
              ]),
              'obj1': ObjectEntity({
                'id': ValueEntity(3),
                'name': ValueEntity('ok2'),
              })
            }));
      });
    });
  }
}
