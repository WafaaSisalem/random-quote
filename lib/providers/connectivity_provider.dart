import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:io';

// This line is important. It's used to generate the code.
part 'connectivity_provider.g.dart';

@riverpod
class ConnectivityNotifier extends _$ConnectivityNotifier {
  @override
  bool build() {
    // Initial state
    checkInternetConnection();
    return false;
  }

  Future<void> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        state = true;
      }
    } on SocketException catch (_) {
      state = false;
    }
  }
}
