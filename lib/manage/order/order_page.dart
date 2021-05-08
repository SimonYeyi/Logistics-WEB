import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logistics/comm/color.dart';
import 'package:logistics/comm/logger.dart';
import 'package:logistics/manage/order/order_nao.dart';

class OrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OrderPageState();
  }
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _OrderListPage()),
        Container(width: 1, color: Theme.of(context).dividerColor),
        Expanded(child: _OrderDetailsPage()),
      ],
    );
  }
}

class _OrderListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OrderListPageState();
  }
}

class _OrderListPageState extends State<_OrderListPage> {
  final TextEditingController textEditingController = TextEditingController();
  final OrderNao orderNao = OrderNao();
  List<OrderDTO> orders = [];

  @override
  void initState() {
    super.initState();
    getAndShowOrders();
  }

  void getAndShowOrders() async {
    try {
      final page = await orderNao.getOrders(1, 10);
      logger.d(page);
      orders = page.content;
      setState(() {});
    } catch (e) {
      logger.w(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 32),
          inputWidget(),
          SizedBox(height: 32),
          orderListView(),
        ],
      ),
    );
  }

  Widget inputWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(child: SizedBox(
          width: 300,
          height: 32,
          child: TextField(
            onChanged: (text) {},
            controller: textEditingController,
            style: TextStyle(fontSize: 14),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              hintText: "输入订单号搜索",
            ),
          ),
        ),),
        SizedBox(width: 6),
        ElevatedButton(
          onPressed: () {},
          child: Text("搜索"),
        ),
      ],
    );
  }

  Widget orderListView() {
    return Flexible(
      child: Column(
        children: [
          Container(
            color: hexColor("#d8f6ff"),
            child: orderItemWidget("运单号", "转单号", "下单时间", "目的地"),
          ),
          SizedBox(height: 6),
          Flexible(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final order = orders[index];
                return orderItemWidget(
                    order.no,
                    order.delegateOrders.isEmpty
                        ? ""
                        : order.delegateOrders[0].no,
                    order.time,
                    order.to.address);
              },
              itemCount: orders.length,
              shrinkWrap: true,
            ),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 30,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).dividerColor),
              ),
              child: Icon(Icons.add),
            ),
          ),
          SizedBox(height: 32),
        ],
      ),
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
}

class _OrderDetailsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OrderDetailsPageState();
  }
}

class _OrderDetailsPageState extends State<_OrderDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
