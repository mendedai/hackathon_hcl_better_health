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

  @override
  Widget build(BuildContext context) {
    const double kPanelMinHeight = 50.0;

    Widget _getButton({IconData icon, Function onPressed}) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: onPressed,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.8),
              borderRadius: BorderRadius.circular(30),
            ),
            padding: EdgeInsets.all(12),
            child: Icon(
              icon,
              color: Colors.white,
              size: 16,
            ),
          ),
        ),
      );
    }

    Widget getButtons() {
      return Material(
        color: Colors.white.withOpacity(0),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _getButton(
                icon: Icons.thumb_up,
                onPressed: () {},
              ),
              _getButton(
                icon: Icons.thumb_down,
                onPressed: () {},
              ),
              SizedBox(
                height: 30,
              ),
              _getButton(
                icon: Icons.add,
                onPressed: () {},
              ),
              _getButton(
                icon: Icons.remove,
                onPressed: () {},
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SlidingUpPanel(
        backdropEnabled: true,
        parallaxEnabled: true,
        parallaxOffset: 0.2,
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
                right: 0,
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
