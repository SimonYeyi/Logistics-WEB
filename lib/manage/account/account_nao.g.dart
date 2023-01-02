// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_nao.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountDTO _$AccountDTOFromJson(Map<String, dynamic> json) => AccountDTO(
      json['accountId'] as num,
      json['accountName'] as String,
      json['token'] as String,
      json['refreshToken'] as String,
    );

Map<String, dynamic> _$AccountDTOToJson(AccountDTO instance) =>
    <String, dynamic>{
      'accountId': instance.accountId,
      'accountName': instance.accountName,
      'token': instance.token,
      'refreshToken': instance.refreshToken,
    };

AccountLoginCommand _$AccountLoginCommandFromJson(Map<String, dynamic> json) =>
    AccountLoginCommand(
      json['accountName'] as String,
      json['password'] as String,
    );

Map<String, dynamic> _$AccountLoginCommandToJson(
        AccountLoginCommand instance) =>
    <String, dynamic>{
      'accountName': instance.accountName,
      'password': instance.password,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _AccountNao implements AccountNao {
  _AccountNao(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<AccountDTO> login(accountLoginCommand) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(accountLoginCommand.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AccountDTO>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/account/login',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AccountDTO.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AccountDTO> refreshToken(refreshToken) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'refreshToken': refreshToken};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AccountDTO>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/account/token/refresh',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AccountDTO.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
