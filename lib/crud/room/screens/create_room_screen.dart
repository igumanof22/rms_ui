import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/models.dart';

class CreateRoomScreen extends StatefulWidget {
  const CreateRoomScreen({Key? key}) : super(key: key);

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
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
  late EquipmentBloc _equipmentBloc;
  late FurnitureBloc _furnitureBloc;
  Equipment? _selectedEquipment;
  Furniture? _selectedFurniture;
  bool _isLoading = false;

  @override
  void initState() {
    _roomBloc = BlocProvider.of(context);
    _equipmentBloc = BlocProvider.of(context);
    _furnitureBloc = BlocProvider.of(context);

    _equipmentBloc.add(EquipmentFetch());
    _furnitureBloc.add(FurnitureFetch());

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
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
        return WillPopScope(
          onWillPop: () {
            return Future.value(true);
          },
          child: Dialog(
            child: Padding(
              padding: const EdgeInsets.all(13),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Pilih Peralatan'),
                  BlocBuilder<EquipmentBloc, EquipmentState>(
                    builder: (context, state) {
                      if (state is EquipmentInitialized) {
                        return DropdownButton<Equipment>(
                          value: _selectedEquipment,
                          items: state.listEquipment
                              .map((e) => DropdownMenuItem<Equipment>(
                                    value: e,
                                    child: Text(e.nama),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            _selectedEquipment = value;
                            setState(() {
                              _selectedEquipment;
                            });
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  const Text('Pilih Perabotan'),
                  BlocBuilder<FurnitureBloc, FurnitureState>(
                    builder: (context, state) {
                      if (state is FurnitureInitialized) {
                        return DropdownButton<Furniture>(
                          value: _selectedFurniture,
                          items: state.listFurniture
                              .map((e) => DropdownMenuItem<Furniture>(
                                    value: e,
                                    child: Text(e.nama),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            _selectedFurniture = value;
                            setState(() {
                              _selectedFurniture;
                            });
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  TextFormField(
                    controller: _totalController,
                    decoration: const InputDecoration(
                      hintText: 'Total Item',
                    ),
                  ),
                  TextFormField(
                    controller: _conditionController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Kondisi Item',
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          RoomItem item = RoomItem(
                            equipment: _selectedEquipment,
                            furniture: null,
                            total: int.parse(_totalController.text.trim()),
                            condition: _conditionController.text.trim(),
                          );

                          // buat list baru untuk trigger agar biar state ke update
                          _items.value = List.from(_items.value)..add(item);

                          _totalController.clear();
                          _conditionController.clear();

                          Get.back();
                        },
                        child: const Text('Tambah Peralatan'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          RoomItem item = RoomItem(
                            equipment: null,
                            furniture: _selectedFurniture,
                            total: int.parse(_totalController.text.trim()),
                            condition: _conditionController.text.trim(),
                          );

                          // buat list baru untuk trigger agar biar state ke update
                          _items.value = List.from(_items.value)..add(item);

                          _totalController.clear();
                          _conditionController.clear();

                          Get.back();
                        },
                        child: const Text('Tambah Perabotan'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
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
      Room room = Room(
        nama: _nameController.text.trim(),
        roomId: _roomIdController.text.trim(),
        building: _buildingController.text.trim(),
        category: _categoryController.text.trim(),
        totalCapacity: int.parse(_totalCapacityController.text.trim()),
        roomItem: _items.value,
      );

      _roomBloc.add(RoomCreate(room: room));
    }
  }

  void _roomListener(BuildContext context, RoomState state) {
    if (state is RoomLoading) {
      setState(() => _isLoading = true);
    }

    if (state is RoomCreateSuccess || state is RoomError) {
      setState(() => _isLoading = false);

      if (state is RoomCreateSuccess) {
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
                controller: _nameController,
                validator: ValidationBuilder().required().build(),
                decoration: const InputDecoration(
                  hintText: 'Nama Room',
                ),
                readOnly: _isLoading,
              ),
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
                child: const Text('Tambah Perabotan'),
              ),
              const SizedBox(height: 20),
              ValueListenableBuilder<List<RoomItem>>(
                valueListenable: _items,
                builder: (context, books, child) {
                  return Column(
                    children: books
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
