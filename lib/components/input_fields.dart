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
        MyBodyText(text: labelText),
        Row(
          children: [
            SizedBox(
              width: 150.0,
              height: 50.0,
              child: TextField(
                controller: controller,
                keyboardType: const TextInputType.numberWithOptions(),
                style: MyTheme.BODY_TEXT_STYLE,
                cursorColor: MyTheme.ACCENT_COLOR,
                decoration: InputDecoration(
                  icon: const Icon(
                    Icons.alarm,
                    color: MyTheme.ACCENT_COLOR,
                    size: 25.0,
                  ),
                  hintText: hintText,
                  hintStyle: MyTheme.INFO_TEXT_STYLE,
                ),
                // TODO: show error
                onEditingComplete: () {
                  RegExpMatch? match =
                      RegExp(r"^([0-1]?[0-9]|2[0-3]).[0-5][0-9]$")
                          .firstMatch(controller.value.text);
                  if (match == null) {
                    controller.clear();
                  }
                },
              ),
            ),
            const Spacer(flex: 1)
          ],
        ),
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
        MyBodyText(text: labelText),
        Row(
          children: [
            SizedBox(
                width: 100.0,
                height: 50.0,
                child: TextField(
                  controller: controller,
                  keyboardType: TextInputType.number,
                  style: MyTheme.BODY_TEXT_STYLE,
                  cursorColor: MyTheme.ACCENT_COLOR,
                  decoration: InputDecoration(
                    icon: const Icon(
                      Icons.onetwothree,
                      color: MyTheme.ACCENT_COLOR,
                      size: 25.0,
                    ),
                    hintText: hintText,
                    hintStyle: MyTheme.INFO_TEXT_STYLE,
                  ),
                )),
            const Spacer(flex: 1)
          ],
        ),
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
        MyBodyText(text: labelText),
        Row(
          children: [
            SizedBox(
                width: 300.0,
                height: 50.0,
                child: TextField(
                  controller: controller,
                  maxLines: 1,
                  maxLength: 100,
                  keyboardType: TextInputType.text,
                  style: MyTheme.BODY_TEXT_STYLE,
                  cursorColor: MyTheme.ACCENT_COLOR,
                  decoration: InputDecoration(
                    icon: const Icon(
                      Icons.notes,
                      color: MyTheme.ACCENT_COLOR,
                      size: 25.0,
                    ),
                    hintText: hintText,
                    hintStyle: MyTheme.INFO_TEXT_STYLE,
                  ),
                )),
            const Spacer(flex: 1)
          ],
        ),
      ],
    );
  }
}
