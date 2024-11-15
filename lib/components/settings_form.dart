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
  TextEditingController notificationTimeC = TextEditingController();
  TextEditingController studyTimeC = TextEditingController();
  TextEditingController breakTimeC = TextEditingController();
  TextEditingController numberBreaksC = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initTextControllers();
  }

  void _initTextControllers() async {
    InternalStorageHandler i = InternalStorageHandler();
    notificationTimeC = TextEditingController(
        text: MyFormatter.timeOfDayToString(await i.getNotificationTime()));
    studyTimeC = TextEditingController(
        text: MyFormatter.durationToString(await i.getDefaultStudyDuration()));
    breakTimeC = TextEditingController(
        text: MyFormatter.durationToString(await i.getDefaultBreakDuration()));
    numberBreaksC = TextEditingController(
        text: (await i.getDefaultNumberOfBreaks()).toString());

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Column selectDays = const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyBodyText(text: 'On the following weekdays:'),
        Row(
          children: [
            SizedBox(width: 25.0, height: 25.0, child: Placeholder()),
            Spacer(flex: 1),
            SizedBox(width: 25.0, height: 25.0, child: Placeholder()),
            Spacer(flex: 1),
            SizedBox(width: 25.0, height: 25.0, child: Placeholder()),
            Spacer(flex: 1),
            SizedBox(width: 25.0, height: 25.0, child: Placeholder()),
            Spacer(flex: 1),
            SizedBox(width: 25.0, height: 25.0, child: Placeholder()),
            Spacer(flex: 1),
            SizedBox(width: 25.0, height: 25.0, child: Placeholder()),
            Spacer(flex: 1),
            SizedBox(width: 25.0, height: 25.0, child: Placeholder())
          ],
        ),
      ],
    );

    return ListView(
      itemExtent: 100.0,
      children: [
        const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            MySubtitle(text: 'Reminders'),
            Spacer(flex: 1),
            SizedBox(width: 50.0, height: 50.0, child: Placeholder()),
          ],
        ),
        SelectTimeField(
          labelText: 'Remind me to study at:',
          hintText: '16.00',
          controller: notificationTimeC,
        ),
        selectDays,
        const Align(
            alignment: Alignment.centerLeft,
            child: MySubtitle(text: 'Defaults')),
        SelectTimeField(
            labelText: 'Study session duration:',
            hintText: '3.00',
            controller: studyTimeC),
        SelectTimeField(
            labelText: 'Study break duration:',
            hintText: '0.15',
            controller: breakTimeC),
        SelectNumberField(
            labelText: 'Number of breaks:',
            hintText: '1',
            controller: numberBreaksC)
      ],
    );
  }
}