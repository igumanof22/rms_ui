import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/barrel/screens.dart';
import 'package:rms_ui/services/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRoomScreen extends StatefulWidget {
  const HomeRoomScreen({Key? key}) : super(key: key);

  @override
  State<HomeRoomScreen> createState() => _HomeRoomScreenState();
}

class _HomeRoomScreenState extends State<HomeRoomScreen> {
  final SharedPreferences pref = App.instance.pref;
  late RoomBloc _roomBloc;
  late String? _role;

  final List<String> _drop = ['Edit', 'Hapus'];
  String? _selectedDrop;

  final PagingController<int, Room> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _roomBloc = BlocProvider.of(context);

    _role = pref.getString('role');

    _pagingController.addPageRequestListener((pageKey) {
      _roomBloc.add(RoomFetch(roomId: '', limit: 20, page: pageKey));
    });

    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  void _toCreateRoomAction() {
    Get.to(() => const CreateRoomScreen());
  }

  void _toDetailRoomAction(List<RoomItem> items, String roomId) {
    Get.to(() => DetailRoomScreen(
          items: items,
          roomId: roomId,
        ));
  }

  void _toEditRoomAction(Room room) {
    Get.to(() => CreateRoomScreen(room: room));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Ruangan')),
      body: Column(
        children: [
          TextField(
            textInputAction: TextInputAction.go,
            decoration: const InputDecoration(
              labelText: 'Cari Berdasarkan Room Id',
              hintText: 'Cari Berdasarkan Room ID',
            ),
            onSubmitted: (value) {
              _roomBloc.add(RoomFetch(roomId: value, limit: 20, page: 0));
            },
          ),
          BlocListener(
            listener: (context, state) {
              if (state is RoomInitialized) {
              _pagingController.value = PagingState(
                  nextPageKey: state.nextPage, itemList: state.listRoom);
            }
            },
            child: PagedListView(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<Room>(
                  itemBuilder: (context, item, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: GestureDetector(
                      onTap: () =>
                          _toDetailRoomAction(item.roomItem, item.roomId),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(item.roomId),
                            Text(item.building),
                            Text(item.category),
                            Text(item.totalCapacity.toString()),
                            if (_role == 'ART' || _role == 'ADMIN')
                              SizedBox(
                                width: 150,
                                child: DropdownButtonFormField<String>(
                                  value: _selectedDrop,
                                  hint: const Text('Aksi'),
                                  borderRadius: null,
                                  decoration: const InputDecoration.collapsed(
                                      hintText: 'Aksi'),
                                  validator:
                                      ValidationBuilder().required().build(),
                                  items: _drop
                                      .map((e) => DropdownMenuItem<String>(
                                            value: e,
                                            child: Text(e),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    if (value == 'Edit') {
                                      _toEditRoomAction(item);
                                    }
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toCreateRoomAction,
        mini: true,
        child: const Icon(Icons.add, size: 17),
      ),
    );
  }
}
