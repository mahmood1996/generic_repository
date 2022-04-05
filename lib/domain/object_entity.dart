import 'package:generic_repository/domain/entity.dart';

class ObjectEntity extends Entity {
  final Map<String, Entity> _data;

  ObjectEntity(Map<String, Entity> data)
      : _data = Map<String, Entity>.from(data);

  Entity? getEntity(String key) => _data[key];

  Iterable<Entity> get allEntities => _data.values;

  Iterable<String> get keysOfEntities => _data.keys;

  @override
  int get hashCode => _data.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ObjectEntity) return false;
    if (_data.length != other._data.length) return false;
    return !allEntities.any((element) => !other.allEntities.contains(element));
  }
}
