import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rms_ui/barrel/screens.dart';
import 'package:rms_ui/barrel/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  State<DrawerMenu> createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  final SharedPreferences pref = App.instance.pref;
  late String? role;

  @override
  void initState() {
    role = pref.getString('role');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                  child: CachedNetworkImage(
                    height: 100,
                    width: 100,
                    imageUrl: pref.getString('logo')!.isEmpty
                        ? 'https://picsum.photos/seed/picsum/800/800'
                        : pref.getString('logo')!,
                    placeholder: (context, url) =>
                        Image.asset('assets/image/logo.jpg', height: 100, width: 100,),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
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
            title: const Text('Profil'),
            onTap: () {
              Get.to(() => const ProfileUsersScreen());
            },
          ),
          ListTile(
            title: const Text('Keluar'),
            onTap: () {
              Get.off(() => const LoginUsersScreen());
            },
          ),
        ],
      ),
    );
  }
}
