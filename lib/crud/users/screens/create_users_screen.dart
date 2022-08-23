import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:rms_ui/common/blocs.dart';
import 'package:rms_ui/common/models.dart';

class CreateUsersScreen extends StatefulWidget {
  const CreateUsersScreen({Key? key}) : super(key: key);

  @override
  State<CreateUsersScreen> createState() => _CreateUsersScreenState();
}

class _CreateUsersScreenState extends State<CreateUsersScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey();
  late UsersBloc _usersBloc;
  bool _isLoading = false;

  @override
  void initState() {
    _usersBloc = BlocProvider.of(context);

    super.initState();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _nameController.dispose();

    super.dispose();
  }

  void _submitAction() {
    if (_form.currentState!.validate()) {
      Users users = Users(
        username: _nameController.text.trim(),
        password: _passwordController.text.trim(),
        email: _emailController.text.trim(),
        name: _nameController.text.trim(),
      );

      _usersBloc.add(UsersCreate(users: users));
    }
  }

  void _usersListener(BuildContext context, UsersState state) {
    if (state is UsersLoading) {
      setState(() => _isLoading = true);
    }

    if (state is UsersCreateSuccess || state is UsersError) {
      setState(() => _isLoading = false);

      if (state is UsersCreateSuccess) {
        Get.back();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UsersBloc, UsersState>(
      listener: _usersListener,
      child: Scaffold(
        appBar: AppBar(title: const Text('Create Users')),
        body: Form(
          key: _form,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            children: [
              TextFormField(
                controller: _userNameController,
                validator: ValidationBuilder().required().build(),
                decoration: const InputDecoration(
                  hintText: 'Username',
                ),
                readOnly: _isLoading,
              ),
              TextFormField(
                controller: _passwordController,
                validator: ValidationBuilder().required().build(),
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
                readOnly: _isLoading,
              ),
              TextFormField(
                controller: _emailController,
                validator: ValidationBuilder().required().build(),
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
                readOnly: _isLoading,
              ),
              TextFormField(
                controller: _nameController,
                validator: ValidationBuilder().required().build(),
                decoration: const InputDecoration(
                  hintText: 'Nama',
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
