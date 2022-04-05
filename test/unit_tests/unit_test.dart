import 'package:flutter_test/flutter_test.dart';
import 'general_entity_mapper_test.dart';
import 'list_entity_mapper_test.dart';
import 'object_entity_mapper_test.dart';
import 'value_entity_mapper_test.dart';

void main() {
  group('Unit Tests', () {
    GeneralEntityMapperTest.testGeneralEntityMapper();
    ObjectEntityMapperTest.testObjectEntityMapper();
    ListEntityMapperTest.testListEntityMapper();
    ValueEntityMapperTest.testValueEntityMapper();
  });
}
