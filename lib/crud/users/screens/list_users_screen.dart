import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/barrel/screens.dart';

class HomeUsersScreen extends StatefulWidget {
  const HomeUsersScreen({Key? key}) : super(key: key);

  @override
  State<HomeUsersScreen> createState() => _HomeUsersScreenState();
}

class _HomeUsersScreenState extends State<HomeUsersScreen> {
  late UsersBloc _usersBloc;

  final List<String> _drop = ['Edit', 'Hapus'];
  String? _selectedDrop;

  @override
  void initState() {
    _usersBloc = BlocProvider.of(context);

    _usersBloc.add(UsersFetch());

    super.initState();
  }

  void _toCreateUsersAction() {
    Get.to(() => const CreateUsersScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Akun')),
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state is UsersInitialized) {
            return ListView.builder(
              itemCount: state.listUsers.length,
              itemBuilder: (context, index) {
                Users users = state.listUsers[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(1, 2),
                          spreadRadius: .5,
                          blurRadius: .5,
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          users.name!,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        SizedBox(
                          width: 150,
                          child: DropdownButtonFormField<String>(
                            value: _selectedDrop,
                            hint: const Text('Aksi'),
                            borderRadius: null,
                            decoration: const InputDecoration.collapsed(hintText: 'Aksi'),
                            validator: ValidationBuilder().required().build(),
                            items: _drop
                                .map((e) => DropdownMenuItem<String>(
                                      value: e,
                                      child: Text(e),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toCreateUsersAction,
        mini: true,
        child: const Icon(Icons.add, size: 17),
      ),
    );
  }
}
