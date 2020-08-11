import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:hcl_better_health/constants.dart';

class QuestListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 200.0,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 20),
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return QuestCard(cardHeight: 200);
              },
            ),
          )
        ],
      ),
    );
  }
}

class QuestCard extends StatelessWidget {
  final double cardHeight;

  const QuestCard({@required this.cardHeight});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Container(
        width: 140,
        height: cardHeight,
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                height: 5,
                child: LinearProgressIndicator(
                  value: 0.35, // percent filled
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black38),
                  backgroundColor: Colors.black12,
                ),
              ),
            )
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: <Widget>[
            //     // Padding(
            //     //   padding: const EdgeInsets.symmetric(vertical: 8.0),
            //     //   child: Icon(Icons.ac_unit),
            //     // ),
            //     // SizedBox(
            //     //   height: 20.0,
            //     // ),
            //     Text(
            //       'Complete 3 exercises',
            //       style: TextStyle(
            //         fontSize: 16.0,
            //       ),
            //     ),
            //   ],
            // ),
            // Column(
            //   children: <Widget>[
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: <Widget>[
            //         Text(
            //           'Next',
            //           style: TextStyle(
            //             fontSize: 10.0,
            //           ),
            //         ),
            //         Text(
            //           'Thur @ 7pm',
            //           style: TextStyle(
            //             fontSize: 10.0,
            //           ),
            //         ),
            //       ],
            //     ),
            //     SizedBox(
            //       height: 5.0,
            //     ),
            //     Row(
            //       children: <Widget>[
            //         Container(
            //           decoration: BoxDecoration(
            //             border: Border.all(
            //               color: Colors.black,
            //             ),
            //             borderRadius: BorderRadius.all(Radius.circular(3.0)),
            //           ),
            //           padding: EdgeInsets.symmetric(
            //             vertical: 3.0,
            //             horizontal: 8.0,
            //           ),
            //           child: Text(
            //             'Heal',
            //             style: TextStyle(
            //               fontSize: 10.0,
            //             ),
            //           ),
            //         )
            //       ],
            //     )
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
