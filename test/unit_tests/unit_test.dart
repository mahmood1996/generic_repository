import 'package:flutter_test/flutter_test.dart';
import 'list_entity_mapper_test.dart';
import 'object_entity_mapper_test.dart';

void main() {
  group('Unit Tests', () {
    ObjectEntityMapperTest.testObjectEntityMapper();
    ListEntityMapperTest.testListEntityMapper();
  });
}