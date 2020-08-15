import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:story_view/story_view.dart';

import 'activity_view.dart';

enum MediaType { image, video, text }

class TherapyActivityScreen extends StatefulWidget {
  static String route = '/activity';

  @override
  _TherapyActivityScreenState createState() => _TherapyActivityScreenState();
}

class _TherapyActivityScreenState extends State<TherapyActivityScreen> {
  final _firestore = Firestore.instance;

  Future<List> getMovements() async {
    final data = await _firestore.collection('movements').getDocuments();
    return data.documents.toList();
  }

  String getNextMovement(movementId) {
    final next = {
      'foam-0': 'short-arc-quad-0',
      'foam-1': 'short-arc-quad-0',
      'foam-2': 'short-arc-quad-0',
    };
    return next[movementId];
  }

  String getMovementModification(movementId, difficultyAdjustment) {
    final adjustments = {
      'foam-0': {
        'easier': null,
        'harder': 'foam-1',
      },
      'foam-1': {
        'easier': 'foam-0',
        'harder': 'foam-2',
      },
      'foam-2': {
        'easier': 'foam-1',
        'harder': null,
      },
      'short-arc-quad-0': {
        'easier': 'towel-squeeze-0',
        'harder': null,
      },
      'towel-squeeze-0': {
        'easier': null,
        'harder': 'short-arc-quad-0',
      },
    };

    return adjustments[movementId][difficultyAdjustment];
  }

  String description = '''
Step 1 - Get foam roller
Step 2 - Set foam roller on the ground with the tailbone near one end and your head resting on the other.  Your spine should be pressing into the roam roller. Legs should be bent and shoulder width apart. Arms should be resting comfortably by your side
Step 3 - engage abdominal muscles and hold for 2 minutes while maintaining a neutral spine.

Easier Modification - take your feet and extend them further away from you while keeping them firmly planted on the ground.

Harder Modification - Bring your hands up off the floor and bring your feet closer together until they are touching.

Foam Roller balance v2 - Bring your feet together until they are touching.  Take your hands and rest them on your chest.  Close your eyes.  Hold for 2 minutes while engaging your abdomen.
  ''';

  PageController _pageControllerNextExercise = PageController();
  PageController _pageControllerDifficultAdjust = PageController();
  String _currentMovementId = 'foam-1';

  Widget getActivityView() {
    return PageView.builder(
      controller: _pageControllerNextExercise,
      itemBuilder: (context, index) {
        return PageView.builder(
          controller: _pageControllerDifficultAdjust,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List docs = snapshot.data;
                  DocumentSnapshot doc = docs.firstWhere((doc) {
                    return doc.documentID == _currentMovementId;
                  });

                  print('new story ${doc.data['story']}');
                  List story = doc.data['story'];

                  return TherapyActivityView(
                    activity: story,
                    onComplete: () {
                      final String nextMovementId =
                          getNextMovement(_currentMovementId);

                      print('onCompletre nextMovementId $nextMovementId');
                      if (nextMovementId != null) {
                        setState(() {
                          _currentMovementId = nextMovementId;
                          _pageControllerNextExercise.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        });
                      }
                    },
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
          },
        );
      },
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
              // _getButton(
              //   icon: Icons.thumb_up,
              //   onPressed: () {},
              // ),
              // _getButton(
              //   icon: Icons.thumb_down,
              //   onPressed: () {},
              // ),
              SizedBox(
                height: 30,
              ),
              _getButton(
                icon: Icons.add,
                onPressed: () {
                  String nextMovementId =
                      getMovementModification(_currentMovementId, 'harder');

                  print('Harder nextMovementId $nextMovementId');

                  if (nextMovementId != null) {
                    setState(() {
                      _currentMovementId = nextMovementId;
                      _pageControllerDifficultAdjust.nextPage(
                        duration: Duration(
                          milliseconds: 350,
                        ),
                        curve: Curves.ease,
                      );
                    });
                  }
                },
              ),
              _getButton(
                icon: Icons.remove,
                onPressed: () {
                  String nextMovementId =
                      getMovementModification(_currentMovementId, 'easier');

                  print('Easier nextMovementId $nextMovementId');

                  if (nextMovementId != null) {
                    setState(() {
                      _currentMovementId = nextMovementId;
                      _pageControllerDifficultAdjust.nextPage(
                        duration: Duration(
                          milliseconds: 350,
                        ),
                        curve: Curves.ease,
                      );
                    });
                  }
                },
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
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(description),
              ),
            ),
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
