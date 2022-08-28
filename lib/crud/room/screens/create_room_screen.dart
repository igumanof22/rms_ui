import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/widgets/widgets.dart';

class CreateRoomScreen extends StatefulWidget {
  final Room? room;
  const CreateRoomScreen({Key? key, this.room}) : super(key: key);

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController _roomIdController = TextEditingController();
  final TextEditingController _buildingController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _totalCapacityController =
      TextEditingController();
  final TextEditingController _totalController = TextEditingController();
  final TextEditingController _conditionController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey();
  final ValueNotifier<List<RoomItem>> _items = ValueNotifier([]);
  late RoomBloc _roomBloc;
  bool _isLoading = false;

  @override
  void initState() {
    _roomBloc = BlocProvider.of(context);

    if (widget.room != null) {
      Room room = widget.room!;
      _roomIdController.text = room.roomId;
      _buildingController.text = room.building;
      _categoryController.text = room.category;
      _totalCapacityController.text = room.totalCapacity.toString();
      _items.value = room.roomItem;
    }

    super.initState();
  }

  @override
  void dispose() {
    _roomIdController.dispose();
    _buildingController.dispose();
    _categoryController.dispose();
    _totalCapacityController.dispose();
    _totalController.dispose();
    _conditionController.dispose();

    super.dispose();
  }

  void _addItemAction() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'add_item_dialog',
      pageBuilder: (context, a1, a2) {
        return DialogBuilder(items: _items);
      },
      transitionBuilder: (context, a1, a2, child) {
        double curve = Curves.elasticInOut.transform(a1.value);

        return Transform.scale(
          scale: curve,
          child: child,
        );
      },
    );
  }

  void _submitAction() {
    if (_form.currentState!.validate()) {
      if (widget.room == null) {
        Room room = Room(
          roomId: _roomIdController.text.trim(),
          building: _buildingController.text.trim(),
          category: _categoryController.text.trim(),
          totalCapacity: int.parse(_totalCapacityController.text.trim()),
          roomItem: _items.value,
        );
        _roomBloc.add(RoomCreate(room: room));
      } else {
        Room room = Room(
          id: widget.room!.id,
          roomId: _roomIdController.text.trim(),
          building: _buildingController.text.trim(),
          category: _categoryController.text.trim(),
          totalCapacity: int.parse(_totalCapacityController.text.trim()),
          roomItem: _items.value,
        );
        _roomBloc.add(RoomUpdate(room: room));
      }
    }
  }

  void _roomListener(BuildContext context, RoomState state) {
    if (state is RoomLoading) {
      setState(() => _isLoading = true);
    }

    if (state is RoomSuccess || state is RoomError) {
      setState(() => _isLoading = false);

      if (state is RoomSuccess) {
        Get.back();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RoomBloc, RoomState>(
      listener: _roomListener,
      child: Scaffold(
        appBar: AppBar(title: const Text('Tambah Ruangan')),
        body: Form(
          key: _form,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            children: [
              TextFormField(
                controller: _roomIdController,
                validator: ValidationBuilder().required().build(),
                decoration: const InputDecoration(
                  hintText: 'Room ID',
                ),
                readOnly: _isLoading,
              ),
              TextFormField(
                controller: _buildingController,
                validator: ValidationBuilder().required().build(),
                decoration: const InputDecoration(
                  hintText: 'Nama Gedung',
                ),
                readOnly: _isLoading,
              ),
              TextFormField(
                controller: _categoryController,
                validator: ValidationBuilder().required().build(),
                decoration: const InputDecoration(
                  hintText: 'Kategori',
                ),
                readOnly: _isLoading,
              ),
              TextFormField(
                controller: _totalCapacityController,
                validator: ValidationBuilder().required().build(),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Total kapasistas',
                ),
                readOnly: _isLoading,
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: _addItemAction,
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                child: const Text('Tambah Item'),
              ),
              const SizedBox(height: 20),
              ValueListenableBuilder<List<RoomItem>>(
                valueListenable: _items,
                builder: (context, items, child) {
                  return Column(
                    children: items
                        .asMap()
                        .entries
                        .map((e) => Row(
                              children: [
                                if (e.value.furniture != null)
                                  Text(e.value.furniture!.nama),
                                if (e.value.equipment != null)
                                  Text(e.value.equipment!.nama),
                                const SizedBox(width: 20),
                                Text(e.value.total.toString()),
                                const SizedBox(width: 20),
                                Text(e.value.condition),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    int index = e.key;

                                    List<RoomItem> items2 =
                                        List.from(_items.value);
                                    items2.removeAt(index);

                                    _items.value = items2;
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                              ],
                            ))
                        .toList(),
                  );
                },
              ),
              _isLoading
                  ? Wrap(
                      alignment: WrapAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                      ],
                    )
                  : ElevatedButton(
                      onPressed: _submitAction,
                      child: const Text('Submit'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
