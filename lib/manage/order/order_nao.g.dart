// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_nao.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderPageDTO _$OrderPageDTOFromJson(Map<String, dynamic> json) => OrderPageDTO(
      (json['content'] as List<dynamic>)
          .map((e) => OrderDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderPageDTOToJson(OrderPageDTO instance) =>
    <String, dynamic>{
      'content': instance.content,
    };

OrderDTO _$OrderDTOFromJson(Map<String, dynamic> json) => OrderDTO(
      json['id'] as num,
      json['no'] as String,
      json['time'] as String,
      json['amount'] as int,
      json['amountPaid'] as int,
      (json['goodsWeight'] as num?)?.toDouble(),
      json['goodsQuantity'] as int?,
      json['incomingChannel'] as String?,
      json['comment'] as String?,
      ContactsDTO.fromJson(json['from'] as Map<String, dynamic>),
      ContactsDTO.fromJson(json['to'] as Map<String, dynamic>),
      (json['delegateOrders'] as List<dynamic>)
          .map((e) => DelegateOrderDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrderDTOToJson(OrderDTO instance) => <String, dynamic>{
      'id': instance.id,
      'no': instance.no,
      'time': instance.time,
      'amount': instance.amount,
      'amountPaid': instance.amountPaid,
      'goodsWeight': instance.goodsWeight,
      'goodsQuantity': instance.goodsQuantity,
      'incomingChannel': instance.incomingChannel,
      'comment': instance.comment,
      'from': instance.from,
      'to': instance.to,
      'delegateOrders': instance.delegateOrders,
    };

ContactsDTO _$ContactsDTOFromJson(Map<String, dynamic> json) => ContactsDTO(
      json['fullName'] as String,
      json['phone'] as String,
      json['address'] as String,
    );

Map<String, dynamic> _$ContactsDTOToJson(ContactsDTO instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'phone': instance.phone,
      'address': instance.address,
    };

DelegateOrderDTO _$DelegateOrderDTOFromJson(Map<String, dynamic> json) =>
    DelegateOrderDTO(
      json['no'] as String,
      json['corporateName'] as String,
      json['amount'] as int,
      json['time'] as String,
    );

Map<String, dynamic> _$DelegateOrderDTOToJson(DelegateOrderDTO instance) =>
    <String, dynamic>{
      'no': instance.no,
      'corporateName': instance.corporateName,
      'amount': instance.amount,
      'time': instance.time,
    };

OrderCreateCommand _$OrderCreateCommandFromJson(Map<String, dynamic> json) =>
    OrderCreateCommand(
      json['orderNo'] as String,
      json['orderTime'] as String,
      (json['goodsWeight'] as num?)?.toDouble(),
      json['goodsQuantity'] as int?,
      json['incomingChannel'] as String?,
      json['comment'] as String?,
      ContactsDTO.fromJson(json['to'] as Map<String, dynamic>),
      OrderDelegatedCommand.fromJson(
          json['orderDelegatedCommand'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderCreateCommandToJson(OrderCreateCommand instance) =>
    <String, dynamic>{
      'orderNo': instance.orderNo,
      'orderTime': instance.orderTime,
      'goodsWeight': instance.goodsWeight,
      'goodsQuantity': instance.goodsQuantity,
      'incomingChannel': instance.incomingChannel,
      'comment': instance.comment,
      'to': instance.to,
      'orderDelegatedCommand': instance.orderDelegatedCommand,
    };

OrderModifyCommand _$OrderModifyCommandFromJson(Map<String, dynamic> json) =>
    OrderModifyCommand(
      json['orderId'] as num,
      json['orderNo'] as String,
      json['orderTime'] as String,
      (json['goodsWeight'] as num?)?.toDouble(),
      json['goodsQuantity'] as int?,
      json['incomingChannel'] as String?,
      json['comment'] as String?,
      json['toAddress'] as String,
      json['delegateOrderNo'] as String,
    );

Map<String, dynamic> _$OrderModifyCommandToJson(OrderModifyCommand instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'orderNo': instance.orderNo,
      'orderTime': instance.orderTime,
      'goodsWeight': instance.goodsWeight,
      'goodsQuantity': instance.goodsQuantity,
      'incomingChannel': instance.incomingChannel,
      'comment': instance.comment,
      'toAddress': instance.toAddress,
      'delegateOrderNo': instance.delegateOrderNo,
    };

OrderDelegatedCommand _$OrderDelegatedCommandFromJson(
        Map<String, dynamic> json) =>
    OrderDelegatedCommand(
      DelegateItem.fromJson(json['delegateItem'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrderDelegatedCommandToJson(
        OrderDelegatedCommand instance) =>
    <String, dynamic>{
      'delegateItem': instance.delegateItem,
    };

DelegateItem _$DelegateItemFromJson(Map<String, dynamic> json) => DelegateItem(
      json['delegateOrderNo'] as String,
    );

Map<String, dynamic> _$DelegateItemToJson(DelegateItem instance) =>
    <String, dynamic>{
      'delegateOrderNo': instance.delegateOrderNo,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _OrderNao implements OrderNao {
  _OrderNao(this._dio, {this.baseUrl});

  final Dio _dio;

  String? baseUrl;

  @override
  Future<OrderDTO> getOrder(orderNo) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<OrderDTO>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/order/${orderNo}/get',
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
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<OrderPageDTO>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/order/page/get',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = OrderPageDTO.fromJson(_result.data!);
    return value;
  }

  @override
  Future<OrderPageDTO> getFirstOrders() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<OrderPageDTO>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/order/page/first/get',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = OrderPageDTO.fromJson(_result.data!);
    return value;
  }

  @override
  Future<OrderDTO> addOrder(command) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(command.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<OrderDTO>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/order/add',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = OrderDTO.fromJson(_result.data!);
    return value;
  }

  @override
  Future<OrderDTO> modifyOrder(command) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(command.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<OrderDTO>(
            Options(method: 'POST', headers: _headers, extra: _extra)
                .compose(_dio.options, '/order/modify',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = OrderDTO.fromJson(_result.data!);
    return value;
  }

  @override
  Future<OrderDTO> delegatedOrder(orderNo, command) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(command.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<OrderDTO>(
            Options(method: 'PATCH', headers: _headers, extra: _extra)
                .compose(_dio.options, '/order/${orderNo}/delegated',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = OrderDTO.fromJson(_result.data!);
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
