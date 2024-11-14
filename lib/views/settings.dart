import 'package:flutter/material.dart';
import 'package:procrastinot_prototype/components/app_bar.dart';
import 'package:procrastinot_prototype/components/input_fields.dart';
import 'package:procrastinot_prototype/resources/theme.dart';
import 'package:procrastinot_prototype/storage/internal_storage.dart';
import 'package:procrastinot_prototype/util/format.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: MyAppBar('Settings'),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                        color: MyTheme.FOREGROUND_COLOR,
                        child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: SettingsViewForm()))),
                Container(
                    color: MyTheme.BACKGROUND_COLOR,
                    height: 100.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        IconButton(
                            // TODO: onpressed
                            onPressed: () {},
                            icon: const Icon(
                              Icons.save,
                              color: MyTheme.ACCENT_COLOR,
                              size: 50.0,
                            )),
                        const SizedBox(width: 32.0),
                      ],
                    ))
              ],
            )));
  }
}

class SettingsViewForm extends StatefulWidget {
  const SettingsViewForm({super.key});

  @override
  State<SettingsViewForm> createState() => _SettingsViewFormState();
}

class _SettingsViewFormState extends State<SettingsViewForm> {
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

    // TODO: this is retarded, use future builder instead
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
