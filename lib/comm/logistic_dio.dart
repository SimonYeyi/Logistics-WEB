import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logistics/comm/account_dao.dart';
import 'package:logistics/comm/logger.dart';
import 'package:logistics/manage/account/account_nao.dart';

final Dio logisticsDio = _createDio();

Dio _createDio() {
  final options = _createBaseOptions();
  final dio = Dio(options);
  dio.interceptors
    ..add(_LoggerInterceptor())
    ..add(_AuthenticationInterceptor());
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

class _AuthenticationInterceptor extends Interceptor {
  final AccountDao accountDao = AccountDao();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final accountDTO = await accountDao.find();
    if (accountDTO != null) {
      options.headers["Authentication"] = accountDTO.token;
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == HttpStatus.unauthorized) {
      final accountDTO = await accountDao.find();
      if (accountDTO != null) {
        final newAccountDTO =
            await AccountNao().refreshToken(accountDTO.refreshToken);
        accountDao.save(newAccountDTO);
        final options = err.requestOptions;
        options.headers["Authentication"] = newAccountDTO.token;
        final response = await logisticsDio.fetch(options);
        handler.resolve(response);
      } else {
        handler.next(err);
        onUnauthorized();
      }
    } else {
      handler.next(err);
      if (err.response?.realUri.toString().contains("refreshToken") ?? false) {
        onUnauthorized();
      }
    }
  }
}

Function onUnauthorized = () {};

BaseOptions _createBaseOptions() {
  return BaseOptions(
    baseUrl: kDebugMode ? "http://localhost:5000" : "http://eus56.com:5000",
  );
}
