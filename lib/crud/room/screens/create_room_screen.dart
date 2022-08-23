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
  final GlobalKey<FormState> _form = GlobalKey();
  late RoomBloc _roomBloc;
  bool _isLoading = false;

  @override
  void initState() {
    _roomBloc = BlocProvider.of(context);

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _roomIdController.dispose();
    _buildingController.dispose();
    _categoryController.dispose();
    _totalCapacityController.dispose();

    super.dispose();
  }

  void _submitAction() {
    if (_form.currentState!.validate()) {
      Room room = Room(
        nama: _nameController.text.trim(),
        roomId: _roomIdController.text.trim(),
        building: _buildingController.text.trim(),
        category: _categoryController.text.trim(),
        totalCapacity: int.parse(_totalCapacityController.text.trim()),
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
        appBar: AppBar(title: const Text('Create Room')),
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
