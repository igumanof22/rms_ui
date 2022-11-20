import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/barrel/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateRequestRoomModifyScreen extends StatefulWidget {
  const CreateRequestRoomModifyScreen({Key? key}) : super(key: key);

  @override
  State<CreateRequestRoomModifyScreen> createState() =>
      _CreateRequestRoomModifyScreenState();
}

class _CreateRequestRoomModifyScreenState
    extends State<CreateRequestRoomModifyScreen> {
  final SharedPreferences pref = App.instance.pref;

  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _activityNameController = TextEditingController();
  final TextEditingController _activityLevelController =
      TextEditingController();
  final TextEditingController _participantController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey();
  late RequestRoomModifyBloc _requestRoomBloc;
  late RoomBloc _roomBloc;
  late ActivityLevelBloc _activityLevelBloc;
  bool _isLoading = false;
  DateTime? _startDate;
  DateTime? _endDate;
  Room? _selectedRoom;
  ActivityLevel? _selectedActivityLevel;
  String _pictName = "";
  String _pictPath = "";

  @override
  void initState() {
    _requestRoomBloc = BlocProvider.of(context);
    _roomBloc = BlocProvider.of(context);
    _activityLevelBloc = BlocProvider.of(context);

    _roomBloc.add(RoomFetch(roomId: ''));
    _activityLevelBloc.add(ActivityLevelFetch());

    super.initState();
  }

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    _activityNameController.dispose();
    _activityLevelController.dispose();
    _participantController.dispose();

    super.dispose();
  }

  void _submitAction() {
    if (_form.currentState!.validate()) {
      Users user = Users(id: pref.getString('id')!);
      RequestRoom requestRoom = RequestRoom(
        startDate: _startDate!,
        endDate: _endDate!,
        startTime: _startTimeController.text.trim(),
        endTime: _endTimeController.text.trim(),
        activityName: _activityNameController.text.trim(),
        activityLevel: _selectedActivityLevel!,
        participant: int.parse(_participantController.text.trim()),
        room: _selectedRoom!,
        user: user,
      );

      _requestRoomBloc.add(RequestRoomModifySubmit(
          requestRoom: requestRoom, pictName: _pictName, pictPath: _pictPath));
    }
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

  void _showStartDatePickerAction() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      DateFormat format = DateFormat('dd MMMM y');
      _startDate = date;
      _startDateController.text = format.format(date);
    }
  }

  void _showEndDatePickerAction() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      DateFormat format = DateFormat('dd MMMM y');
      _endDate = date;
      _endDateController.text = format.format(date);
    }
  }

  void _requestRoomListener(
      BuildContext context, RequestRoomModifyState state) {
    if (state is RequestRoomModifyLoading) {
      setState(() => _isLoading = true);
    }

    if (state is RequestRoomModifyCreateSuccess ||
        state is RequestRoomModifyError) {
      setState(() => _isLoading = false);

      if (state is RequestRoomModifyCreateSuccess) {
        Get.back();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RequestRoomModifyBloc, RequestRoomModifyState>(
      listener: _requestRoomListener,
      child: Scaffold(
        appBar: AppBar(title: const Text('Create RequestRoomModify')),
        body: Form(
          key: _form,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            children: [
              BlocBuilder<RoomBloc, RoomState>(
                builder: (context, state) {
                  if (state is RoomInitialized) {
                    return DropdownButton<Room>(
                      isExpanded: true,
                      value: _selectedRoom,
                      items: state.listRoom
                          .map((e) => DropdownMenuItem<Room>(
                                value: e,
                                child: Text(e.roomId),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedRoom = value!;
                        });
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              TextFormField(
                controller: _activityNameController,
                validator: ValidationBuilder().required().build(),
                decoration: const InputDecoration(
                  hintText: 'Judul Acara',
                ),
                readOnly: _isLoading,
              ),
              BlocBuilder<ActivityLevelBloc, ActivityLevelState>(
                builder: (context, state) {
                  if (state is ActivityLevelInitialized) {
                    return DropdownButton<ActivityLevel>(
                      isExpanded: true,
                      value: _selectedActivityLevel,
                      items: state.listActivityLevel
                          .map((e) => DropdownMenuItem<ActivityLevel>(
                                value: e,
                                child: Text(e.nama),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedActivityLevel = value!;
                        });
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              TextFormField(
                controller: _startDateController,
                onTap: _isLoading ? null : _showStartDatePickerAction,
                validator: ValidationBuilder().required().build(),
                decoration: const InputDecoration(
                  hintText: 'Tanggal Mulai Acara',
                ),
                readOnly: true,
              ),
              TextFormField(
                controller: _endDateController,
                onTap: _isLoading ? null : _showEndDatePickerAction,
                validator: ValidationBuilder().required().build(),
                decoration: const InputDecoration(
                  hintText: 'Tanggal Akhir Acara',
                ),
                readOnly: true,
              ),
              TextFormField(
                controller: _startTimeController,
                decoration: const InputDecoration(
                  hintText: 'Jam Mulai Acara (HH:mm)',
                ),
                readOnly: _isLoading,
              ),
              TextFormField(
                controller: _endTimeController,
                validator: ValidationBuilder().required().build(),
                decoration: const InputDecoration(
                  hintText: 'Jam Selesai Acara (HH:mm)',
                ),
                readOnly: _isLoading,
              ),
              const SizedBox(height: 20),
              Text(
                'Pilih Foto Ruangan Sebelum Peminjaman',
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
              const SizedBox(height: 50),
              _isLoading
                  ? Wrap(
                      alignment: WrapAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                      ],
                    )
                  : ElevatedButton(
                      onPressed: _submitAction,
                      child: const Text('Submit'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
