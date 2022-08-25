import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/screens.dart';

class LoginUsersScreen extends StatefulWidget {
  const LoginUsersScreen({Key? key}) : super(key: key);

  @override
  State<LoginUsersScreen> createState() => _LoginUsersScreenState();
}

class _LoginUsersScreenState extends State<LoginUsersScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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

    super.dispose();
  }

  void _loginAction() {
    if (_form.currentState!.validate()) {
      _usersBloc.add(UsersLogin(
          username: _userNameController.text.trim(),
          password: _passwordController.text.trim()));
    }
  }

  void _signUpAction() {
    Get.to(() => const CreateUsersScreen());
  }

  void _usersListener(BuildContext context, UsersState state) {
    if (state is UsersLoading) {
      setState(() => _isLoading = true);
    }

    if (state is UsersLoginSuccess || state is UsersError) {
      setState(() => _isLoading = false);

      if (state is UsersLoginSuccess) {
        Get.off(() => const HomePageScreen());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UsersBloc, UsersState>(
      listener: _usersListener,
      child: Scaffold(
        appBar: AppBar(title: const Text('Login')),
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
              const SizedBox(height: 50),
              _isLoading
                  ? Wrap(
                      alignment: WrapAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                      ],
                    )
                  : ElevatedButton(
                      onPressed: _loginAction,
                      child: const Text('Login'),
                    ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Belum punya akun? '),
                  GestureDetector(
                    onTap: _signUpAction,
                    child: const Text('Daftar', style: TextStyle(color: Colors.blue,)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
