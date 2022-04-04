import 'package:generic_repository/domain/entity.dart';

class ListEntity extends Entity {
  final List<Entity> _data;

  ListEntity(List<Entity> data) : _data = List.unmodifiable(data);

  Iterable<Entity> get allEntities => _data;

  @override
  int get hashCode => _data.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is! ListEntity) return false;
    if (_data.length != other._data.length) return false;
    return !other.allEntities.any((element) => !allEntities.contains(element));
  }
}
