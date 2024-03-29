// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_nao.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TracksDTO _$TracksDTOFromJson(Map<String, dynamic> json) => TracksDTO(
      OrderDTO.fromJson(json['order'] as Map<String, dynamic>),
      (json['tracks'] as List<dynamic>)
          .map((e) => TrackDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TracksDTOToJson(TracksDTO instance) => <String, dynamic>{
      'order': instance.order,
      'tracks': instance.tracks,
    };

TrackDTO _$TrackDTOFromJson(Map<String, dynamic> json) => TrackDTO(
      json['id'] as num,
      json['area'] as String,
      json['event'] as String,
      json['time'] as String,
    );

Map<String, dynamic> _$TrackDTOToJson(TrackDTO instance) => <String, dynamic>{
      'id': instance.id,
      'area': instance.area,
      'event': instance.event,
      'time': instance.time,
    };

TrackCreateCommand _$TrackCreateCommandFromJson(Map<String, dynamic> json) =>
    TrackCreateCommand(
      json['orderId'] as num,
      json['trackArea'] as String,
      json['trackEvent'] as String,
      json['trackTime'] as String,
    );

Map<String, dynamic> _$TrackCreateCommandToJson(TrackCreateCommand instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'trackArea': instance.trackArea,
      'trackEvent': instance.trackEvent,
      'trackTime': instance.trackTime,
    };

TrackModifyCommand _$TrackModifyCommandFromJson(Map<String, dynamic> json) =>
    TrackModifyCommand(
      json['trackId'] as num,
      json['trackArea'] as String,
      json['trackEvent'] as String,
      json['trackTime'] as String,
    );

Map<String, dynamic> _$TrackModifyCommandToJson(TrackModifyCommand instance) =>
    <String, dynamic>{
      'trackId': instance.trackId,
      'trackArea': instance.trackArea,
      'trackEvent': instance.trackEvent,
      'trackTime': instance.trackTime,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _TrackNao implements TrackNao {
  _TrackNao(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<TracksDTO> getTracks(orderNo) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'orderNo': orderNo};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<TracksDTO>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/track/list/get',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = TracksDTO.fromJson(_result.data!);
    return value;
  }

  @override
  Future<TrackDTO> addTrack(trackCreateCommand) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(trackCreateCommand.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<TrackDTO>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/track/add',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = TrackDTO.fromJson(_result.data!);
    return value;
  }

  @override
  Future<TrackDTO> modifyTrack(trackModifyCommand) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(trackModifyCommand.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<TrackDTO>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/track/modify',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = TrackDTO.fromJson(_result.data!);
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
