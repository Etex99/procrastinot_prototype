import 'package:flutter/material.dart';
import 'package:procrastinot_prototype/components/input_fields.dart';
import 'package:procrastinot_prototype/data/session.dart';
import 'package:procrastinot_prototype/resources/theme.dart';
import 'package:procrastinot_prototype/storage/internal_storage.dart';
import 'package:procrastinot_prototype/util/format.dart';

class SetupForm extends StatefulWidget {

  final Session _formValues = Session();
  final Function(Session s) formValuesChanged;

  SetupForm({super.key, required this.formValuesChanged});

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

  @override
  void dispose() {
    super.dispose();
    studyDurationC.dispose();
    breakDurationC.dispose();
    numberBreaksC.dispose();
    task1C.dispose();
    task2C.dispose();
    task3C.dispose();
  }

  void _initTextControllers() async {
    InternalStorageHandler i = InternalStorageHandler();
    Duration studyDur = await i.getDefaultStudyDuration();
    Duration breakDur = await i.getDefaultBreakDuration();
    int numberB = await i.getDefaultNumberOfBreaks();

    widget._formValues.targetDuration = studyDur;
    widget._formValues.breakDuration = breakDur;
    widget._formValues.allowedBreaks = numberB;
    widget.formValuesChanged(widget._formValues);

    studyDurationC = TextEditingController(
        text: MyFormatter.durationToString(studyDur));
    breakDurationC = TextEditingController(
        text: MyFormatter.durationToString(breakDur));
    numberBreaksC = TextEditingController(
        text: (numberB.toString()));

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      itemExtentBuilder: (index, _) {
        if ((index == 0) | (index == 5)) return 50;
        if (index == 4) return 25;
        if (1 < index && index < 4) return 100;
        return 125;
      },
      children: [
        const Align(
            alignment: Alignment.centerLeft,
            child: MySubtitle(text: 'Duration')),
        SelectTimeField(
          labelText: 'Study duration:',
          hintText: '3.00',
          controller: studyDurationC,
          valueChanged: (String s) {
            widget._formValues.targetDuration = MyFormatter.stringToDuration(s);
            widget.formValuesChanged(widget._formValues);
          },
        ),
        SelectTimeField(
          labelText: 'Break duration:',
          hintText: '0.15',
          controller: breakDurationC,
          valueChanged: (String s) {
            widget._formValues.breakDuration = MyFormatter.stringToDuration(s);
            widget.formValuesChanged(widget._formValues);
          },
        ),
        SelectNumberField(
            labelText: 'Number of breaks:',
            hintText: '1',
            controller: numberBreaksC,
            valueChanged: (String s) {
              widget._formValues.allowedBreaks = int.parse(s);
              widget.formValuesChanged(widget._formValues);
            },
        ),
        const Divider(color: MyTheme.PRIMARY_COLOR),
        const Align(
            alignment: Alignment.centerLeft,
            child: MySubtitle(text: 'Priority tasks')),
        EnterStringField(
          labelText: '#1',
          hintText: 'Email course assistant X for help on a difficult task.',
          controller: task1C,
          valueChanged: (String s) {
            widget._formValues.tasks![0] = s;
            widget.formValuesChanged(widget._formValues);
          },
        ),
        EnterStringField(
          labelText: '#2',
          hintText: 'Course Y: Complete weekly study task.',
          controller: task2C,
          valueChanged: (String s) {
            widget._formValues.tasks![1] = s;
            widget.formValuesChanged(widget._formValues);
          },
        ),
        EnterStringField(
          labelText: '#3',
          hintText: 'Course Z: study and take notes of lecture 3.',
          controller: task3C,
          valueChanged: (String s) {
            widget._formValues.tasks![2] = s;
            widget.formValuesChanged(widget._formValues);
          },
        )
      ],
    );
  }
}
