import 'package:dio/dio.dart';
import 'package:logistics/comm/logger.dart';

final Dio logisticsDio = _createDio();

Dio _createDio() {
  final options = _createBaseOptions();
  final dio = Dio(options);
  final loggerInterceptor = _LoggerInterceptor();
  dio.interceptors.add(loggerInterceptor);
  return dio;
}

class _LoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
    logger.d(options.uri);
    logger.d(options.data);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    logger.d(response.realUri);
    logger.d(response.data);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    logger.w(err.response?.realUri);
    logger.w(err.response?.data);
  }
}

BaseOptions _createBaseOptions() {
  return BaseOptions(
    baseUrl: "http://datu.com:5000",
    headers: {
      "Authentication":
          "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJKd3RVdGlscyIsImV4cCI6MTYyMjgxMDg0OCwiaWF0IjoxNjIyNzkyODQ4LCJDTEFJTV9OQU1FIjp7IlRPS0VOX1ZFUlNJT04iOjQsIlVTRVJfSUQiOiIxX0wiLCJVU0VSX05BTUUiOiJzdHJpbmcifX0.DEAd9j8cos_QACuzN0XaXe9RKwj5ySoAOnyb0EseWgE"
    },
  );
}
