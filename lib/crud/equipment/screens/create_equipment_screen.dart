import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/models.dart';

class CreateEquipmentScreen extends StatefulWidget {
  final String? id;
  const CreateEquipmentScreen({Key? key, this.id}) : super(key: key);

  @override
  State<CreateEquipmentScreen> createState() => _CreateEquipmentScreenState();
}

class _CreateEquipmentScreenState extends State<CreateEquipmentScreen> {
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey();
  late EquipmentBloc _equipmentBloc;
  bool _isLoading = false;

  @override
  void initState() {
    _equipmentBloc = BlocProvider.of(context);

    if (widget.id != null) {
      _equipmentBloc.add(EquipmentGet(id: widget.id!));
    }

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();

    super.dispose();
  }

  void _submitAction() {
    if (_form.currentState!.validate()) {
      if (widget.id == null) {
        Equipment equipment = Equipment(
          nama: _nameController.text.trim(),
        );
        _equipmentBloc.add(EquipmentCreate(equipment: equipment));
      }

      if (widget.id != null) {
        Equipment equipment = Equipment(
          nama: _nameController.text.trim(),
        );
        _equipmentBloc
            .add(EquipmentUpdate(id: widget.id!, equipment: equipment));
      }
    }
  }

  void _equipmentListener(BuildContext context, EquipmentState state) {
    if (state is EquipmentLoading) {
      setState(() => _isLoading = true);
    }

    if (state is EquipmentSuccess || state is EquipmentError) {
      setState(() => _isLoading = false);

      if (state is EquipmentSuccess) {
        Get.back();
      }
    }

    if (state is EquipmentGetData) {
      setState(() => _isLoading = false);

      _nameController.text = state.equipment.nama;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EquipmentBloc, EquipmentState>(
      listener: _equipmentListener,
      child: Scaffold(
        appBar: AppBar(
            title: Text(
                widget.id == null ? 'Tambah Peralatan' : 'Ubah Peralatan')),
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
