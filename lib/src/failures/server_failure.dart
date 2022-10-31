import 'package:generic_repository/generic_repository.dart';

/// [ServerFailure] represents the failure when Server failed to return expected result
class ServerFailure extends Failure {
  @override
  final String message;

  ServerFailure({this.message = ''});
}
