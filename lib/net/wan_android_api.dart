import 'package:cookie_jar/cookie_jar.dart';
import 'package:demo/config/storage_manager.dart';
import 'package:demo/provider/exception.dart';
import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

final WanAndroidApi api = WanAndroidApi();

class WanAndroidApi extends DioForNative {
  WanAndroidApi() {
    options.baseUrl = "https://www.wanandroid.com/";
    options.receiveTimeout = 8000;
    options.connectTimeout = 8000;
    interceptors
      ..add(ApiInterceptor())
      ..add(CookieManager(
          PersistCookieJar(dir: StorageManager.temporaryDirectory.path)));
  }
}

class ApiInterceptor extends InterceptorsWrapper {
  @override
  onResponse(Response response) {
    ResponseData data = ResponseData.fromJson(response.data);
    if (data.isSuccess) {
      response.data = data.data;
      print(data.data);
      return api.resolve(response);
    } else {
      if (data.code == -1001) {
        throw UnAuthException();
      } else {
        throw FailedException.fromResponseData(data);
      }
    }
  }
}

class ResponseData {
  int code = 0;
  String message;
  dynamic data;

  bool get isSuccess => code == 0;

  ResponseData.fromJson(Map<String, dynamic> json) {
    code = json["errorCode"];
    message = json["errorMsg"];
    data = json["data"];
  }
}
