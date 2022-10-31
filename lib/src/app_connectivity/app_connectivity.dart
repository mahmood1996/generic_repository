/// Abstraction for app connectivity status
abstract class AppConnectivity {
  Future<bool>? get isOnline;
}
