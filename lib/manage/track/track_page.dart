import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:logistics/comm/color.dart';
import 'package:logistics/comm/logger.dart';
import 'package:logistics/manage/track/track_nao.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

class TrackModelsNotifier with ChangeNotifier {
  TrackDTO? _selectedTrack;
  num? _orderId;
  TrackDTO? _savedTrack;

  set selectedTrack(TrackDTO? track) {
    _selectedTrack = track;
    notifyListeners();
  }

  TrackDTO? get selectedTrack => _selectedTrack;

  set savedTrack(TrackDTO? track) {
    _savedTrack = track;
    notifyListeners();
  }

  TrackDTO? get savedTrack => _savedTrack;

  set orderId(num? orderId) {
    _orderId = orderId;
    notifyListeners();
  }

  num? get orderId => _orderId;
}

class TrackPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TrackPageState();
  }
}

class _TrackPageState extends State<TrackPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TrackModelsNotifier(),
      child: Row(
        children: [
          Expanded(child: _TrackListPage()),
          Container(width: 1, color: Theme.of(context).dividerColor),
          Expanded(child: _TrackDetailsPage()),
        ],
      ),
    );
  }
}

class _TrackListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TrackListPageState();
  }
}

class _TrackListPageState extends State<_TrackListPage> {
  final TextEditingController textEditingController = TextEditingController();
  final TrackNao trackNao = TrackNao();
  List<TrackDTO> tracks = [];
  TrackDTO? getTrack;
  int? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 32),
          inputWidget(),
          SizedBox(height: 32),
          trackListView(),
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
            getAndShowTracks(textEditingController.text);
          },
          child: Text("搜索"),
        ),
      ],
    );
  }

  void getAndShowTracks(String orderNo) async {
    final notifier = context.read<TrackModelsNotifier>();
    try {
      final tracks = await trackNao.getTracks(orderNo);
      this.tracks = tracks.tracks;
      logger.d(tracks);
      notifier.orderId = tracks.order.id;
      if (this.tracks.isNotEmpty) {
        selectedItem = this.tracks.length - 1;
        context.read<TrackModelsNotifier>().selectedTrack = this.tracks.last;
      }
      setState(() {});
    } on DioError catch (e) {
      tracks = [];
      notifier.orderId = null;
      notifier.selectedTrack = null;
      setState(() {});
      showToast(e.response?.data?.toString() ?? "");
    }
  }

  Widget trackListView() {
    return Flexible(
      child: Column(
        children: [
          Container(
            color: hexColor("#d8f6ff"),
            child: trackItemWidget("时间", "区域", "详情"),
          ),
          Consumer<TrackModelsNotifier>(builder: (context, value, child) {
            final savedTrack = value.savedTrack;
            if (savedTrack != null) {
              if (tracks.contains(savedTrack)) {
                final index = tracks.indexOf(savedTrack);
                tracks.removeAt(index);
                tracks.insert(index, savedTrack);
              } else {
                tracks.add(savedTrack);
                selectedItem = tracks.length - 1;
              }
              value._savedTrack = null;
            }
            return Flexible(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final track = tracks[index];
                  return GestureDetector(
                    onTap: () {
                      selectedItem = index;
                      setState(() {});
                      context.read<TrackModelsNotifier>().selectedTrack = track;
                    },
                    child: trackItemWidget(track.time, track.area, track.event,
                        selectedItem == index),
                  );
                },
                itemCount: tracks.length,
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
                final notifier = context.read<TrackModelsNotifier>();
                if (notifier.orderId == null) {
                  showToast("请先输入订单号搜索");
                } else {
                  selectedItem = null;
                  notifier.selectedTrack = null;
                  setState(() {});
                }
              },
            ),
          ),
          SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget trackItemWidget(String trackTime, String trackArea, String trackEvent,
      [bool selected = false]) {
    return Container(
      color: selected ? Colors.grey[200] : Colors.transparent,
      child: Row(
        children: [
          cellWidget(1, trackTime),
          cellWidget(1, trackArea),
          cellWidget(1, trackEvent),
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

class _TrackDetailsPage extends StatefulWidget {
  TrackDTO? track;

  @override
  State<StatefulWidget> createState() {
    return _TrackDetailsPageState();
  }
}

class _TrackDetailsPageState extends State<_TrackDetailsPage> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TrackNao trackNao = TrackNao();
  late num? orderId;
  late String trackArea;
  late String trackEvent;
  final TextEditingController trackTimeTextEditingController =
      TextEditingController();
  final TextEditingController trackAreaTextEditingController =
      TextEditingController();
  final TextEditingController trackEventTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final notifier = context.watch<TrackModelsNotifier>();
    widget.track = notifier.selectedTrack;
    final track = widget.track;
    orderId = notifier.orderId;
    trackArea = track?.area ?? "";
    trackEvent = track?.event ?? "";

    trackTimeTextEditingController.text = track?.time ?? "";
    trackAreaTextEditingController.text = trackArea;
    trackEventTextEditingController.text = trackEvent;

    return Form(
      key: formKey,
      child: Column(
        children: [
          SizedBox(height: 32),
          trackTimeRow(),
          SizedBox(height: 12),
          trackAreaRow(),
          SizedBox(height: 12),
          trackEventRow(),
          SizedBox(height: 20),
          ElevatedButton(
              onPressed: orderId == null ? null : save, child: Text("保存"))
        ],
      ),
    );
  }

  void save() async {
    formKey.currentState?.save();
    if (trackArea == "" || trackEvent == "" || orderId == null) {
      return;
    }
    try {
      final notifier = context.read<TrackModelsNotifier>();
      TrackDTO track;
      final selectedTrack = notifier.selectedTrack;
      if (selectedTrack == null) {
        TrackCreateCommand trackCreateCommand = TrackCreateCommand(
          orderId!,
          trackArea,
          trackEvent,
          trackTimeTextEditingController.text,
        );
        track = await trackNao.addTrack(trackCreateCommand);
      } else {
        TrackModifyCommand trackModifyCommand = TrackModifyCommand(
          selectedTrack.id,
          trackArea,
          trackEvent,
          trackTimeTextEditingController.text,
        );
        track = await trackNao.modifyTrack(trackModifyCommand);
      }
      logger.d(track);
      notifier.savedTrack = track;
      notifier.selectedTrack = track;
      showToast("保存成功");
      setState(() {});
    } on DioError catch (e) {
      showToast(e.response?.data?.toString() ?? "");
    }
  }

  Widget trackTimeRow() {
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
              trackTimeTextEditingController.text = formatDate(
                  date, [yyyy, "-", mm, "-", dd, " ", HH, ":", nn, ":", ss]);
            },
          );
        },
        child: SizedBox(
          width: 200,
          child: TextFormField(
            controller: trackTimeTextEditingController,
            enabled: false,
            decoration: InputDecoration(
              labelText: "时间：",
              labelStyle: TextStyle(fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }

  Widget trackAreaRow() {
    return Flexible(
      child: SizedBox(
        width: 200,
        child: TextFormField(
          onSaved: (value) => trackArea = value!,
          controller: trackAreaTextEditingController,
          decoration: InputDecoration(
            labelText: "区域: ",
            labelStyle: TextStyle(fontSize: 14),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
          ),
        ),
      ),
    );
  }

  Widget trackEventRow() {
    return Flexible(
      child: SizedBox(
        width: 200,
        child: TextFormField(
          onSaved: (value) => trackEvent = value!,
          controller: trackEventTextEditingController,
          maxLines: 5,
          decoration: InputDecoration(
            labelText: "详情: ",
            labelStyle: TextStyle(fontSize: 14),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
          ),
        ),
      ),
    );
  }
}
