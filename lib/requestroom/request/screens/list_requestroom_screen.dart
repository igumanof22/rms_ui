import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/barrel/screens.dart';

class HomeRequestRoomScreen extends StatefulWidget {
  const HomeRequestRoomScreen({Key? key}) : super(key: key);

  @override
  State<HomeRequestRoomScreen> createState() => _HomeRequestRoomScreenState();
}

class _HomeRequestRoomScreenState extends State<HomeRequestRoomScreen> {
  late RequestRoomBloc _requestRoomBloc;

  @override
  void initState() {
    _requestRoomBloc = BlocProvider.of(context);

    _requestRoomBloc.add(RequestRoomFetch(requestId: '', limit: 20, page: 0));

    super.initState();
  }

  void _toCreateRequestRoomAction() {
    Get.to(() => const CreateRequestRoomScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Request Room')),
      body: BlocBuilder<RequestRoomBloc, RequestRoomState>(
        builder: (context, state) {
          if (state is RequestRoomInitialized) {
            return ListView.builder(
              itemCount: state.listRequestRoom.length,
              itemBuilder: (context, index) {
                RequestRoom requestRoom = state.listRequestRoom[index];

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
                            Text(requestRoom.activityName),
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
        onPressed: _toCreateRequestRoomAction,
        mini: true,
        child: const Icon(Icons.add, size: 17),
      ),
    );
  }
}
