import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/barrel/screens.dart';

class HomeEquipmentScreen extends StatefulWidget {
  const HomeEquipmentScreen({Key? key}) : super(key: key);

  @override
  State<HomeEquipmentScreen> createState() => _HomeEquipmentScreenState();
}

class _HomeEquipmentScreenState extends State<HomeEquipmentScreen> {
  late EquipmentBloc _equipmentBloc;

  final List<String> _drop = ['Edit', 'Hapus'];
  String? _selectedDrop;

  final PagingController<int, Equipment> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _equipmentBloc = BlocProvider.of(context);
    _pagingController.addPageRequestListener((pageKey) {
      _equipmentBloc.add(EquipmentFetch(name: '', limit: 20, page: pageKey));
    });

    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  void _toCreateEquipmentAction() {
    Get.to(() => const CreateEquipmentScreen());
  }

  void _toEditEquipmentAction(String id) {
    Get.to(() => CreateEquipmentScreen(id: id));
  }

  void _toDeleteEquipmentAction(String id) {
    _equipmentBloc.add(EquipmentDelete(id: id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Peralatan')),
      body: Column(
        children: [
          TextField(
            textInputAction: TextInputAction.go,
            decoration: const InputDecoration(
              labelText: 'Cari Berdasarkan Nama',
              hintText: 'Cari Berdasarkan Nama',
            ),
            onSubmitted: (value) {
              _equipmentBloc
                  .add(EquipmentFetch(name: value, limit: 20, page: 0));
            },
          ),
          BlocListener(
            listener: (context, state) {
              if (state is EquipmentInitialized) {
                _pagingController.value = PagingState(
                    nextPageKey: state.nextPage, itemList: state.listEquipment);
              }
            },
            child: PagedListView(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<Equipment>(
                  itemBuilder: (context, item, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
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
                              Text(item.nama),
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
                                      _toEditEquipmentAction(item.id!);
                                    } else {
                                      _toDeleteEquipmentAction(item.id!);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toCreateEquipmentAction,
        mini: true,
        child: const Icon(Icons.add, size: 17),
      ),
    );
  }
}
