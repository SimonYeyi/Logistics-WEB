import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:logistics/comm/color.dart';
import 'package:logistics/comm/logger.dart';
import 'package:logistics/manage/order/order_nao.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class OrderModelsNotifier with ChangeNotifier {
  OrderDTO? _selectedOrder;
  OrderDTO? _savedOrder;

  set selectedOrder(OrderDTO? order) {
    _selectedOrder = order;
    notifyListeners();
  }

  OrderDTO? get selectedOrder => _selectedOrder;

  set savedOrder(OrderDTO? order) {
    _savedOrder = order;
    notifyListeners();
  }

  OrderDTO? get savedOrder => _savedOrder;
}

class OrderPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OrderPageState();
  }
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OrderModelsNotifier(),
      child: Row(
        children: [
          Expanded(child: _OrderListPage()),
          Container(width: 1, color: Theme.of(context).dividerColor),
          Expanded(child: _OrderDetailsPage()),
        ],
      ),
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
  int? selectedItem;

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
      if (orders.isNotEmpty) {
        selectedItem = 0;
        context.read<OrderModelsNotifier>().selectedOrder = orders[0];
      }
      setState(() {});
    } on DioError catch (e) {
      Toast.show(e.response?.data?.toString() ?? "", context, duration: 5);
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
      searchedOrder = await orderNao.getOrder(orderNo);
      selectedItem = -1;
      context.read<OrderModelsNotifier>().selectedOrder = searchedOrder!;
      setState(() {});
    } catch (e) {
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
                  color: selectedItem == -1
                      ? Colors.grey[200]
                      : Colors.transparent,
                  margin: EdgeInsets.only(bottom: 6),
                  child: GestureDetector(
                    onTap: () {
                      selectedItem = -1;
                      setState(() {});
                      context.read<OrderModelsNotifier>().selectedOrder =
                          searchedOrder!;
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
          Consumer<OrderModelsNotifier>(builder: (context, value, child) {
            final savedOrder = value.savedOrder;
            if (savedOrder != null) {
              if (orders.contains(savedOrder)) {
                final index = orders.indexOf(savedOrder);
                orders.removeAt(index);
                orders.insert(index, savedOrder);
              } else {
                orders = []
                  ..add(savedOrder)
                  ..addAll(orders);
                selectedItem = 0;
              }
              value._savedOrder = null;
            }
            return Flexible(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return GestureDetector(
                    onTap: () {
                      selectedItem = index;
                      setState(() {});
                      context.read<OrderModelsNotifier>().selectedOrder = order;
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
            );
          }),
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
                context.read<OrderModelsNotifier>().selectedOrder = null;
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
        child: SelectableText(
          text,
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}

class _OrderDetailsPage extends StatefulWidget {
  OrderDTO? order;

  @override
  State<StatefulWidget> createState() {
    return _OrderDetailsPageState();
  }
}

class _OrderDetailsPageState extends State<_OrderDetailsPage> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final OrderNao orderNao = OrderNao();
  late String orderNo;
  late String orderTime;
  late String orderToAddress;
  late String delegateOrderNo;
  final TextEditingController orderNoTextEditingController =
      TextEditingController();
  final TextEditingController orderTimeTextEditingController =
      TextEditingController();
  final TextEditingController orderToAddressTextEditingController =
      TextEditingController();
  final TextEditingController delegateOrderNoTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    widget.order = context.watch<OrderModelsNotifier>().selectedOrder;
    final order = widget.order;
    final delegateOrders = order?.delegateOrders ?? const [];
    orderNo = order?.no ?? "";
    orderTime = order?.time ?? "";
    orderToAddress = order?.to.address ?? "";
    delegateOrderNo = delegateOrders.isNotEmpty ? delegateOrders[0].no : "";

    logger.d(
        "orderNo:$orderNo, orderTime:$orderTime, orderToAddress:$orderToAddress, delegateOrderNo:$delegateOrderNo");
    orderNoTextEditingController.text = orderNo;
    orderTimeTextEditingController.text = orderTime;
    orderToAddressTextEditingController.text = orderToAddress;
    delegateOrderNoTextEditingController.text = delegateOrderNo;

    return Form(
      key: formKey,
      child: Column(
        children: [
          SizedBox(height: 32),
          orderNoRow(),
          orderTimeRow(),
          toAddressRow(),
          delegateOrderNoRow(),
          SizedBox(height: 20),
          ElevatedButton(onPressed: save, child: Text("保存"))
        ],
      ),
    );
  }

  void save() async {
    formKey.currentState?.save();
    if (orderNo == "" ||
        orderTime == "" ||
        orderToAddress == "" ||
        delegateOrderNo == "") {
      return;
    }
    try {
      OrderDTO order;
      final notifier = context.read<OrderModelsNotifier>();
      final selectedOrder = notifier.selectedOrder;
      if (selectedOrder == null) {
        OrderCreateCommand orderCreateCommand = OrderCreateCommand(
            orderNo, orderTime, ContactsDTO("", "", orderToAddress));
        await orderNao.addOrder(orderCreateCommand);
        order = await orderNao.delegatedOrder(
            orderNo, OrderDelegatedCommand(DelegateItem(delegateOrderNo)));
      } else {
        OrderModifyCommand orderModifyCommand = OrderModifyCommand(
            selectedOrder.id,
            orderNo,
            orderTime,
            orderToAddress,
            delegateOrderNo);
        order = await orderNao.modifyOrder(orderModifyCommand);
      }
      logger.d(order);
      notifier.savedOrder = order;
      notifier.selectedOrder = order;
      FocusScope.of(context).requestFocus(new FocusNode());
      Toast.show("保存成功", context);
      setState(() {});
    } catch (e) {
      Toast.show("请检查订单号是否已经存在", context, duration: 5);
    }
  }

  Widget orderNoRow() {
    return Flexible(
      child: SizedBox(
        width: 200,
        child: TextFormField(
          onSaved: (value) => orderNo = value!,
          controller: orderNoTextEditingController,
          decoration: InputDecoration(
            labelText: "订单号: ",
            labelStyle: TextStyle(fontSize: 14, height: 0.8),
          ),
        ),
      ),
    );
  }

  Widget orderTimeRow() {
    return Flexible(
      child: GestureDetector(
        onTap: () {
          DatePicker.showDateTimePicker(
            context,
            showTitleActions: true,
            currentTime: DateTime.now(),
            locale: LocaleType.zh,
            minTime: DateTime(2021, 5, 10),
            maxTime: DateTime(2049, 5, 9),
            onConfirm: (date) {
              orderTime = formatDate(
                  date, [yyyy, "-", mm, "-", dd, " ", HH, ":", nn, ":", ss]);
              orderTimeTextEditingController.text = orderTime;
            },
          );
        },
        child: SizedBox(
          width: 200,
          child: TextFormField(
            onSaved: (value) => orderTime = value!,
            controller: orderTimeTextEditingController,
            enabled: false,
            decoration: InputDecoration(
              labelText: "下单时间：",
              labelStyle: TextStyle(fontSize: 14, height: 0.8),
            ),
          ),
        ),
      ),
    );
  }

  Widget toAddressRow() {
    return Flexible(
      child: SizedBox(
        width: 200,
        child: TextFormField(
          onSaved: (value) => orderToAddress = value!,
          controller: orderToAddressTextEditingController,
          decoration: InputDecoration(
            labelText: "目的地: ",
            labelStyle: TextStyle(fontSize: 14, height: 0.8),
          ),
        ),
      ),
    );
  }

  Widget delegateOrderNoRow() {
    return Flexible(
      child: SizedBox(
        width: 200,
        child: TextFormField(
          onSaved: (value) => delegateOrderNo = value!,
          controller: delegateOrderNoTextEditingController,
          decoration: InputDecoration(
            labelText: "转单号: ",
            labelStyle: TextStyle(fontSize: 14, height: 0.8),
          ),
        ),
      ),
    );
  }
}
