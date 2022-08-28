import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/models.dart';

class DetailRequestRoomReviewL2Screen extends StatefulWidget {
  final String id;
  final String requestId;
  const DetailRequestRoomReviewL2Screen(
      {Key? key, required this.id, required this.requestId})
      : super(key: key);

  @override
  State<DetailRequestRoomReviewL2Screen> createState() =>
      _DetailRequestRoomReviewL2ScreenState();
}

class _DetailRequestRoomReviewL2ScreenState
    extends State<DetailRequestRoomReviewL2Screen> {
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
  final TextEditingController _remarkController = TextEditingController();
  late RequestRoomReviewL2Bloc _requestRoomReviewL2Bloc;
  late RequestRoom requestRoom;
  List<Log> logs = [];
  bool _isLoading = false;

  @override
  void initState() {
    _requestRoomReviewL2Bloc = BlocProvider.of(context);

    _requestRoomReviewL2Bloc.add(RequestRoomReviewL2Get(widget.id));

    super.initState();
  }

  void _approveRejectAction(bool decision, String? reason) {
    _requestRoomReviewL2Bloc.add(RequestRoomReviewL2Submit(
        id: requestRoom.id!,
        requestId: requestRoom.requestId!,
        decision: decision,
        reason: reason));
    Get.back();
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
                TextFormField(
                  controller: _remarkController,
                  maxLines: 5,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Catatan',
                    hintText: 'Catatan',
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _approveRejectAction(
                            true, _remarkController.text.trim());
                      },
                      child: const Text('Setuju'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      onPressed: () {
                        _approveRejectAction(
                            false, _remarkController.text.trim());
                      },
                      child: const Text('Tolak'),
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
      BuildContext context, RequestRoomReviewL2State state) {
    if (state is RequestRoomReviewL2Loading) {
      setState(() => _isLoading = true);
    }

    if (state is RequestRoomReviewL2GetData ||
        state is RequestRoomReviewL2Error) {
      setState(() => _isLoading = false);

      if (state is RequestRoomReviewL2GetData) {
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
    return BlocListener<RequestRoomReviewL2Bloc, RequestRoomReviewL2State>(
      listener: _detailRequestRoomListener,
      child: WillPopScope(
        onWillPop: () {
          _requestRoomReviewL2Bloc.add(RequestRoomReviewL2Fetch());
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
