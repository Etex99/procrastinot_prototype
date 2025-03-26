import 'dart:math';
import 'package:flutter/material.dart';
import 'package:procrastinot_prototype/resources/theme.dart';
import 'package:procrastinot_prototype/storage/internal_storage.dart';

class Peers extends StatefulWidget {
  const Peers ({super.key});

  @override
  State<Peers> createState() => _PeersState();
}

class _PeersState extends State<Peers> {
  int mockValue = -1;

  @override
  void initState() {
    InternalStorageHandler ish = InternalStorageHandler();
    ish.getLastMock().then((time) => {
      if (DateTime.now().difference(time) > const Duration(hours: 1)) {
        ish.getMockPeopleCount().then((count) => setState(() {
          mockValue = _mockPeopleCount(count);
        }))
      } else {
        ish.getMockPeopleCount().then((count) => setState(() {
          mockValue = count;
        }))
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if (mockValue == -1) {
      return const SizedBox.shrink();
    }
  
    MySubtitle completions;
    MySubtitle situationalMessage = const MySubtitle(text: 'Join the numbers and complete a study session today!');
    if (mockValue == 0) {
      completions = const MySubtitle(text: 'No peers have completed a study session.');
      situationalMessage = const MySubtitle(text: 'Be the first one today!');
    } else if (mockValue == 1) {
      completions = const MySubtitle(text: 'One peer has completed a study session.');
    } else {
      completions = MySubtitle(text: '$mockValue peers have completed a study session.');
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        completions,
        const SizedBox(height: 50),
        situationalMessage
      ],
    );
  }

  int _mockPeopleCount(int lastVal) {
    int newCount = lastVal;
    int hour = TimeOfDay.now().hour;
    
    if (hour <= 8) {
      newCount += Random().nextInt(2);
    } else if (hour <= 16) {
      newCount += Random().nextInt(4);
    } else if (hour <= 24) {
      newCount += Random().nextInt(8);
    }

    InternalStorageHandler ish = InternalStorageHandler();
    ish.setMockPeopleCount(newCount);
    ish.setLastMock(DateTime.timestamp());

    return newCount;
  }
}