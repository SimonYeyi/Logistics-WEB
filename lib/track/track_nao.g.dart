// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_nao.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrdersTracksModel _$OrdersTracksModelFromJson(Map<String, dynamic> json) =>
    OrdersTracksModel(
      (json['orders'] as List<dynamic>)
          .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['tracks'] as List<dynamic>)
          .map((e) => TracksModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrdersTracksModelToJson(OrdersTracksModel instance) =>
    <String, dynamic>{
      'orders': instance.orders,
      'tracks': instance.tracks,
    };

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
      json['orderNo'] as String,
      json['delegateOrderNo'] as String?,
      json['orderTime'] as String,
      json['destination'] as String,
    );

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'orderNo': instance.orderNo,
      'delegateOrderNo': instance.delegateOrderNo,
      'orderTime': instance.orderTime,
      'destination': instance.destination,
    };

TracksModel _$TracksModelFromJson(Map<String, dynamic> json) => TracksModel(
      json['orderNo'] as String,
      (json['tracks'] as List<dynamic>)
          .map((e) => TrackModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TracksModelToJson(TracksModel instance) =>
    <String, dynamic>{
      'orderNo': instance.orderNo,
      'tracks': instance.tracks,
    };

TrackModel _$TrackModelFromJson(Map<String, dynamic> json) => TrackModel(
      json['trackTime'] as String,
      json['trackArea'] as String,
      json['trackEvent'] as String,
    );

Map<String, dynamic> _$TrackModelToJson(TrackModel instance) =>
    <String, dynamic>{
      'trackTime': instance.trackTime,
      'trackArea': instance.trackArea,
      'trackEvent': instance.trackEvent,
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
  Future<OrdersTracksModel> searchOrdersTracksModel(orderNos) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'orderNos': orderNos};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<OrdersTracksModel>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/track/view-model/orders-tracks/search',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = OrdersTracksModel.fromJson(_result.data!);
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
