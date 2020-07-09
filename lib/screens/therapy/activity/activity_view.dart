import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';
import 'package:story_view/controller/story_controller.dart';

class TherapyActivityView extends StatefulWidget {
  final List activities;

  TherapyActivityView({this.activities});

  @override
  _TherapyActivityViewState createState() => _TherapyActivityViewState();
}

class _TherapyActivityViewState extends State<TherapyActivityView> {
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
    StoryView storyView = StoryView(
      storyItems: storyItems,
      controller: controller,
      onComplete: () {
        print('Story completed');
      },
      onVerticalSwipeComplete: (v, storyItem) {
        print('onVerticalSwipeComplete $v');
        if (v == Direction.down) {
          print('onVerticalSwipeComplete v == Direction.down');
        }

        if (v == Direction.up) {
          print('onVerticalSwipeComplete v == Direction.up');
        }
      },
      onStoryShow: (s) {
        print('Showing a story $s');
      },
    );

    storyView.controller.playbackNotifier.listen((PlaybackState val) {
      if (val == PlaybackState.pause) {
        // TODO open information screens
        print('playback paused');
      } else if (val == PlaybackState.play) {
        // TODO close information screens
        print('playback playing');
      }
    });

    return storyView;
  }
}
