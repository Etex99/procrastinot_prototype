import 'package:flutter/material.dart';
import 'package:procrastinot_prototype/resources/theme.dart';

class TaskListItem extends StatefulWidget {
  final String taskLabel;
  final bool done;
  final Function onPressed;

  const TaskListItem({super.key, required this.taskLabel, required this.done, required this.onPressed});

  @override
  State<TaskListItem> createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  bool _done = false;

  @override
  void initState() {
    super.initState();
    _done = widget.done;
  }

  @override
  Widget build(BuildContext context) {

    Widget label;
    if (!_done) {
      label = MyBodyText(text: widget.taskLabel);
    } else {
      label = MyBodyText(text: widget.taskLabel, strikeThrough: true,);
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

    if (!_done) {
      result.children.add(const SizedBox(
        width: 8,
      ));
      result.children.add(IconButton(
          onPressed: () {
            _done = true;
            widget.onPressed();
            _update();
          },
          color: MyTheme.ACCENT_COLOR,
          disabledColor: MyTheme.PRIMARY_COLOR_LIGHT,
          icon: const Icon(
            Icons.check_box,
            size: 50,
          )));
    }
    return result;
  }

  void _update() => setState((){});
}
