import 'package:generic_repository/generic_repository.dart';

/// [DataAccessFailure] represents failure when access is unauthorized
class DataAccessFailure extends Failure {
  @override
  final String message;
  DataAccessFailure({this.message = ''});
}
