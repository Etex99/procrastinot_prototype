import 'package:flutter/material.dart';
import 'package:procrastinot_prototype/components/app_bar.dart';
import 'package:procrastinot_prototype/components/below_keyboard.dart';
import 'package:procrastinot_prototype/components/setup_form.dart';
import 'package:procrastinot_prototype/data/session.dart';
import 'package:procrastinot_prototype/resources/theme.dart';
import 'package:procrastinot_prototype/views/all.dart';

class SessionSetupView extends StatefulWidget {
  const SessionSetupView({super.key});

  @override
  State<SessionSetupView> createState() => _SessionSetupViewState();
}

class _SessionSetupViewState extends State<SessionSetupView> {
  late SetupForm form;
  Session _session = Session();
  bool isFormValid = false;

  @override
  void initState() {
    super.initState();
    form = SetupForm(formValuesChanged: setSessionValues);
  }

  // Yes, this is lazy. First time Flutter and in a hurry.
  void setSessionValues(Session updated) {
    debugPrint('here');
    _session = updated;
    bool b = _session.isValid();
    if (isFormValid != b) setState(() {isFormValid = b;});
  }

  @override
  Widget build(BuildContext context) {

    MyAppBar appBar = MyAppBar('Session Setup');
    IconButton help = IconButton(icon: const Icon(Icons.help), onPressed: () => Navigator.pushNamed(context, '/help'),);
    appBar.actions!.add(help);

    // Return with confirm button if all required fields have value
    if (isFormValid) {
      return SafeArea(
          child: Scaffold(
              appBar: appBar,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                        color: MyTheme.FOREGROUND_COLOR,
                        child: Padding(
                            padding: const EdgeInsets.all(32.0), child: form)),
                  ),
                  BelowKeyboard(
                    child: Container(
                        color: MyTheme.BACKGROUND_COLOR,
                        height: 100.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            const Spacer(flex: 1),
                            IconButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/session',
                                      arguments: SessionViewArgs(_session));
                                },
                                icon: const Icon(
                                  Icons.check_box,
                                  color: MyTheme.ACCENT_COLOR,
                                  size: 50.0,
                                )),
                            const SizedBox(width: 32.0)
                          ],
                        )),
                  )
                ],
              )));
    } else {
      // Return without confirm button if some required fields are empty
      return SafeArea(
          child: Scaffold(
              appBar: appBar,
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                        color: MyTheme.FOREGROUND_COLOR,
                        child: Padding(
                            padding: const EdgeInsets.all(32.0), child: form)),
                  ),
                ],
              )));
    }
  }
}
