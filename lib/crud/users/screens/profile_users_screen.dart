import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:rms_ui/barrel/blocs.dart';
import 'package:rms_ui/barrel/models.dart';
import 'package:rms_ui/services/app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileUsersScreen extends StatefulWidget {
  const ProfileUsersScreen({Key? key}) : super(key: key);

  @override
  State<ProfileUsersScreen> createState() => _ProfileUsersScreenState();
}

class _ProfileUsersScreenState extends State<ProfileUsersScreen> {
  final SharedPreferences pref = App.instance.pref;
  final TextEditingController _leaderController = TextEditingController();
  final TextEditingController _secretaryController = TextEditingController();
  final GlobalKey<FormState> _form = GlobalKey();
  late UsersBloc _usersBloc;
  bool _isLoading = false;
  String _logoPath = "";
  String _logoName = "";
  String _leaderSignaturePath = "";
  String _leaderSignatureName = "";
  String _secretarySignaturePath = "";
  String _secretarySignatureName = "";

  @override
  void initState() {
    _usersBloc = BlocProvider.of(context);
    _usersBloc.add(UsersGet(id: pref.getString('id')!));

    super.initState();
  }

  @override
  void dispose() {
    _leaderController.dispose();
    _secretaryController.dispose();

    super.dispose();
  }

  void _submitAction() {
    if (_form.currentState!.validate()) {
      UsersProfileModel profile = UsersProfileModel(
        logoPath: _logoPath,
        logoName: _logoName,
        leaderSignaturePath: _leaderSignaturePath,
        leaderSignatureName: _leaderSignatureName,
        secretarySignaturePath: _secretarySignaturePath,
        secretarySignatureName: _secretarySignatureName,
        leader: _leaderController.text..trim(),
        secretary: _secretaryController.text.trim(),
      );

      _usersBloc
          .add(UsersProfile(id: pref.getString('id')!, profileModel: profile));
    }
  }

  void _usersListener(BuildContext context, UsersState state) {
    if (state is UsersLoading) {
      setState(() => _isLoading = true);
    }

    if (state is UsersSuccess || state is UsersError) {
      setState(() => _isLoading = false);

      if (state is UsersSuccess) {
        Get.back();
      }
    }
    if (state is UsersGetData) {
      setState(() => _isLoading = false);
    }
  }

  void _getLogo() async {
    setState(() => _isLoading = true);

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      _logoPath = file.path!;
      _logoName = file.name;
    }

    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });
  }

  void _getLeaderSignature() async {
    setState(() => _isLoading = true);

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      _leaderSignaturePath = file.path!;
      _leaderSignatureName = file.name;
    }

    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });
  }

  void _getSecretarySignature() async {
    setState(() => _isLoading = true);

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      _secretarySignaturePath = file.path!;
      _secretarySignatureName = file.name;
    }

    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UsersBloc, UsersState>(
      listener: _usersListener,
      child: Scaffold(
        appBar: AppBar(title: const Text('Profil Akun')),
        body: Form(
          key: _form,
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              TextFormField(
                controller: _leaderController,
                validator: ValidationBuilder().required().build(),
                decoration: const InputDecoration(
                  hintText: 'Nama Ketua UKM / Nama Asli',
                ),
                readOnly: _isLoading,
              ),
              TextFormField(
                controller: _secretaryController,
                validator: ValidationBuilder().required().build(),
                decoration: const InputDecoration(
                  hintText: 'Nama Sekretaris UKM',
                ),
                readOnly: _isLoading,
              ),
              const SizedBox(height: 13),
              Text(
                'Pilih Foto Logo',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(height: 10),
              _logoName.isEmpty && _logoPath.isEmpty
                  ? Align(
                      alignment: Alignment.topLeft,
                      child: TextButton(
                        onPressed: _getLogo,
                        child: const Text('Pilih'),
                      ),
                    )
                  : Text(_logoName,
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
              const SizedBox(height: 15),
              Text(
                'Pilih Foto Tanda Tangan Ketua atau Pribadi',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(height: 10),
              _leaderSignatureName.isEmpty && _leaderSignaturePath.isEmpty
                  ? Align(
                      alignment: Alignment.topLeft,
                      child: TextButton(
                        onPressed: _getLeaderSignature,
                        child: const Text('Pilih'),
                      ),
                    )
                  : Text(_leaderSignatureName,
                style: Theme.of(context).textTheme.subtitle2,),
              const SizedBox(height: 15),
              Text(
                'Pilih Foto Tanda Tangan Sekretaris',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(height: 10),
              _secretarySignatureName.isEmpty && _secretarySignaturePath.isEmpty
                  ? Align(
                      alignment: Alignment.topLeft,
                      child: TextButton(
                        onPressed: _getSecretarySignature,
                        child: const Text('Pilih'),
                      ),
                    )
                  : Text(_secretarySignatureName,
                style: Theme.of(context).textTheme.subtitle2,),
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
