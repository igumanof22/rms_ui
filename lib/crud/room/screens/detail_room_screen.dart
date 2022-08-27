import 'package:flutter/material.dart';
import 'package:rms_ui/barrel/models.dart';

class DetailRoomScreen extends StatefulWidget {
  final List<RoomItem> items;
  final String roomId;
  const DetailRoomScreen({Key? key, required this.items, required this.roomId})
      : super(key: key);

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
        body: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: widget.items.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Nama',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Jumlah',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Kondisi',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                );
              }
              RoomItem item = widget.items[index - 1];
              if (item.equipment == null && item.furniture == null) {
                return const SizedBox.shrink();
              }
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    item.equipment != null
                        ? Text(item.equipment!.nama,
                            style: const TextStyle(fontSize: 20))
                        : Text(item.furniture!.nama,
                            style: const TextStyle(fontSize: 20)),
                    Text(item.total.toString(),
                        style: const TextStyle(fontSize: 20)),
                    Text(item.condition, style: const TextStyle(fontSize: 20)),
                  ],
                ),
              );
            }));
  }
}
