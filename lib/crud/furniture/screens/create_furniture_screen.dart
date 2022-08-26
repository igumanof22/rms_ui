import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/models.dart';

class CreateFurnitureScreen extends StatefulWidget {
  final String? id;
  const CreateFurnitureScreen({Key? key, this.id}) : super(key: key);

  @override
  State<CreateFurnitureScreen> createState() => _CreateFurnitureScreen();
}

class _CreateFurnitureScreen extends State<CreateFurnitureScreen> {
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey();
  late FurnitureBloc _furnitureBloc;
  bool _isLoading = false;

  @override
  void initState() {
    _furnitureBloc = BlocProvider.of(context);

    if (widget.id != null) {
      _furnitureBloc.add(FurnitureGet(id: widget.id!));
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
        Furniture furniture = Furniture(
          nama: _nameController.text.trim(),
        );

        _furnitureBloc.add(FurnitureCreate(furniture: furniture));
      }

      if (widget.id != null) {
        Furniture furniture = Furniture(
          nama: _nameController.text.trim(),
        );

        _furnitureBloc
            .add(FurnitureUpdate(id: widget.id!, furniture: furniture));
      }
    }
  }

  void _furnitureListener(BuildContext context, FurnitureState state) {
    if (state is FurnitureLoading) {
      setState(() => _isLoading = true);
    }

    if (state is FurnitureSuccess ||
        state is FurnitureError) {
      setState(() => _isLoading = false);

      if (state is FurnitureSuccess) {
        Get.back();
      }

      if (state is FurnitureGetData) {
        setState(() => _isLoading = false);

        _nameController.text = state.furniture.nama;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FurnitureBloc, FurnitureState>(
      listener: _furnitureListener,
      child: Scaffold(
        appBar: AppBar(title: Text(widget.id == null ? 'Tambah Furnitur' : 'Edit Furnitur')),
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
