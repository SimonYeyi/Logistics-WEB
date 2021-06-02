import 'package:dio/dio.dart';

Dio logisticsDio = Dio(options);

BaseOptions options =
    BaseOptions(baseUrl: "http://api.datu.com:5000", headers: {
  "Authentication":
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJKd3RVdGlscyIsImV4cCI6MTYyMjYzOTczMiwiaWF0IjoxNjIyNjIxNzMyLCJDTEFJTV9OQU1FIjp7IlRPS0VOX1ZFUlNJT04iOjMsIlVTRVJfSUQiOiIxX0wiLCJVU0VSX05BTUUiOiJzdHJpbmcifX0.AsRJLg0ShZJ7gv-dezxuj1T4xX_yOPYR6RYkACHxZe0"
});
