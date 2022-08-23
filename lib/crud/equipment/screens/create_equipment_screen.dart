import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:rms_ui/common/blocs.dart';
import 'package:rms_ui/common/models.dart';

class CreateEquipmentScreen extends StatefulWidget {
  const CreateEquipmentScreen({Key? key}) : super(key: key);

  @override
  State<CreateEquipmentScreen> createState() => _CreateEquipmentScreenState();
}

class _CreateEquipmentScreenState extends State<CreateEquipmentScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final List<String> _class = ['XI MIPA 1', 'XI MIPA 2', 'XI MIPA 3'];
  final GlobalKey<FormState> _form = GlobalKey();
  late EquipmentBloc _equipmentBloc;
  String? _selectedClass;
  bool _isLoading = false;

  @override
  void initState() {
    _equipmentBloc = BlocProvider.of(context);

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
      Equipment equipment = Equipment(
        nama: _nameController.text.trim(),
      );

      _equipmentBloc.add(EquipmentCreate(equipment: equipment));
    }
  }

  void _EquipmentListener(BuildContext context, EquipmentState state) {
    if (state is EquipmentLoading) {
      setState(() => _isLoading = true);
    }

    if (state is EquipmentCreateSuccess || state is EquipmentError) {
      setState(() => _isLoading = false);

      if (state is EquipmentCreateSuccess) {
        Get.back();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EquipmentBloc, EquipmentState>(
      listener: _EquipmentListener,
      child: Scaffold(
        appBar: AppBar(title: const Text('Create Equipment')),
        body: Form(
          key: _form,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            children: [
              TextFormField(
                controller: _nameController,
                validator: ValidationBuilder().required().build(),
                decoration: const InputDecoration(
                  hintText: 'Nama Equipment',
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
