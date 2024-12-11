import 'package:flutter/material.dart';
import 'package:procrastinot_prototype/resources/theme.dart';

class ProcrastinationSuggestion extends StatelessWidget {
  const ProcrastinationSuggestion({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      itemExtentBuilder: (index, _) {
        if (index == 0) return 150;
        if (index == 1) return 25;
        return 100;
      },
      children: const [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MyTheme.IDEA,
            Spacer(),
            MyBodyText(
                text:
                    'There are many causes to procrastination. Many of which we can control!')
          ],
        ),
        Divider(),
        Center(
          child: MySubtitle(text: "Suggestion")
        ),
        MyBodyText(
          text:
            "Focus on external factors that contributed to your procrastination today. What could you do to minimize these distractors in the future? You can write down your thoughts in a diary."),
        MyBodyText(
          text:
            "For example: \"I was distracted by a notification coming from a social media app which caused me to waste time scrolling. I should mute these apps when I'm studying\".")
      ],
    );
  }
}

class OutOfTimeSuggestion extends StatelessWidget {
  const OutOfTimeSuggestion({super.key});
  
  @override
  Widget build(BuildContext context) {
    return ListView(
      itemExtentBuilder: (index, _) {
        if (index == 0) return 150;
        if (index == 1) return 25;
        return 100;
      },
      children: const [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MyTheme.IDEA,
            Spacer(),
            MyBodyText(
                text:
                    'It can be challenging to make an efficient study plan. Time-management is a skill that takes practice!')
          ],
        ),
        Divider(),
        Center(
          child: MySubtitle(text: "Suggestion")
        ),
        MyBodyText(
          text:
            "Consider one of the tasks that you planned but couldn't complete. Should it be broken down into smaller tasks? You can use mind-maps or other suitable thinking methods to make sense of large concepts."),
        MyBodyText(
          text:
            "It is also smart to benefit from the community around you. Collaborating with classmates on common tasks can ease the effort for everyone. You can also make use of course assistants when you feel stuck.")
      ],
    );
  }
}