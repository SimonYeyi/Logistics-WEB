import 'package:logistics/comm/logistic_dio.dart';
import 'package:retrofit/http.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:dio/dio.dart';
import 'package:logistics/manage/order/order_nao.dart';

part 'track_nao.g.dart';

@RestApi()
abstract class TrackNao {
  factory TrackNao() => _TrackNao(logisticsDio);

  @GET("/track/list/get")
  Future<TracksDTO> getTracks(@Query("orderNo") String orderNo);

  @POST("/track/add")
  Future<TrackDTO> addTrack(@Body() TrackCreateCommand trackCreateCommand);

  @POST("/track/modify")
  Future<TrackDTO> modifyTrack(@Body() TrackModifyCommand trackModifyCommand);
}

@JsonSerializable()
class TracksDTO {
  OrderDTO order;
  List<TrackDTO> tracks;

  TracksDTO(this.order, this.tracks);

  @override
  String toString() {
    return 'TracksDTO{order: $order, tracks: $tracks}';
  }

  factory TracksDTO.fromJson(Map<String, dynamic> json) =>
      _$TracksDTOFromJson(json);
}

@JsonSerializable()
class TrackDTO {
  num id;
  String area;
  String event;
  String time;

  TrackDTO(this.id, this.area, this.event, this.time);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrackDTO && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'TrackDTO{id: $id, area: $area, event: $event, time: $time}';
  }

  factory TrackDTO.fromJson(Map<String, dynamic> json) =>
      _$TrackDTOFromJson(json);
}

@JsonSerializable()
class TrackCreateCommand {
  num orderId;
  String trackArea;
  String trackEvent;

  TrackCreateCommand(this.orderId, this.trackArea, this.trackEvent);

  Map<String, dynamic> toJson() => _$TrackCreateCommandToJson(this);
}

@JsonSerializable()
class TrackModifyCommand {
  num trackId;
  String trackArea;
  String trackEvent;
  String trackTime;

  TrackModifyCommand(
      this.trackId, this.trackArea, this.trackEvent, this.trackTime);

  Map<String, dynamic> toJson() => _$TrackModifyCommandToJson(this);
}
