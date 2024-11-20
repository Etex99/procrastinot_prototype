import 'package:flutter/material.dart';
import 'package:procrastinot_prototype/resources/theme.dart';
import 'package:procrastinot_prototype/storage/internal_storage.dart';

class SelectTimeField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final String savePropertyName;

  const SelectTimeField(
      {super.key,
      required this.labelText,
      required this.hintText,
      required this.controller,
      this.savePropertyName = ''});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(flex: 1, child: MyBodyText(text: labelText)),
          Flexible(
            flex: 1,
            child: TextFormField(
                controller: controller,
                validator: (String? s) {
                  if (s == null) return null;

                  RegExpMatch? match =
                      RegExp(r"^([0-1]?[0-9]|2[0-3]).[0-5][0-9]$")
                          .firstMatch(s);
                  if (match == null) {
                    controller.clear();
                    return 'Enter a valid time in \'hh.mm\' format.';
                  }
                  if (savePropertyName != '') {
                    InternalStorageHandler
                        .tempSettingsFormValues[savePropertyName] = s;
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUnfocus,
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
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: MyTheme.ACCENT_COLOR)),
                  errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: MyTheme.PRIMARY_COLOR)),
                  disabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: MyTheme.PRIMARY_COLOR_LIGHT)),
                  focusedErrorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                )),
          ),
        ]);
  }
}

class SelectNumberField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final String savePropertyName;
  const SelectNumberField(
      {super.key,
      required this.labelText,
      required this.hintText,
      required this.controller,
      this.savePropertyName = ''});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(flex: 1, child: MyBodyText(text: labelText)),
        Flexible(
            flex: 1,
            child: TextFormField(
              controller: controller,
              validator: (String? s) {
                if (s == null) return null;

                RegExpMatch? match = RegExp(r"^([0-9]|10)$").firstMatch(s);
                if (match == null) {
                  controller.clear();
                  return 'Enter a number in the range 0-10.';
                }
                if (savePropertyName != '') {
                  InternalStorageHandler
                      .tempSettingsFormValues[savePropertyName] = s;
                }
                return null;
              },
              autovalidateMode: AutovalidateMode.onUnfocus,
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
                errorStyle: MyTheme.ERROR_TEXT_STYLE,
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: MyTheme.ACCENT_COLOR)),
                errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: MyTheme.PRIMARY_COLOR)),
                disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: MyTheme.PRIMARY_COLOR_LIGHT)),
                focusedErrorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)),
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
        Flexible(
            flex: 3,
            child: TextFormField(
              controller: controller,
              textAlignVertical: TextAlignVertical.bottom,
              maxLength: 80,
              maxLines: 2,
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
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: MyTheme.ACCENT_COLOR)),
                errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: MyTheme.PRIMARY_COLOR)),
                disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: MyTheme.PRIMARY_COLOR_LIGHT)),
                focusedErrorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red)),
              ),
            )),
      ],
    );
  }
}
