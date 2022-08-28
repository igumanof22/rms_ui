import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/barrel/screens.dart';
import 'package:rms_ui/barrel/services.dart';
import 'package:rms_ui/widgets/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final SharedPreferences pref = App.instance.pref;
  late String? role;
  late RequestRoomBloc _requestRoomBloc;

  @override
  void initState() {
    _requestRoomBloc = BlocProvider.of(context);
    role = pref.getString('role');
    _requestRoomBloc.add(RequestRoomFetch());

    super.initState();
  }

  void _toCreateRequestAction() {
    Get.to(() => const CreateRequestRoomScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manajemen Ruang')),
      body: BlocBuilder<RequestRoomBloc, RequestRoomState>(
        builder: (context, state) {
          if (state is RequestRoomInitialized) {
            return ListView.builder(
              itemCount: state.listRequestRoom.length,
              itemBuilder: (context, index) {
                RequestRoom requestRoom = state.listRequestRoom[index];

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
                            Text(requestRoom.requestId!),
                          ],
                        ),
                        const SizedBox(height: 10),
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
      drawer: const DrawerMenu(),
      floatingActionButton: role != 'ADMIN' && role != 'ART'
          ? FloatingActionButton(
              onPressed: _toCreateRequestAction,
              mini: true,
              child: const Icon(Icons.add, size: 17),
            )
          : const Text(''),
    );
  }
}
