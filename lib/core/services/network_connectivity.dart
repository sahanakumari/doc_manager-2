import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkConnectivity {
  Future<bool> get isConnected;
}

class NetworkConnectivityImpl implements NetworkConnectivity {
  final Connectivity connectivity;

  NetworkConnectivityImpl(this.connectivity);

  @override
  Future<bool> get isConnected async {
    final connectionResult = await connectivity.checkConnectivity();
    if (connectionResult == ConnectivityResult.mobile ||
        connectionResult == ConnectivityResult.wifi) {
      return Future.value(true);
    }
    return Future.value(false);
  }
}
