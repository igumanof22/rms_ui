import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/barrel/screens.dart';

class HomeRoomScreen extends StatefulWidget {
  const HomeRoomScreen({Key? key}) : super(key: key);

  @override
  State<HomeRoomScreen> createState() => _HomeRoomScreenState();
}

class _HomeRoomScreenState extends State<HomeRoomScreen> {
  late RoomBloc _roomBloc;

  @override
  void initState() {
    _roomBloc = BlocProvider.of(context);

    _roomBloc.add(RoomFetch());

    super.initState();
  }

  void _toCreateRoomAction() {
    Get.to(() => const CreateRoomScreen());
  }

  void _toDetailRoomAction(List<RoomItem> items, String roomId) {
    Get.to(() => DetailRoomScreen(items: items, roomId: roomId,));
  }

  void _toEditRoomAction(Room room) {
    Get.to(() => CreateRoomScreen(room: room));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Ruangan')),
      body: BlocBuilder<RoomBloc, RoomState>(
        builder: (context, state) {
          if (state is RoomInitialized) {
            return ListView.builder(
              itemCount: state.listRoom.length,
              itemBuilder: (context, index) {
                Room room = state.listRoom[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: GestureDetector(
                    onTap: () => _toDetailRoomAction(room.roomItem, room.roomId),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 5),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(1, 2),
                            spreadRadius: .5,
                            blurRadius: .5,
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(room.roomId),
                              Text(room.building),
                              Text(room.category),
                              Text(room.totalCapacity.toString()),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () => _toEditRoomAction(room),
                                  child: const Text('Edit'),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red.shade400,
                                  ),
                                  child: const Text('Hapus'),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toCreateRoomAction,
        mini: true,
        child: const Icon(Icons.add, size: 17),
      ),
    );
  }
}
