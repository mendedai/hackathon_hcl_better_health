import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class TherapyActivityController extends StatefulWidget {
  final List activities;

  TherapyActivityController({this.activities});

  @override
  _TherapyActivityControllerState createState() =>
      _TherapyActivityControllerState();
}

class _TherapyActivityControllerState extends State<TherapyActivityController> {
  final StoryController controller = StoryController();
  List<StoryItem> storyItems = [];

  @override
  void initState() {
    super.initState();
    widget.activities.forEach((activity) {
      print(activity);
      storyItems.add(StoryItem.pageVideo(
        activity['media'],
        caption: activity['description'],
        duration: Duration(
          milliseconds: (activity['duration'] * 1000).toInt(),
        ),
        controller: controller,
      ));
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoryView(
      storyItems: storyItems,
      controller: controller,
      onComplete: () {
        print('Story completed');
      },
      onVerticalSwipeComplete: (v) {
        print('onVerticalSwipeComplete $v');
        if (v == Direction.down) {
          print('onVerticalSwipeComplete v == Direction.down');
        }
      },
      onStoryShow: (s) {
        print('Showing a story $s');
      },
    );
  }
}
