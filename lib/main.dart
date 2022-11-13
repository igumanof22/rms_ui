import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/screens.dart';
import 'package:rms_ui/barrel/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // init api
  await App.instance.init(null);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UsersBloc()),
        BlocProvider(create: (_) => FurnitureBloc()),
        BlocProvider(create: (_) => EquipmentBloc()),
        BlocProvider(create: (_) => RoomBloc()),
        BlocProvider(create: (_) => ActivityLevelBloc()),
        BlocProvider(create: (_) => RequestRoomBloc()),
        BlocProvider(create: (_) => RequestRoomModifyBloc()),
        BlocProvider(create: (_) => RequestRoomReviewBloc()),
        BlocProvider(create: (_) => RequestRoomCompleteBloc()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Room Management',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginUsersScreen(),
      ),
    );
  }
}
