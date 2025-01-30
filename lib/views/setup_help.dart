import 'package:flutter/material.dart';
import 'package:procrastinot_prototype/components/app_bar.dart';
import 'package:procrastinot_prototype/resources/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class SetupHelp extends StatelessWidget {
  final String _url = "https://www.indeed.com/career-advice/career-development/how-to-write-smart-goals";
  const SetupHelp({super.key});

  Future<void> _launchURL() async {
    try {
      Uri url = Uri.parse(_url);
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: MyAppBar('Info'),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    flex: 1,
                    child: Container(
                        color: MyTheme.FOREGROUND_COLOR,
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: ListView(
                            itemExtentBuilder: (index, _) {
                              if ((index < 2) ||  (9 < index && index < 12)) return 75.0;
                              if (2 < index && index < 9) return 50.0;
                              if (11 < index) return 100.0;
                              return 25.0;
                            },
                            children: const [
                              MyBodyText(
                                  text:
                                      'Consciously setting and pursuing goals helps us achieve things.'),
                              MyBodyText(
                                  text:
                                      'There are many ways to be goal-oriented one of which is following SMART-principles'),
                              Divider(color: MyTheme.PRIMARY_COLOR),
                              MyBodyText(
                                  text:
                                      'SMART is an acronym for ingredients of a well-formulated goal'),
                              MySubtitle(text: 'S pecific'),
                              MySubtitle(text: 'M easurable'),
                              MySubtitle(text: 'A chievable'),
                              MySubtitle(text: 'R relevant'),
                              MySubtitle(text: 'T ime-based'),
                              Divider(color: MyTheme.PRIMARY_COLOR),
                              MyBodyText(
                                  text:
                                      'This application has been designed to help you take small but effective steps towards your studying goals'),
                              MyBodyText(text: 'In practice, when choosing a task consider the following:'),
                              MySubtitle(text: 'What is it that I want to achieve?'),
                              MySubtitle(text: 'Which measurable actions do I need to take?'),
                              MySubtitle(text: 'Do I have the needed resources?'),
                              MySubtitle(text: 'Is completing this task worthwhile?'),
                              MySubtitle(text: 'What can I achieve in the time I have allocated for studying today?'),
                            ],
                          ),
                        ))),
                Container(
                    color: MyTheme.BACKGROUND_COLOR,
                    height: 100.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const MyBodyText(text: 'More about SMART-goals'),
                        IconButton(
                            onPressed: _launchURL,
                            icon: const Icon(
                              Icons.open_in_browser,
                              color: MyTheme.ACCENT_COLOR,
                              size: 50,
                            ))
                      ],
                    ))
              ],
            )));
  }
}
