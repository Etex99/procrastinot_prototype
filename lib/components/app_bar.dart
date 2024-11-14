import 'package:flutter/material.dart';
import 'package:procrastinot_prototype/resources/theme.dart';

class MyAppBar extends AppBar {
  MyAppBar(String text, {super.key}):super(
    iconTheme: const IconThemeData(
      color: MyTheme.ACCENT_COLOR,
      size: 50.0
    ),
    backgroundColor: MyTheme.BACKGROUND_COLOR,
    title: MyTitle(text: text),
    centerTitle: true,
    elevation: 0.0,
    toolbarHeight: 100.0,
    automaticallyImplyLeading: true,
    actions: <Widget>[]
  );
}