import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:rms_ui/common/blocs.dart';
import 'package:rms_ui/common/screens.dart';
import 'package:rms_ui/common/services.dart';

void main() {
  // init api
  API.instance.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => EquipmentBloc()),
      ],
      child: GetMaterialApp(
        title: 'Simple Crud',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const ListEquipmentScreen(),
      ),
    );
  }
}
