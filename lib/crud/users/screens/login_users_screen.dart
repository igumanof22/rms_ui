import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/screens.dart';
import 'package:rms_ui/barrel/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginUsersScreen extends StatefulWidget {
  const LoginUsersScreen({Key? key}) : super(key: key);

  @override
  State<LoginUsersScreen> createState() => _LoginUsersScreenState();
}

class _LoginUsersScreenState extends State<LoginUsersScreen> {
  final SharedPreferences pref = App.instance.pref;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey();
  late UsersBloc _usersBloc;
  bool _isLoading = false;
  bool _obscureText = true;

  @override
  void initState() {
    _usersBloc = BlocProvider.of(context);

    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void _loginAction() {
    if (_form.currentState!.validate()) {
      _usersBloc.add(UsersLogin(
        username: _usernameController.text.trim(),
        password: _passwordController.text.trim(),
      ));
    }
  }

  void _signUpAction() {
    Get.to(() => const SignUpUsersScreen());
  }

  void _usersListener(BuildContext context, UsersState state) {
    if (state is UsersLoading) {
      setState(() => _isLoading = true);
    }

    if (state is UsersSuccess || state is UsersError) {
      setState(() => _isLoading = false);

      if (state is UsersSuccess) {
        String role = pref.getString('role')!;
        if (role.toLowerCase() == 'administrasi') {
          Get.off(() => const HomeRequestRoomReviewScreen());
        } else {
          Get.off(() => const HomePageScreen());
        }
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
                autofocus: true,
                controller: _usernameController,
                validator: ValidationBuilder().required().build(),
                decoration: const InputDecoration(
                  labelText: 'Username',
                  hintText: 'Username',
                ),
                readOnly: _isLoading,
              ),
              TextFormField(
                textInputAction: TextInputAction.go,
                controller: _passwordController,
                validator: ValidationBuilder().required().build(),
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'Password',
                ),
                obscureText: _obscureText,
                readOnly: _isLoading,
                onFieldSubmitted: (value) {
                  _loginAction();
                },
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Text(_obscureText ? "Show" : "Hide"),
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
                    child: const Text('Daftar',
                        style: TextStyle(
                          color: Colors.blue,
                        )),
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
