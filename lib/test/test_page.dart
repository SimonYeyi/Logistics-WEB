import 'package:flutter/material.dart';
import 'package:logistics/comm/logger.dart';
import 'package:logistics/track/track_nao.dart';

class TestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestPageState();
  }
}

class TestPageState extends State<TestPage> {
  TrackNao trackNao = TrackNao();

  OrdersTracksModel? model;

  @override
  void initState() {
    super.initState();
    trackNao.getOrdersTracksModel(["A", "order no"]).then((value) {
      setState(() {
        this.model = value;
      });
    }).catchError((e) {
      logger.e(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Test"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text(model == null ? "Test Page" : model.toString()),
      ),
    );
  }
}
