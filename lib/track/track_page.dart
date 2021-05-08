import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logistics/comm/color.dart';
import 'package:logistics/comm/logger.dart';
import 'package:logistics/track/track_nao.dart';
import 'package:toast/toast.dart';

class TrackPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TrackPageState();
  }
}

class _TrackPageState extends State<TrackPage> {
  TrackNao trackNao = TrackNao();
  late TextEditingController textEditingController;

  OrdersTracksModel? model;

  int orderItemCount = 0;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Row(
          children: [
            inputWidget(),
            resultWidget(),
          ],
        ),
      ),
    );
  }

  Widget inputWidget() {
    return Container(
      width: 200,
      child: Column(
        children: [
          Container(
            height: 50,
            color: hexColor("#74a6d0"),
            alignment: Alignment.center,
            child: Text(
              "运单轨迹查询",
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: hexColor("#689ac3"),
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 18),
              child: Column(
                children: [
                  Text(
                    "请输入运单号（查询多个时用回车键分隔）",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: textEditingController,
                    maxLines: 10,
                    style: TextStyle(fontSize: 12, color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(2)),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                    ),
                  ),
                  SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                        onPressed: () {
                          getAndShowOrdersTracksModel();
                        },
                        child: Text("查询")),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget resultWidget() {
    return Flexible(
      child: Container(
        child: Column(
          children: [
            ordersWidget(),
            SizedBox(height: 30),
            tracksWidget(),
          ],
        ),
      ),
    );
  }

  Widget ordersWidget() {
    final orderNos = orderNosInTextField();
    return Column(
      children: [
        Container(
          color: hexColor("#d8f6ff"),
          child: orderItemWidget("运单号", "转单号", "下单时间", "目的地"),
        ),
        Container(
          height: 130,
          child: ListView.builder(
            itemBuilder: (context, index) {
              final order = model?.orders[index];
              final orderNo = orderNos[index];
              return order == null
                  ? orderItemWidget(orderNo, "", "", "")
                  : orderItemWidget(order.orderNo, order.delegateOrderNo ?? "",
                      order.orderTime, order.destination);
            },
            itemCount: orderItemCount,
          ),
        ),
      ],
    );
  }

  Widget orderItemWidget(String orderNo, String delegateOrderNo,
      String orderTime, String destination) {
    return Row(
      children: [
        cellWidget(1, orderNo),
        cellWidget(1, delegateOrderNo),
        cellWidget(1, orderTime),
        cellWidget(1, destination),
      ],
    );
  }

  Widget cellWidget(int flex, String text) {
    return Expanded(
      flex: flex,
      child: Container(
        height: 32,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 0),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
  }

  Widget tracksWidget() {
    final orderNos = orderNosInTextField();
    final itemCount = orderNos[0] == "" ? 0 : orderNos.length;
    return Flexible(
      child: ListView.separated(
        itemBuilder: (context, index) {
          final orderNo = orderNos[index];
          final tracks = model?.tracks[index].tracks ?? const <TrackModel>[];
          return tracksItemWidget(orderNo, tracks);
        },
        separatorBuilder: (context, index) => SizedBox(height: 20),
        itemCount: itemCount,
      ),
    );
  }

  Widget tracksItemWidget(String orderNo, List<TrackModel> tracks) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "【$orderNo】详细信息",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            color: hexColor("#d8f6ff"),
            child: trackItemWidget("时间", "区域", "详情"),
          ),
          ListView.builder(
            itemBuilder: (context, index) {
              final model = tracks[index];
              return trackItemWidget(
                  model.trackTime, model.trackArea, model.trackEvent);
            },
            itemCount: tracks.length,
            shrinkWrap: true,
          ),
        ],
      ),
    );
  }

  Widget trackItemWidget(
      String trackTime, String trackArea, String trackEvent) {
    return Row(
      children: [
        cellWidget(1, trackTime),
        cellWidget(1, trackArea),
        cellWidget(4, trackEvent),
      ],
    );
  }

  void getAndShowOrdersTracksModel() {
    if (textEditingController.text.isEmpty) return;
    final orderNos = orderNosInTextField();
    orderItemCount = orderNos.length;
    trackNao.getOrdersTracksModel(orderNos).then((value) {
      model = value;
      logger.d(value);
    }).catchError((e) {
      model = null;
      logger.w(e);
      Toast.show("可能存在错误的订单号\n请检查输入框中的订单号是否正确", context, duration: 5);
    }).whenComplete(() => setState(() {}));
  }

  List<String> orderNosInTextField() => textEditingController.text.split("\n");
}
