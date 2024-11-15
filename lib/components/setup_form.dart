import 'package:flutter/material.dart';
import 'package:procrastinot_prototype/components/input_fields.dart';
import 'package:procrastinot_prototype/resources/theme.dart';
import 'package:procrastinot_prototype/storage/internal_storage.dart';
import 'package:procrastinot_prototype/util/format.dart';

class SetupForm extends StatefulWidget {
  const SetupForm({super.key});

  @override
  State<SetupForm> createState() => _SetupFormState();
}

class _SetupFormState extends State<SetupForm> {
  TextEditingController studyDurationC = TextEditingController();
  TextEditingController breakDurationC = TextEditingController();
  TextEditingController numberBreaksC = TextEditingController();
  TextEditingController task1C = TextEditingController();
  TextEditingController task2C = TextEditingController();
  TextEditingController task3C = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initTextControllers();
  }

  void _initTextControllers() async {
    InternalStorageHandler i = InternalStorageHandler();
    studyDurationC = TextEditingController(
        text: MyFormatter.durationToString(await i.getDefaultStudyDuration()));
    breakDurationC = TextEditingController(
        text: MyFormatter.durationToString(await i.getDefaultBreakDuration()));
    numberBreaksC = TextEditingController(
        text: (await i.getDefaultNumberOfBreaks()).toString());

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      itemExtentBuilder: (index, _) {
        if (index <= 4) {
          return 100;
        } else {
          return 150;
        }
      },
      children: [
        const Align(
            alignment: Alignment.centerLeft,
            child: MySubtitle(text: 'Duration')),
        SelectTimeField(
          labelText: 'Study duration:',
          hintText: '3.00',
          controller: studyDurationC,
        ),
        SelectTimeField(
          labelText: 'Break duration:',
          hintText: '0.15',
          controller: breakDurationC,
        ),
        SelectNumberField(
            labelText: 'Number of breaks:',
            hintText: '1',
            controller: numberBreaksC),
        const Align(
            alignment: Alignment.centerLeft,
            child: MySubtitle(text: 'Priority tasks')),
        EnterStringField(
          labelText: '#1',
          hintText: 'Email course assistant X for help on a difficult task.',
          controller: task1C,
        ),
        EnterStringField(
            labelText: '#2',
            hintText: 'Course Y: Complete weekly study task.',
            controller: task2C),
        EnterStringField(
            labelText: '#3',
            hintText: 'Course Z: study and take notes of lecture 3.',
            controller: task3C)
      ],
    );
  }
}
