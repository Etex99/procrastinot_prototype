import 'package:flutter/material.dart';
import 'package:procrastinot_prototype/components/input_fields.dart';
import 'package:procrastinot_prototype/resources/theme.dart';
import 'package:procrastinot_prototype/storage/internal_storage.dart';
import 'package:procrastinot_prototype/util/format.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  bool valuesFetched = false;
  TextEditingController studyTimeC = TextEditingController();
  TextEditingController breakTimeC = TextEditingController();
  TextEditingController numberBreaksC = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initTextControllers();
  }

  @override
  void dispose() {
    super.dispose();
    studyTimeC.dispose();
    breakTimeC.dispose();
    numberBreaksC.dispose();
  }

  void _initTextControllers() async {
    InternalStorageHandler i = InternalStorageHandler();
    studyTimeC = TextEditingController(
        text: MyFormatter.durationToString(await i.getDefaultStudyDuration()));
    breakTimeC = TextEditingController(
        text: MyFormatter.durationToString(await i.getDefaultBreakDuration()));
    numberBreaksC = TextEditingController(
        text: (await i.getDefaultNumberOfBreaks()).toString());

    setState(() { valuesFetched = true; });
  }

  @override
  Widget build(BuildContext context) {
    if (!valuesFetched) {
      return const Center(child: MyBodyText(text: "Loading..."));
    }

    return ListView(
      itemExtent: 100,
      children: [
        const Align(
            alignment: Alignment.centerLeft,
            child: MySubtitle(text: 'Defaults')),
        SelectTimeField(
            labelText: 'Study session duration:',
            hintText: '3.00',
            controller: studyTimeC,
          valueChanged: (String s) => InternalStorageHandler.tempSettingsFormValues[InternalStorageHandler.DEFAULT_STUDY_DURATION] = s,),
        SelectTimeField(
            labelText: 'Study break duration:',
            hintText: '0.15',
            controller: breakTimeC,
          valueChanged: (String s) => InternalStorageHandler.tempSettingsFormValues[InternalStorageHandler.DEFAULT_BREAK_DURATION] = s,),
        SelectNumberField(
            labelText: 'Number of breaks:',
            hintText: '1',
            controller: numberBreaksC,
          valueChanged: (String s) => InternalStorageHandler.tempSettingsFormValues[InternalStorageHandler.DEFAULT_NUMBER_OF_BREAKS] = s,),
      ],
    );
  }
}