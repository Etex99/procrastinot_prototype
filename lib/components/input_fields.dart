import 'package:flutter/material.dart';
import 'package:procrastinot_prototype/resources/theme.dart';

//^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$

class SelectTimeField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  const SelectTimeField(
      {super.key,
      required this.labelText,
      required this.hintText,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(flex: 1, child: MyBodyText(text: labelText)),
        Flexible(
          flex: 1,
          child: TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(),
            style: MyTheme.INPUT_TEXT_STYLE,
            cursorColor: MyTheme.ACCENT_COLOR,
            decoration: InputDecoration(
              icon: const Icon(
                Icons.alarm,
                color: MyTheme.PRIMARY_COLOR_LIGHT,
                size: 25.0,
              ),
              hintText: hintText,
              hintStyle: MyTheme.HINT_TEXT_STYLE,
            ),
            // TODO: show error
            onEditingComplete: () {
              RegExpMatch? match = RegExp(r"^([0-1]?[0-9]|2[0-3]).[0-5][0-9]$")
                  .firstMatch(controller.value.text);
              if (match == null) {
                controller.clear();
              }
            },
          ),
        )
      ],
    );
  }
}

class SelectNumberField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  const SelectNumberField(
      {super.key,
      required this.labelText,
      required this.hintText,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(flex: 1, child: MyBodyText(text: labelText)),
        Flexible(
            flex: 1,
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              style: MyTheme.INPUT_TEXT_STYLE,
              cursorColor: MyTheme.ACCENT_COLOR,
              decoration: InputDecoration(
                icon: const Icon(
                  Icons.onetwothree,
                  color: MyTheme.PRIMARY_COLOR_LIGHT,
                  size: 25.0,
                ),
                hintText: hintText,
                hintStyle: MyTheme.HINT_TEXT_STYLE,
              ),
            ))
      ],
    );
  }
}

class EnterStringField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;

  const EnterStringField(
      {super.key,
      required this.labelText,
      required this.hintText,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(flex: 1, child: MyBodyText(text: labelText)),
        Expanded(
            flex: 3,
            child: TextField(
              controller: controller,
              textAlignVertical: TextAlignVertical.bottom,
              maxLength: 80,
              maxLines: null,
              minLines: null,
              expands: true,
              keyboardType: TextInputType.text,
              style: MyTheme.INPUT_TEXT_STYLE,
              cursorColor: MyTheme.ACCENT_COLOR,
              decoration: InputDecoration(
                icon: const Icon(
                  Icons.notes,
                  color: MyTheme.PRIMARY_COLOR_LIGHT,
                  size: 25.0,
                ),
                hintText: hintText,
                hintStyle: MyTheme.HINT_TEXT_STYLE,
              ),
            )),
      ],
    );
  }
}
