import 'package:demo/net/wan_android_api.dart';

class UnAuthException implements Exception {
  @override
  String toString() {
    return 'UnAuthException';
  }
}

class FailedException implements Exception {
  String msg;

  FailedException.fromResponseData(ResponseData data) {
    msg = data.message;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "{errorData:$msg}";
  }
}
