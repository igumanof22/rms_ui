import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/barrel/screens.dart';
import 'package:rms_ui/widgets/widgets.dart';

class HomeRequestRoomCompleteScreen extends StatefulWidget {
  const HomeRequestRoomCompleteScreen({Key? key}) : super(key: key);

  @override
  State<HomeRequestRoomCompleteScreen> createState() =>
      _HomeRequestRoomCompleteScreenState();
}

class _HomeRequestRoomCompleteScreenState
    extends State<HomeRequestRoomCompleteScreen> {
  late RequestRoomCompleteBloc _requestRoomReviewBloc;

  @override
  void initState() {
    _requestRoomReviewBloc = BlocProvider.of(context);

    _requestRoomReviewBloc.add(RequestRoomCompleteFetch());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Review Request')),
      body: BlocBuilder<RequestRoomCompleteBloc, RequestRoomCompleteState>(
        builder: (context, state) {
          if (state is RequestRoomCompleteInitialized) {
            return ListView.builder(
              itemCount: state.listRequestRoom.length,
              itemBuilder: (context, index) {
                RequestRoom requestRoom = state.listRequestRoom[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: GestureDetector(
                    onTap: () => Get.to(() => DetailRequestRoomCompleteScreen(
                          id: requestRoom.id!,
                          requestId: requestRoom.requestId!,
                        )),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 5),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: requestRoom.rank == 0
                            ? Colors.white
                            : requestRoom.rank == 1
                                ? Colors.green
                                : Colors.red,
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
                              Text(requestRoom.requestId!),
                              Text(requestRoom.status!),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
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
      drawer: const DrawerMenu(),
    );
  }
}
