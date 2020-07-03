import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hcl_better_health/screens/therapy/activity/activity_controller.dart';

enum MediaType { image, video, text }

class TherapyActivityScreen extends StatelessWidget {
  static String route = '/activity';

  final _firestore = Firestore.instance;

  Future<void> getMovements() async {
    final data = await _firestore.collection('movements').getDocuments();
    List media = data.documents.map((e) {
      final media = e['media'];
      return {
        'description': media['description'],
        'media': media['url'],
        'duration': media['durationSeconds'],
        'mediaType': media['type'],
        'color': media['color'],
      };
    }).toList();
    // for (var movement in data.documents) {
    //   print(movement.data);
    // }
    return media;
  }

  Future<List> getMedia(context) async {
    String raw =
        await DefaultAssetBundle.of(context).loadString('assets/media.json');

    await getMovements();

    var data = json.decode(raw);
    List media = data[0]['scenes'].map((it) {
      return {
        'description': it['description'],
        'media': it['media'],
        'duration': it['duration'],
        'mediaType': MediaType.video,
        'color': it['color'],
      };
    }).toList();
    return media;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return TherapyActivityController(
                activities: snapshot.data,
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
        ),
      ),
    );
  }
}
