import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/barrel/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateRequestRoomScreen extends StatefulWidget {
  const CreateRequestRoomScreen({Key? key}) : super(key: key);

  @override
  State<CreateRequestRoomScreen> createState() =>
      _CreateRequestRoomScreenState();
}

class _CreateRequestRoomScreenState extends State<CreateRequestRoomScreen> {
  final SharedPreferences pref = App.instance.pref;

  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _activityNameController = TextEditingController();
  final TextEditingController _participantController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey();
  late RequestRoomBloc _requestRoomBloc;
  late RoomBloc _roomBloc;
  late ActivityLevelBloc _activityLevelBloc;
  bool _isLoading = false;
  DateTime? _startDate;
  DateTime? _endDate;
  Room? _selectedRoom;
  ActivityLevel? _selectedActivityLevel;

  @override
  void initState() {
    _requestRoomBloc = BlocProvider.of(context);
    _roomBloc = BlocProvider.of(context);
    _activityLevelBloc = BlocProvider.of(context);

    _roomBloc.add(RoomFetch());
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

      _requestRoomBloc.add(RequestRoomCreate(requestRoom: requestRoom));
    }
  }

  void _draftAction() {
    if (_form.currentState!.validate()) {
      Users user = Users(id: pref.getString('id')!);
      RequestRoomDrafts requestRoom = RequestRoomDrafts(
        startDate: _startDate,
        endDate: _endDate,
        startTime: _startTimeController.text.trim(),
        endTime: _endTimeController.text.trim(),
        activityName: _activityNameController.text.trim(),
        activityLevel: _selectedActivityLevel,
        participant: int.parse(_participantController.text.trim()),
        room: _selectedRoom,
        user: user,
      );

      _requestRoomBloc.add(RequestRoomDraft(requestRoomDraft: requestRoom));
    }
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

  void _requestRoomListener(BuildContext context, RequestRoomState state) {
    if (state is RequestRoomLoading) {
      setState(() => _isLoading = true);
    }

    if (state is RequestRoomSuccess || state is RequestRoomError) {
      setState(() => _isLoading = false);

      if (state is RequestRoomSuccess) {
        Get.back();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RequestRoomBloc, RequestRoomState>(
      listener: _requestRoomListener,
      child: Scaffold(
        appBar: AppBar(title: const Text('Create RequestRoom')),
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
              const SizedBox(height: 20),
              _isLoading
                  ? const Text('')
                  : ElevatedButton(
                      onPressed: _draftAction,
                      child: const Text('Simpan'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
