library generic_repository;

import 'package:generic_repository/generated/objectbox.g.dart';

/// Repository ops paths
export 'package:generic_repository/src/interfaces/repository/operations/add.dart';
export 'package:generic_repository/src/interfaces/repository/operations/get.dart';
export 'package:generic_repository/src/interfaces/repository/operations/update.dart';
export 'package:generic_repository/src/interfaces/repository/operations/delete.dart';

/// Repository paths
export 'package:generic_repository/src/interfaces/repository/base_repository.dart';
export 'package:generic_repository/src/interfaces/repository/read_repository.dart';

/// Spec path
export 'package:generic_repository/src/interfaces/spec/spec.dart';

/// Implementation paths

void main() {
  /// note.id.greaterThan(5).or(note.id.equals(5))
  /// Note_.id.greaterThan(5).or(Note_.id.equals(5));
}