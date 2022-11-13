import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/models.dart';

class DetailRequestRoomCompleteScreen extends StatefulWidget {
  final String id;
  final String requestId;
  const DetailRequestRoomCompleteScreen(
      {Key? key, required this.id, required this.requestId})
      : super(key: key);

  @override
  State<DetailRequestRoomCompleteScreen> createState() =>
      _DetailRequestRoomCompleteScreenState();
}

class _DetailRequestRoomCompleteScreenState
    extends State<DetailRequestRoomCompleteScreen> {
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
  late RequestRoomCompleteBloc _requestRoomReviewBloc;
  late RequestRoom requestRoom;
  List<Log> logs = [];
  bool _isLoading = false;
  String _pictPath = "";
  String _pictName = "";

  @override
  void initState() {
    _requestRoomReviewBloc = BlocProvider.of(context);

    _requestRoomReviewBloc.add(RequestRoomCompleteGet(widget.id));

    super.initState();
  }

  void _approveRejectAction(String fileName, String filePath) {
    _requestRoomReviewBloc.add(RequestRoomCompleteSubmit(
        id: requestRoom.id!,
        requestId: requestRoom.requestId!,
        fileName: fileName,
        filePath: filePath));
    Get.back();
    Get.back();
  }

  void _getFile() async {
    setState(() => _isLoading = true);

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      _pictPath = file.path!;
      _pictName = file.name;
    }

    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });
  }

  void _submitAction() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'add_remark_dialog',
      pageBuilder: (context, a1, a2) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Pilih Foto Ruangan Setelah Peminjaman',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                const SizedBox(height: 10),
                _pictPath.isEmpty
                    ? Align(
                        alignment: Alignment.topLeft,
                        child: TextButton(
                          onPressed: _getFile,
                          child: const Text('Pilih'),
                        ),
                      )
                    : Text(
                        _pictName,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _approveRejectAction(_pictName, _pictPath);
                      },
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      transitionBuilder: (context, a1, a2, child) {
        double curve = Curves.elasticInOut.transform(a1.value);

        return Transform.scale(
          scale: curve,
          child: child,
        );
      },
    );
  }

  void _detailRequestRoomListener(
      BuildContext context, RequestRoomCompleteState state) {
    if (state is RequestRoomCompleteLoading) {
      setState(() => _isLoading = true);
    }

    if (state is RequestRoomCompleteGetData ||
        state is RequestRoomCompleteError) {
      setState(() => _isLoading = false);

      if (state is RequestRoomCompleteGetData) {
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

  @override
  Widget build(BuildContext context) {
    return BlocListener<RequestRoomCompleteBloc, RequestRoomCompleteState>(
      listener: _detailRequestRoomListener,
      child: WillPopScope(
        onWillPop: () {
          _requestRoomReviewBloc.add(RequestRoomCompleteFetch());
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
                    ElevatedButton(
                      onPressed: _submitAction,
                      child: const Text('Submit'),
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
