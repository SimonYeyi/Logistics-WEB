import 'package:dio/dio.dart';
import 'package:logistics/comm/logistic_dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

part 'track_nao.g.dart';

@RestApi()
abstract class TrackNao {
  factory TrackNao() => _TrackNao(logisticsDio);

  @GET("/track/view-model/orders-tracks")
  Future<OrdersTracksModel> getOrdersTracksModel(
      @Query("orderNos") List<String> orderNos);
}

@JsonSerializable()
class OrdersTracksModel {
  List<OrderModel> orders;
  List<TracksModel> tracks;

  OrdersTracksModel(this.orders, this.tracks);

  @override
  String toString() {
    return 'OrdersTracksModel{orders: $orders, tracks: $tracks}';
  }

  factory OrdersTracksModel.fromJson(Map<String, dynamic> map) =>
      _$OrdersTracksModelFromJson(map);
}

@JsonSerializable()
class OrderModel {
  String orderNo;
  String? delegateOrderNo;
  String orderTime;
  String destination;

  OrderModel(
      this.orderNo, this.delegateOrderNo, this.orderTime, this.destination);

  @override
  String toString() {
    return 'OrderModel{orderNo: $orderNo, delegateOrderNo: $delegateOrderNo, orderTime: $orderTime, destination: $destination}';
  }

  factory OrderModel.fromJson(Map<String, dynamic> e) =>
      _$OrderModelFromJson(e);
}

@JsonSerializable()
class TracksModel {
  String orderNo;
  List<TrackModel> tracks;

  TracksModel(this.orderNo, this.tracks);

  @override
  String toString() {
    return 'TracksModel{orderNo: $orderNo, tracks: $tracks}';
  }

  factory TracksModel.fromJson(Map<String, dynamic> e) =>
      _$TracksModelFromJson(e);
}

@JsonSerializable()
class TrackModel {
  String trackTime;
  String trackArea;
  String trackEvent;

  TrackModel(this.trackTime, this.trackArea, this.trackEvent);

  @override
  String toString() {
    return 'TrackModel{trackTime: $trackTime, trackArea: $trackArea, trackEvent: $trackEvent}';
  }

  factory TrackModel.fromJson(Map<String, dynamic> e) =>
      _$TrackModelFromJson(e);
}
