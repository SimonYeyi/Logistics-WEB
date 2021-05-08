import 'package:logistics/comm/logistic_dio.dart';
import 'package:retrofit/http.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:dio/dio.dart';

part 'order_nao.g.dart';

@RestApi()
abstract class OrderNao {
  factory OrderNao() => _OrderNao(logisticsDio);

  @GET("/order/{orderNo}/search")
  Future<OrderDTO> searchOrder(@Path("orderNo") String orderNo);

  @GET("/order/page/get")
  Future<OrderPageDTO> getOrders(
      @Query("page") int page, @Query("pageSize") int pageSize);
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
  num id;
  String no;
  DateTime time;
  int amount;
  int amountPaid;
  ContactsDTO from;
  ContactsDTO to;
  List<DelegateOrderDTO> delegateOrders;

  OrderDTO(this.id, this.no, this.time, this.amount, this.amountPaid, this.from,
      this.to, this.delegateOrders);

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
