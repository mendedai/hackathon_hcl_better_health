import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';
import 'package:story_view/controller/story_controller.dart';

// class TherapyActivityView extends StatefulWidget {
//   final List activity;
//   final Function onComplete;
//   final Function onVerticalSwipeComplete;
//   final Function notifierListener;

//   StoryController controller = StoryController();

//   TherapyActivityView({
//     this.activity,
//     this.onComplete,
//     this.onVerticalSwipeComplete,
//     this.notifierListener,
//   });

//   @override
//   _TherapyActivityViewState createState() => _TherapyActivityViewState();
// }

// class _TherapyActivityViewState extends State<TherapyActivityView> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     print('disposed --------------------------');
//     widget.controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     StoryView storyView = StoryView(
//       storyItems: widget.activity.map((step) {
//         StoryItem storyItem;
//         if (step['type'] == 'video') {
//           storyItem = StoryItem.pageVideo(
//             step['url'],
//             caption: step['description'],
//             duration: Duration(seconds: (step['durationSeconds']).toInt()),
//             controller: widget.controller,
//           );
//         } else if (step['type'] == 'image') {
//           storyItem = StoryItem.pageImage(
//             url: step['url'],
//             caption: step['description'],
//             duration: Duration(seconds: (step['durationSeconds']).toInt()),
//             controller: widget.controller,
//           );
//         }
//         return storyItem;
//       }).toList(),
//       controller: widget.controller,
//       onComplete: widget.onComplete,
//       onVerticalSwipeComplete: widget.onVerticalSwipeComplete,
//       onStoryShow: (s) {
//         print('Showing a story $s');
//       },
//     );

//     if (widget.notifierListener != null) {
//       storyView.controller.playbackNotifier.listen(widget.notifierListener);
//     }

//     return storyView;
//   }
// }

class TherapyActivityView extends StatelessWidget {
  final List activity;
  final Function onComplete;
  final Function onVerticalSwipeComplete;
  final Function notifierListener;

  final StoryController controller = StoryController();

  TherapyActivityView({
    this.activity,
    this.onComplete,
    this.onVerticalSwipeComplete,
    this.notifierListener,
  });

  @override
  Widget build(BuildContext context) {
    return StoryView(
      storyItems: activity.map((step) {
        StoryItem storyItem;
        if (step['type'] == 'video') {
          storyItem = StoryItem.pageVideo(
            step['url'],
            caption: step['description'],
            duration: Duration(seconds: (step['durationSeconds']).toInt()),
            controller: controller,
          );
        } else if (step['type'] == 'image') {
          storyItem = StoryItem.pageImage(
            url: step['url'],
            caption: step['description'],
            duration: Duration(seconds: (step['durationSeconds']).toInt()),
            controller: controller,
          );
        }
        return storyItem;
      }).toList(),
      controller: controller,
      onComplete: onComplete,
      onVerticalSwipeComplete: onVerticalSwipeComplete,
      onStoryShow: (s) {
        print('Showing a story $s');
      },
    );

    // if (widget.notifierListener != null) {
    //   storyView.controller.playbackNotifier.listen(widget.notifierListener);
    // }

    // return storyView;
  }
}
