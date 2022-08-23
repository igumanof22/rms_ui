import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  void initState() {
    _furnitureBloc = BlocProvider.of(context);

    _furnitureBloc.add(FurnitureFetch());

    super.initState();
  }

  void _toCreateFurnitureAction() {
    Get.to(() => const CreateFurnitureScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simple Crud')),
      body: BlocBuilder<FurnitureBloc, FurnitureState>(
        builder: (context, state) {
          if (state is FurnitureInitialized) {
            return ListView.builder(
              itemCount: state.listFurniture.length,
              itemBuilder: (context, index) {
                Furniture furniture = state.listFurniture[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
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
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {},
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
        onPressed: _toCreateFurnitureAction,
        mini: true,
        child: const Icon(Icons.add, size: 17),
      ),
    );
  }
}
