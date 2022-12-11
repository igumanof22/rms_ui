import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/barrel/screens.dart';
import 'package:rms_ui/barrel/services.dart';
import 'package:rms_ui/widgets/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final SharedPreferences pref = App.instance.pref;
  late String? role;
  late RequestRoomBloc _requestRoomBloc;

  final PagingController<int, RequestRoom> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _requestRoomBloc = BlocProvider.of(context);
    role = pref.getString('role');

    _pagingController.addPageRequestListener((pageKey) {
      _requestRoomBloc
          .add(RequestRoomFetch(requestId: '', limit: 20, page: pageKey));
    });

    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  void _toCreateRequestAction() {
    Get.to(() => const CreateRequestRoomScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manajemen Ruang')),
      body: Column(children: [
        TextField(
          textInputAction: TextInputAction.go,
          decoration: const InputDecoration(
            labelText: 'Cari Berdasarkan Request Id',
            hintText: 'Cari Berdasarkan Request Id',
          ),
          onSubmitted: (value) {
            _requestRoomBloc
                .add(RequestRoomFetch(requestId: value, limit: 10, page: 0));
          },
        ),
        BlocListener<RequestRoomBloc, RequestRoomState>(
          listener: (context, state) {
            if (state is RequestRoomInitialized) {
              _pagingController.value = PagingState(
                  nextPageKey: state.nextPage, itemList: state.listRequestRoom);
            }
          },
          child: Expanded(
            child: PagedListView(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<RequestRoom>(
                itemBuilder: (context, item, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: GestureDetector(
                    onTap: () => Get.to(() => DetailHomePageScreen(
                          id: item.id!,
                          requestId: item.requestId!,
                        )),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 5),
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
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(item.requestId!),
                              Text(item.status!),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
      drawer: const DrawerMenu(),
      floatingActionButton: role != 'ADMIN' && role != 'ART'
          ? FloatingActionButton(
              onPressed: _toCreateRequestAction,
              mini: true,
              child: const Icon(Icons.add, size: 17),
            )
          : const Text(''),
    );
  }
}
