import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/barrel/screens.dart';

class HomeFurnitureScreen extends StatefulWidget {
  const HomeFurnitureScreen({Key? key}) : super(key: key);

  @override
  State<HomeFurnitureScreen> createState() => _HomeFurnitureScreen();
}

class _HomeFurnitureScreen extends State<HomeFurnitureScreen> {
  late FurnitureBloc _furnitureBloc;

  final List<String> _drop = ['Edit', 'Hapus'];
  String? _selectedDrop;

  @override
  void initState() {
    _furnitureBloc = BlocProvider.of(context);

    _furnitureBloc.add(FurnitureFetch(name: ''));

    super.initState();
  }

  void _toCreateFurnitureAction() {
    Get.to(() => const CreateFurnitureScreen());
  }

  void _toEditFurnitureAction(String id) {
    Get.to(() => CreateFurnitureScreen(id: id));
  }

  void _toDeleteFurnitureAction(String id) {
    _furnitureBloc.add(FurnitureDelete(id: id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Furnitur')),
      body: Column(children: [
        TextField(
          textInputAction: TextInputAction.go,
          decoration: const InputDecoration(
            labelText: 'Cari Berdasarkan Nama',
            hintText: 'Cari Berdasarkan Nama',
          ),
          onSubmitted: (value) {
            _furnitureBloc.add(FurnitureFetch(name: value));
          },
        ),
        BlocBuilder<FurnitureBloc, FurnitureState>(
          builder: (context, state) {
            if (state is FurnitureInitialized) {
              return Expanded(
                child: ListView.builder(
                  itemCount: state.listFurniture.length,
                  itemBuilder: (context, index) {
                    Furniture furniture = state.listFurniture[index];

                    return Padding(
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
                                Text(furniture.nama),
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
                                        _toEditFurnitureAction(furniture.id!);
                                      } else {
                                        _toDeleteFurnitureAction(furniture.id!);
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: _toCreateFurnitureAction,
        mini: true,
        child: const Icon(Icons.add, size: 17),
      ),
    );
  }
}
