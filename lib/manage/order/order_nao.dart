import 'package:logistics/comm/logistic_dio.dart';
import 'package:retrofit/http.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:dio/dio.dart';

part 'order_nao.g.dart';

@RestApi()
abstract class OrderNao {
  factory OrderNao() => _OrderNao(logisticsDio);

  @GET("/order/{orderNo}/get")
  Future<OrderDTO> getOrder(@Path("orderNo") String orderNo);

  @GET("/order/page/get")
  Future<OrderPageDTO> getOrders(
      @Query("page") int page, @Query("pageSize") int pageSize);

  @GET("/order/page/first/get")
  Future<OrderPageDTO> getFirstOrders();

  @POST("/order/add")
  Future<OrderDTO> addOrder(@Body() OrderCreateCommand command);

  @POST("/order/modify")
  Future<OrderDTO> modifyOrder(@Body() OrderModifyCommand command);

  @PATCH("/order/{orderNo}/delegated")
  Future<OrderDTO> delegatedOrder(
      @Path("orderNo") String orderNo, @Body() OrderDelegatedCommand command);
}

@JsonSerializable()
class OrderPageDTO {
  List<OrderDTO> content;

  OrderPageDTO(this.content);

  @override
  String toString() {
    return 'OrderPageDTO{content: $content}';
  }

  factory OrderPageDTO.fromJson(Map<String, dynamic> json) =>
      _$OrderPageDTOFromJson(json);
}

@JsonSerializable()
class OrderDTO {
  final num id;
  final String no;
  final String time;
  final int amount;
  final int amountPaid;
  final double? goodsWeight;
  final int? goodsQuantity;
  final String? incomingChannel;
  final String? comment;
  final ContactsDTO from;
  final ContactsDTO to;
  final List<DelegateOrderDTO> delegateOrders;

  OrderDTO(
      this.id,
      this.no,
      this.time,
      this.amount,
      this.amountPaid,
      this.goodsWeight,
      this.goodsQuantity,
      this.incomingChannel,
      this.comment,
      this.from,
      this.to,
      this.delegateOrders);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderDTO && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'OrderDTO{id: $id, no: $no, time: $time, amount: $amount, amountPaid: $amountPaid, from: $from, to: $to, delegateOrders: $delegateOrders}';
  }

  factory OrderDTO.fromJson(Map<String, dynamic> json) =>
      _$OrderDTOFromJson(json);
}

@JsonSerializable()
class ContactsDTO {
  String fullName;
  String phone;
  String address;

  ContactsDTO(this.fullName, this.phone, this.address);

  @override
  String toString() {
    return 'ContactsDTO{fullName: $fullName, phone: $phone, address: $address}';
  }

  factory ContactsDTO.fromJson(Map<String, dynamic> json) =>
      _$ContactsDTOFromJson(json);

  Map<String, dynamic> toJson() => _$ContactsDTOToJson(this);
}

@JsonSerializable()
class DelegateOrderDTO {
  String no;
  String corporateName;
  int amount;
  String time;

  DelegateOrderDTO(this.no, this.corporateName, this.amount, this.time);

  @override
  String toString() {
    return 'DelegateOrderDTO{no: $no, corporateName: $corporateName, amount: $amount, time: $time}';
  }

  factory DelegateOrderDTO.fromJson(Map<String, dynamic> json) =>
      _$DelegateOrderDTOFromJson(json);
}

@JsonSerializable()
class OrderCreateCommand {
  String orderNo;
  String orderTime;
  double? goodsWeight;
  int? goodsQuantity;
  String? incomingChannel;
  String? comment;
  ContactsDTO to;
  OrderDelegatedCommand orderDelegatedCommand;

  OrderCreateCommand(this.orderNo, this.orderTime, this.goodsWeight,
      this.goodsQuantity, this.incomingChannel, this.comment, this.to,this.orderDelegatedCommand);

  Map<String, dynamic> toJson() => _$OrderCreateCommandToJson(this);
}

@JsonSerializable()
class OrderModifyCommand {
  num orderId;
  String orderNo;
  String orderTime;
  double? goodsWeight;
  int? goodsQuantity;
  String? incomingChannel;
  String? comment;
  String toAddress;
  String delegateOrderNo;

  OrderModifyCommand(
      this.orderId,
      this.orderNo,
      this.orderTime,
      this.goodsWeight,
      this.goodsQuantity,
      this.incomingChannel,
      this.comment,
      this.toAddress,
      this.delegateOrderNo);

  Map<String, dynamic> toJson() => _$OrderModifyCommandToJson(this);
}

@JsonSerializable()
class OrderDelegatedCommand {
  DelegateItem delegateItem;

  OrderDelegatedCommand(this.delegateItem);

  @override
  String toString() {
    return 'OrderDelegatedCommand{delegateItem: $delegateItem}';
  }

  factory OrderDelegatedCommand.fromJson(Map<String, dynamic> json) =>
      _$OrderDelegatedCommandFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDelegatedCommandToJson(this);
}

@JsonSerializable()
class DelegateItem {
  String delegateOrderNo;

  DelegateItem(this.delegateOrderNo);

  @override
  String toString() {
    return 'DelegateItem{delegateOrderNo: $delegateOrderNo}';
  }

  factory DelegateItem.fromJson(Map<String, dynamic> json) =>
      _$DelegateItemFromJson(json);

  Map<String, dynamic> toJson() => _$DelegateItemToJson(this);
}
