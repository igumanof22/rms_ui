import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              users.name!,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {},
                                child: const Text('Edit'),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red.shade400,
                                ),
                                child: const Text('Hapus'),
                              ),
                            ),
                          ],
                        )
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
