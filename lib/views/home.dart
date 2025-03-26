import 'package:flutter/material.dart';
import 'package:procrastinot_prototype/components/peers.dart';
import 'package:procrastinot_prototype/resources/theme.dart';
import 'package:procrastinot_prototype/components/app_bar.dart';

class HomeView extends StatelessWidget {

  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar('Procrastinot'),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: Container(color: MyTheme.FOREGROUND_COLOR,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Peers(),
                      MyElevatedButton(text: 'Start a study session!', onPressed: () => Navigator.pushNamed(context, '/setup'))
                    ],
                  )
                )
              ),
            ),
            Container(color: MyTheme.BACKGROUND_COLOR, height: 100.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(width: 32.0),
                  IconButton(
                    onPressed: () => Navigator.pushNamed(context, '/settings'), 
                    icon: const Icon(Icons.settings, color: MyTheme.ACCENT_COLOR, size: 50.0,)
                  ),
                ],
              )
            )
          ],
        )
      )
    );
    
  }
}