import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/services.dart';

class Bot {
  static const String name = 'Em';

  final Firestore _firestore = Firestore.instance;
  final ChatUser _bot = ChatUser(
    uid: 'embot',
    name: Bot.name,
    firstName: Bot.name,
  );

  String currentKey;
  Map dialogue;
  int currentLineNumber = 1;
  bool done = false;

  Future<void> loadDialogue() async {
    if (dialogue == null) {
      var json = await rootBundle.loadString('assets/dialogues/initial.json');
      dialogue = jsonDecode(json);
    }
  }

  ChatMessage convertToChatMessage(line) {
    var quickReplies;
    if (line['type'] == 'choice') {
      quickReplies = QuickReplies.fromJson(line['choices']);
    }
    return ChatMessage(
      user: _bot,
      text: line['content'],
      quickReplies: quickReplies,
    );
  }

  Future getNextLine() async {
    if (done) return null;

    String nextKey;

    await loadDialogue();
    if (currentKey == null)
      nextKey = dialogue['startAt'];
    else {
      nextKey = dialogue['lines'][currentKey]['next'];
    }

    var line = dialogue['lines'][nextKey];
    currentKey = nextKey;
    currentLineNumber++;

    if (line['end'] != null) {
      done = line['end'];
    }

    print('getNextLine = $line');
    return line;
  }
}
