import 'package:flutter/material.dart';
import 'package:rms_ui/barrel/models.dart';

class DetailRoomScreen extends StatefulWidget {
  final List<RoomItem> items;
  final String roomId;
  const DetailRoomScreen({Key? key, required this.items, required this.roomId}) : super(key: key);

  @override
  State<DetailRoomScreen> createState() => _DetailRoomScreenState();
}

class _DetailRoomScreenState extends State<DetailRoomScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Daftar Perabot Ruang ${widget.roomId}')),
        body: Column(children: [
          ListView.builder(
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                RoomItem item = widget.items[index];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (item.equipment != null) Text(item.equipment!.nama),
                        if (item.furniture != null) Text(item.furniture!.nama),
                        Text(item.total.toString()),
                        Text(item.condition),
                      ],
                    )
                  ],
                );
              })
        ]));
  }
}
