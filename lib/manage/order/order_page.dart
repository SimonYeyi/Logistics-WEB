import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logistics/comm/color.dart';
import 'package:logistics/comm/logger.dart';
import 'package:logistics/manage/order/order_nao.dart';
import 'package:toast/toast.dart';

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
  OrderDTO? searchedOrder;
  int? selectedItem = 0;

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
        Flexible(
          child: SizedBox(
            width: 300,
            height: 32,
            child: TextField(
              onChanged: (text) {},
              controller: textEditingController,
              style: TextStyle(fontSize: 14),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("^[A-Za-z0-9]+\$")),
              ],
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
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                hintText: "输入订单号搜索",
              ),
            ),
          ),
        ),
        SizedBox(width: 6),
        ElevatedButton(
          onPressed: () {
            searchAndShowOrder(textEditingController.text);
          },
          child: Text("搜索"),
        ),
      ],
    );
  }

  void searchAndShowOrder(String orderNo) async {
    if (orderNo == "") return;
    try {
      searchedOrder = await orderNao.searchOrder(orderNo);
      selectedItem = null;
      setState(() {});
    } catch (e) {
      logger.w(e);
      Toast.show("请检查订单号是否正确", context, duration: 3);
    }
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
          searchedOrder == null
              ? SizedBox()
              : Container(
                  color: selectedItem == null
                      ? Colors.grey[200]
                      : Colors.transparent,
                  margin: EdgeInsets.only(bottom: 6),
                  child: GestureDetector(
                    onTap: () {
                      selectedItem = null;
                      setState(() {});
                    },
                    child: orderItemWidget(
                        searchedOrder!.no,
                        searchedOrder!.delegateOrders.isEmpty
                            ? ""
                            : searchedOrder!.delegateOrders[0].no,
                        searchedOrder!.time,
                        searchedOrder!.to.address),
                  ),
                ),
          Flexible(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final order = orders[index];
                return GestureDetector(
                  onTap: () {
                    selectedItem = index;
                    setState(() {});
                  },
                  child: orderItemWidget(
                      order.no,
                      order.delegateOrders.isEmpty
                          ? ""
                          : order.delegateOrders[0].no,
                      order.time,
                      order.to.address,
                      selectedItem == index),
                );
              },
              itemCount: orders.length,
              shrinkWrap: true,
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).dividerColor),
            ),
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                selectedItem = null;
                setState(() {});
              },
            ),
          ),
          SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget orderItemWidget(String orderNo, String delegateOrderNo,
      String orderTime, String destination,
      [bool selected = false]) {
    return Container(
      color: selected ? Colors.grey[200] : Colors.transparent,
      child: Row(
        children: [
          cellWidget(1, orderNo),
          cellWidget(1, delegateOrderNo),
          cellWidget(1, orderTime),
          cellWidget(1, destination),
        ],
      ),
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
