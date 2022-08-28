import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/widgets/widgets.dart';

class HomeRequestRoomReviewL2Screen extends StatefulWidget {
  const HomeRequestRoomReviewL2Screen({Key? key}) : super(key: key);

  @override
  State<HomeRequestRoomReviewL2Screen> createState() =>
      _HomeRequestRoomReviewL2ScreenState();
}

class _HomeRequestRoomReviewL2ScreenState
    extends State<HomeRequestRoomReviewL2Screen> {
  late RequestRoomReviewL2Bloc _requestRoomBloc;

  @override
  void initState() {
    _requestRoomBloc = BlocProvider.of(context);

    _requestRoomBloc.add(RequestRoomReviewL2Fetch());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Review Request')),
      body: BlocBuilder<RequestRoomReviewL2Bloc, RequestRoomReviewL2State>(
        builder: (context, state) {
          if (state is RequestRoomReviewL2Initialized) {
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
      drawer: const DrawerMenu(),
    );
  }
}
