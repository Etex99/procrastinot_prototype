import 'package:flutter/material.dart';
import 'package:procrastinot_prototype/components/app_bar.dart';
import 'package:procrastinot_prototype/resources/theme.dart';

class SetupHelp extends StatelessWidget {
  const SetupHelp({super.key});

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
                              MySubtitle(text: 'A ttainable'),
                              MySubtitle(text: 'R relevant'),
                              MySubtitle(text: 'T imely'),
                              Divider(color: MyTheme.PRIMARY_COLOR),
                              MyBodyText(
                                  text:
                                      'This application has been designed to help you take small but effective steps towards your studying goals'),
                              MyBodyText(text: 'In practice, before choosing your daily tasks consider the following:'),
                              MySubtitle(text: 'What is my goal? Which grade or level of quality am I satisfied with for my work?'),
                              MySubtitle(text: 'How do I break up my larger projects into digestible tasks?'),
                              MySubtitle(text: 'How much time do I have available? Can someone assist me if I struggle?'),
                              MySubtitle(text: 'What needs to be prioritized right now? Which deadlines are approaching?'),
                              MySubtitle(text: 'How do I ensure continuous progress? What time of day am I most productive?'),
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
                        // TODO: link an external source.
                        IconButton(
                            onPressed: () {},
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
