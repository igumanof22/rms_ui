import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/models.dart';

class CreateFurnitureScreen extends StatefulWidget {
  const CreateFurnitureScreen({Key? key}) : super(key: key);

  @override
  State<CreateFurnitureScreen> createState() => _CreateFurnitureScreen();
}

class _CreateFurnitureScreen extends State<CreateFurnitureScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final List<String> _class = ['XI MIPA 1', 'XI MIPA 2', 'XI MIPA 3'];
  final GlobalKey<FormState> _form = GlobalKey();
  late FurnitureBloc _furnitureBloc;
  String? _selectedClass;
  bool _isLoading = false;

  @override
  void initState() {
    _furnitureBloc = BlocProvider.of(context);

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();

    super.dispose();
  }

  void _submitAction() {
    if (_form.currentState!.validate()) {
      Furniture furniture = Furniture(
        nama: _nameController.text.trim(),
      );

      _furnitureBloc.add(FurnitureCreate(furniture: furniture));
    }
  }

  void _furnitureListener(BuildContext context, FurnitureState state) {
    if (state is FurnitureLoading) {
      setState(() => _isLoading = true);
    }

    if (state is FurnitureCreateSuccess || state is FurnitureError) {
      setState(() => _isLoading = false);

      if (state is FurnitureCreateSuccess) {
        Get.back();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FurnitureBloc, FurnitureState>(
      listener: _furnitureListener,
      child: Scaffold(
        appBar: AppBar(title: const Text('Create Furniture')),
        body: Form(
          key: _form,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            children: [
              TextFormField(
                controller: _nameController,
                validator: ValidationBuilder().required().build(),
                decoration: const InputDecoration(
                  hintText: 'Nama Furniture',
                ),
                readOnly: _isLoading,
              ),
              DropdownButtonFormField<String>(
                value: _selectedClass,
                hint: const Text('Pilih kelas'),
                validator: ValidationBuilder().required().build(),
                items: _class
                    .map((e) => DropdownMenuItem<String>(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: _isLoading
                    ? null
                    : (selectedClass) => _selectedClass = selectedClass,
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
