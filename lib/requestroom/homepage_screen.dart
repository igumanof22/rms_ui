import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/barrel/screens.dart';
import 'package:rms_ui/barrel/services.dart';
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
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 2),
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/image/decor.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
              padding: EdgeInsets.zero,
              child: Row(
                children: [
                  ClipOval(
                    child: Image.network(
                      pref.getString('logo')!.isEmpty
                          ? 'https://picsum.photos/seed/picsum/800/800'
                          : pref.getString('logo')!,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    pref.getString('name')!,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Ruangan'),
              onTap: () {
                Get.to(() => const HomeRoomScreen());
              },
            ),
            if (role == 'ART' || role == 'ADMIN')
              ListTile(
                title: const Text('Furnitur'),
                onTap: () {
                  Get.to(() => const HomeFurnitureScreen());
                },
              ),
            if (role == 'ART' || role == 'ADMIN')
              ListTile(
                title: const Text('Peralatan'),
                onTap: () {
                  Get.to(() => const HomeEquipmentScreen());
                },
              ),
            if (role == 'ADMIN')
              ListTile(
                title: const Text('Akun'),
                onTap: () {
                  Get.to(() => const HomeUsersScreen());
                },
              ),
            ListTile(
              title: const Text('Request Peminjaman'),
              onTap: () {
                Get.to(() => const CreateRequestRoomScreen());
              },
            ),
            ListTile(
              title: const Text('Profil'),
              onTap: () {
                Get.to(() => const ProfileUsersScreen());
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toCreateRequestAction,
        mini: true,
        child: const Icon(Icons.add, size: 17),
      ),
    );
  }
}
