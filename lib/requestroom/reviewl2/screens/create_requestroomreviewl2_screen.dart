import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/models.dart';

class CreateRequestRoomReviewL2Screen extends StatefulWidget {
  const CreateRequestRoomReviewL2Screen({Key? key}) : super(key: key);

  @override
  State<CreateRequestRoomReviewL2Screen> createState() =>
      _CreateRequestRoomReviewL2ScreenState();
}

class _CreateRequestRoomReviewL2ScreenState
    extends State<CreateRequestRoomReviewL2Screen> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _activityNameController = TextEditingController();
  final TextEditingController _activityLevelController =
      TextEditingController();
  final TextEditingController _roomController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey();
  late RequestRoomReviewL2Bloc _requestRoomBloc;
  bool _isLoading = false;
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    _requestRoomBloc = BlocProvider.of(context);

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
    _roomController.dispose();

    super.dispose();
  }

  void _submitAction() {
    if (_form.currentState!.validate()) {
      RequestRoom requestRoom = RequestRoom(
        startDate: _startDate!,
        endDate: _endDate!,
        startTime: _startTimeController.text.trim(),
        endTime: _endTimeController.text.trim(),
        activityName: _activityNameController.text.trim(),
        activityLevel: _activityLevelController.text.trim(),
      );

      _requestRoomBloc.add(RequestRoomReviewL2Create(requestRoom: requestRoom));
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

  void _requestRoomListener(
      BuildContext context, RequestRoomReviewL2State state) {
    if (state is RequestRoomReviewL2Loading) {
      setState(() => _isLoading = true);
    }

    if (state is RequestRoomReviewL2CreateSuccess ||
        state is RequestRoomReviewL2Error) {
      setState(() => _isLoading = false);

      if (state is RequestRoomReviewL2CreateSuccess) {
        Get.back();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RequestRoomReviewL2Bloc, RequestRoomReviewL2State>(
      listener: _requestRoomListener,
      child: Scaffold(
        appBar: AppBar(title: const Text('Create RequestRoomReviewL2')),
        body: Form(
          key: _form,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            children: [
              TextFormField(
                controller: _activityNameController,
                validator: ValidationBuilder().required().build(),
                decoration: const InputDecoration(
                  hintText: 'Judul Acara',
                ),
                readOnly: _isLoading,
              ),
              TextFormField(
                controller: _activityLevelController,
                validator: ValidationBuilder().required().build(),
                decoration: const InputDecoration(
                  hintText: 'Tingkat Acara (Internal, Jurusan, dll)',
                ),
                readOnly: _isLoading,
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
            ],
          ),
        ),
      ),
    );
  }
}
