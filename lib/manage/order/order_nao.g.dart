// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_nao.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderPageDTO _$OrderPageDTOFromJson(Map<String, dynamic> json) {
  return OrderPageDTO(
    (json['content'] as List<dynamic>)
        .map((e) => OrderDTO.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$OrderPageDTOToJson(OrderPageDTO instance) =>
    <String, dynamic>{
      'content': instance.content,
    };

OrderDTO _$OrderDTOFromJson(Map<String, dynamic> json) {
  return OrderDTO(
    json['id'] as num,
    json['no'] as String,
    DateTime.parse(json['time'] as String),
    json['amount'] as int,
    json['amountPaid'] as int,
    ContactsDTO.fromJson(json['from'] as Map<String, dynamic>),
    ContactsDTO.fromJson(json['to'] as Map<String, dynamic>),
    (json['delegateOrders'] as List<dynamic>)
        .map((e) => DelegateOrderDTO.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$OrderDTOToJson(OrderDTO instance) => <String, dynamic>{
      'id': instance.id,
      'no': instance.no,
      'time': instance.time.toIso8601String(),
      'amount': instance.amount,
      'amountPaid': instance.amountPaid,
      'from': instance.from,
      'to': instance.to,
      'delegateOrders': instance.delegateOrders,
    };

ContactsDTO _$ContactsDTOFromJson(Map<String, dynamic> json) {
  return ContactsDTO(
    json['fullName'] as String,
    json['phone'] as String,
    json['address'] as String,
  );
}

Map<String, dynamic> _$ContactsDTOToJson(ContactsDTO instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'phone': instance.phone,
      'address': instance.address,
    };

DelegateOrderDTO _$DelegateOrderDTOFromJson(Map<String, dynamic> json) {
  return DelegateOrderDTO(
    json['no'] as String,
    json['corporateName'] as String,
    json['amount'] as int,
    json['time'] as String,
  );
}

Map<String, dynamic> _$DelegateOrderDTOToJson(DelegateOrderDTO instance) =>
    <String, dynamic>{
      'no': instance.no,
      'corporateName': instance.corporateName,
      'amount': instance.amount,
      'time': instance.time,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _OrderNao implements OrderNao {
  _OrderNao(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<OrderDTO> searchOrder(orderNo) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<OrderDTO>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/order/$orderNo/search',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = OrderDTO.fromJson(_result.data!);
    return value;
  }

  @override
  Future<OrderPageDTO> getOrders(page, pageSize) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'pageSize': pageSize
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<OrderPageDTO>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/order/page/get',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = OrderPageDTO.fromJson(_result.data!);
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
