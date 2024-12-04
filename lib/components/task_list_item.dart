import 'package:flutter/material.dart';
import 'package:procrastinot_prototype/resources/theme.dart';

class TaskListItem extends StatelessWidget {
  final String taskLabel;
  final Function()? onPressed;

  const TaskListItem({super.key, required this.taskLabel, this.onPressed});

  @override
  Widget build(BuildContext context) {

    Widget label;
    if (onPressed == null) {
      label = MyBodyText(text: taskLabel, strikeThrough: true,);
    } else {
      label = MyBodyText(text: taskLabel);
    }

    Row result = Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
            decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0))),
                color: MyTheme.PRIMARY_COLOR_LIGHT),
            padding: const EdgeInsets.all(8),
            child: label,
          ),
        )
      ],
    );

    if (onPressed != null) {
      result.children.add(const SizedBox(
        width: 8,
      ));
      result.children.add(IconButton(
          onPressed: onPressed,
          color: MyTheme.ACCENT_COLOR,
          disabledColor: MyTheme.PRIMARY_COLOR_LIGHT,
          icon: const Icon(
            Icons.check_box,
            size: 50,
          )));
    }

    return result;
  }
}
