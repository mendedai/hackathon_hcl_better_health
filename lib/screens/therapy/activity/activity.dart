import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:story_view/controller/story_controller.dart';

import 'activity_view.dart';

enum MediaType { image, video, text }

class TherapyActivityScreen extends StatelessWidget {
  static String route = '/activity';

  final _firestore = Firestore.instance;

  Future<void> getMovements() async {
    // TODO need to update this to get multiple all stories for the therapy session
    final cobra = await _firestore
        .collection('movements')
        .document('AXXta6jreoBnIrXeCqqT')
        .get();

    List story = cobra.data['story'].toList();
    return story;
  }

  Widget getActivityView() {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return TherapyActivityView(
            activity: snapshot.data,
            onComplete: () {
              print('go to next activity');
            },
            onVerticalSwipeComplete: (v, storyItem) {
              // TODO expose the swipe events so that the info screen can be pulled in as the user swipes up/down
              // or maybe ignore this and overlay a separate widget on top that captures swipe events
              print('onVerticalSwipeComplete $v');
            },
            // notifierListener: (PlaybackState val) {
            //   if (val == PlaybackState.pause) {
            //     // TODO open information screens
            //     print('playback paused... open information screens');
            //   } else if (val == PlaybackState.play) {
            //     // TODO close information screens
            //     print('playback playing... close information screens');
            //   }
            // },
          );
        }

        if (snapshot.hasError) {
          print('${snapshot.error}');
        }

        return Center(
          child: SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(),
          ),
        );
      },
      future: getMovements(),
    );
  }

  Widget getButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 0.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FlatButton(
            padding: null,
            onPressed: () {
              print('sucks button');
            },
            child: CircleAvatar(
              backgroundColor: Colors.lightBlueAccent,
              radius: 30.0,
              child: Icon(
                Icons.thumb_down,
                color: Colors.white,
              ),
            ),
          ),
          FlatButton(
            onPressed: () {
              print('like button');
            },
            child: CircleAvatar(
              backgroundColor: Colors.lightBlueAccent,
              radius: 30.0,
              child: Icon(
                Icons.thumb_up,
                color: Colors.white,
              ),
            ),
          ),
          FlatButton(
            onPressed: () {
              print('make easier button');
            },
            child: CircleAvatar(
              backgroundColor: Colors.lightBlueAccent,
              radius: 30.0,
              child: Icon(
                Icons.do_not_disturb_on,
                color: Colors.white,
              ),
            ),
          ),
          FlatButton(
            onPressed: () {
              print('make harder button');
            },
            child: CircleAvatar(
              backgroundColor: Colors.lightBlueAccent,
              radius: 30.0,
              child: Icon(
                Icons.add_circle,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const double kPanelMinHeight = 50.0;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SlidingUpPanel(
        backdropEnabled: true,
        minHeight: kPanelMinHeight,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        panel: Column(children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Container(
                width: 30,
                height: 5,
                decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
              ),
            ),
          ),
          Center(
            child: Text("This is the sliding Widget"),
          ),
        ]),
        body: Padding(
          padding: const EdgeInsets.only(bottom: kPanelMinHeight),
          child: Stack(
            children: [
              getActivityView(),
              Positioned(
                bottom: 0,
                child: Container(
                  // color: Colors.red,
                  child: getButtons(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
