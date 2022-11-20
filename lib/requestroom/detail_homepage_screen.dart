import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/models.dart';

class DetailHomePageScreen extends StatefulWidget {
  final String id;
  final String requestId;
  const DetailHomePageScreen(
      {Key? key, required this.id, required this.requestId})
      : super(key: key);

  @override
  State<DetailHomePageScreen> createState() => _DetailHomePageScreenState();
}

class _DetailHomePageScreenState extends State<DetailHomePageScreen> {
  final TextEditingController _roomController = TextEditingController();
  final TextEditingController _activityNameController = TextEditingController();
  final TextEditingController _activityLevelController =
      TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _participantController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  late RequestRoomBloc _requestRoomBloc;
  late RequestRoom requestRoom;
  List<Log> logs = [];
  bool _isLoading = false;

  @override
  void initState() {
    _requestRoomBloc = BlocProvider.of(context);

    _requestRoomBloc.add(RequestRoomGet(id: widget.id));

    super.initState();
  }

  void _detailRequestRoomListener(
      BuildContext context, RequestRoomState state) {
    if (state is RequestRoomLoading) {
      setState(() => _isLoading = true);
    }

    if (state is RequestRoomGetData || state is RequestRoomError) {
      setState(() => _isLoading = false);

      if (state is RequestRoomGetData) {
        setState(() => _isLoading = false);

        var outputFormat = DateFormat("dd MMMM yyyy");
        requestRoom = state.detailRequestRoom.requestRoom;
        logs = state.detailRequestRoom.logs;

        _roomController.text = requestRoom.room.roomId;
        _activityNameController.text = requestRoom.activityName;
        _activityLevelController.text = requestRoom.activityLevel.nama;
        _startDateController.text = outputFormat.format(requestRoom.startDate);
        _endDateController.text = outputFormat.format(requestRoom.endDate);
        _startTimeController.text = '${requestRoom.startTime} WIB';
        _endTimeController.text = '${requestRoom.endTime} WIB';
        _participantController.text = requestRoom.participant.toString();
        _statusController.text = requestRoom.status!;
      }
    }
  }

  void _downloadDocument() async {
    _requestRoomBloc.add(RequestRoomDownload(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RequestRoomBloc, RequestRoomState>(
      listener: _detailRequestRoomListener,
      child: WillPopScope(
        onWillPop: () {
          _requestRoomBloc.add(RequestRoomFetch(requestId: ''));
          return Future.value(true);
        },
        child: Scaffold(
          appBar: AppBar(title: Text('Detail Request ${widget.requestId}')),
          body: !_isLoading
              ? Column(
                  children: [
                    TextFormField(
                      controller: _roomController,
                      decoration: const InputDecoration(
                        labelText: 'Ruangan',
                      ),
                      readOnly: true,
                    ),
                    TextFormField(
                      controller: _activityNameController,
                      decoration: const InputDecoration(
                        labelText: 'Judul Acara',
                      ),
                      readOnly: true,
                    ),
                    TextFormField(
                      controller: _activityLevelController,
                      decoration: const InputDecoration(
                        labelText: 'Tingakatan Acara',
                      ),
                      readOnly: true,
                    ),
                    TextFormField(
                      controller: _startDateController,
                      decoration: const InputDecoration(
                        labelText: 'Tanggal Mulai Acara',
                      ),
                      readOnly: true,
                    ),
                    TextFormField(
                      controller: _endDateController,
                      decoration: const InputDecoration(
                        labelText: 'Tanggal Berakhir Acara',
                      ),
                      readOnly: true,
                    ),
                    TextFormField(
                      controller: _startTimeController,
                      decoration: const InputDecoration(
                        labelText: 'Jam Mulai Acara',
                      ),
                      readOnly: true,
                    ),
                    TextFormField(
                      controller: _endTimeController,
                      decoration: const InputDecoration(
                        labelText: 'Jam Berakhir Acara',
                      ),
                      readOnly: true,
                    ),
                    TextFormField(
                      controller: _participantController,
                      decoration: const InputDecoration(
                        labelText: 'Jumlah Peserta',
                      ),
                      readOnly: true,
                    ),
                    TextFormField(
                      controller: _statusController,
                      decoration: const InputDecoration(
                        labelText: 'Status Request',
                      ),
                      readOnly: true,
                    ),
                    if (_statusController.text.trim() == 'Request Done')
                      ElevatedButton(
                        onPressed: _downloadDocument,
                        child: const Text("Download Surat Peminjaman."),
                      ),
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(20),
                        itemCount: logs.length,
                        itemBuilder: (context, index) {
                          Log item = logs[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(DateFormat("dd-MM-yy")
                                    .format(item.createdDate)),
                                Text(item.actByName),
                                Text(item.remarks ?? ''),
                                Text(item.decisionRemark),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
