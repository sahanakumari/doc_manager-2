import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:doc_manager/core/services/network_connectivity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockConnectivity extends Mock implements Connectivity{}

void main() {
  NetworkConnectivityImpl? networkInfoImpl;
  MockConnectivity? mockConnectivity;

  setUp(() {
    mockConnectivity = MockConnectivity();
    networkInfoImpl = NetworkConnectivityImpl(mockConnectivity!);
  });

  test(
    'should forward the call to Connectivity.checkConnectivity()',
        () async {
      // arrange
      final tHasConnectionFuture = Future.value(true);
      when(mockConnectivity!.checkConnectivity()).thenAnswer((_) => Future.value(ConnectivityResult.mobile));
      // act
      final result = networkInfoImpl!.isConnected;
      // assert
      verify(mockConnectivity!.checkConnectivity());
      //expect(result, tHasConnectionFuture);
    },
  );

  test(
    'should forward the call to Connectivity.checkConnectivity()',
        () async {
      // arrange
      final tHasConnectionFuture = Future.value(true);
      when(mockConnectivity!.checkConnectivity()).thenAnswer((_) => Future.value(ConnectivityResult.wifi));
      // act
      final result = networkInfoImpl!.isConnected;
      // assert
      verify(mockConnectivity!.checkConnectivity());
      //expect(result, tHasConnectionFuture);
    },
  );


}
