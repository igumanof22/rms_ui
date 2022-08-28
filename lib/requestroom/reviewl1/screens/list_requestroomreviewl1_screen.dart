import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/barrel/screens.dart';
import 'package:rms_ui/widgets/widgets.dart';

class HomeRequestRoomReviewL1Screen extends StatefulWidget {
  const HomeRequestRoomReviewL1Screen({Key? key}) : super(key: key);

  @override
  State<HomeRequestRoomReviewL1Screen> createState() =>
      _HomeRequestRoomReviewL1ScreenState();
}

class _HomeRequestRoomReviewL1ScreenState
    extends State<HomeRequestRoomReviewL1Screen> {
  late RequestRoomReviewL1Bloc _requestRoomReviewL1Bloc;

  @override
  void initState() {
    _requestRoomReviewL1Bloc = BlocProvider.of(context);

    _requestRoomReviewL1Bloc.add(RequestRoomReviewL1Fetch());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Review Request')),
      body: BlocBuilder<RequestRoomReviewL1Bloc, RequestRoomReviewL1State>(
        builder: (context, state) {
          if (state is RequestRoomReviewL1Initialized) {
            return ListView.builder(
              itemCount: state.listRequestRoom.length,
              itemBuilder: (context, index) {
                RequestRoom requestRoom = state.listRequestRoom[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: GestureDetector(
                    onTap: () => Get.to(() => DetailRequestRoomReviewL1Screen(
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
