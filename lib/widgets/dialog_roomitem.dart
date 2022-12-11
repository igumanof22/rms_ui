import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/models.dart';

class DialogBuilder extends StatefulWidget {
  final ValueNotifier<List<RoomItem>> items;
  const DialogBuilder({Key? key, required this.items}) : super(key: key);

  @override
  State<DialogBuilder> createState() => _DialogBuilderState();
}

class _DialogBuilderState extends State<DialogBuilder> {
  final TextEditingController _totalController = TextEditingController();
  final TextEditingController _conditionController = TextEditingController();
  late EquipmentBloc _equipmentBloc;
  late FurnitureBloc _furnitureBloc;
  Equipment? _selectedEquipment;
  Furniture? _selectedFurniture;

  @override
  void initState() {
    _equipmentBloc = BlocProvider.of(context);
    _furnitureBloc = BlocProvider.of(context);

    _equipmentBloc.add(EquipmentFetch(name: '', limit: 999999, page: 0));
    _furnitureBloc.add(FurnitureFetch(name: '', limit: 999999, page: 0));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: Dialog(
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Pilih Peralatan'),
              BlocBuilder<EquipmentBloc, EquipmentState>(
                builder: (context, state) {
                  if (state is EquipmentInitialized) {
                    return DropdownButton<Equipment>(
                      isExpanded: true,
                      value: _selectedEquipment,
                      items: state.listEquipment
                          .map((e) => DropdownMenuItem<Equipment>(
                                value: e,
                                child: Text(e.nama),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedEquipment = value;
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
                      isExpanded: true,
                      value: _selectedFurniture,
                      items: state.listFurniture
                          .map((e) => DropdownMenuItem<Furniture>(
                                value: e,
                                child: Text(e.nama),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedFurniture = value;
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
                      widget.items.value = List.from(widget.items.value)..add(item);

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
                      widget.items.value = List.from(widget.items.value)..add(item);

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
  }
}
