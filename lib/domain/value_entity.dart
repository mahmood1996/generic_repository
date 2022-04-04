import 'package:generic_repository/domain/entity.dart';

class ValueEntity<ValueType> extends Entity {
  final ValueType data;
  ValueEntity(this.data);

  @override
  int get hashCode => data.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is! ValueEntity<ValueType>) return false;
    return other.data == data;
  }
}