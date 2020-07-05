import 'dart:async';
import 'dart:developer' as dev;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:hcl_better_health/bot/bot.dart';
import 'package:hcl_better_health/screens/therapy/activity/activity.dart';

class QuestionnaireScreen extends StatefulWidget {
  static final String route = '/questionnaire';

  @override
  _QuestionnaireScreenState createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  final _firestore = Firestore.instance;
  final _auth = FirebaseAuth.instance;
  final _bot = Bot();

  final GlobalKey<DashChatState> _chatViewKey = GlobalKey<DashChatState>();

  ChatUser user;
  bool waitForUserResponse = false;

  List<ChatMessage> messages = List<ChatMessage>();
  var m = List<ChatMessage>();

  var i = 0;

  void getCurrentUser() async {
    final _user = await _auth.currentUser();
    if (_user != null) {
      user = ChatUser(
        name: _user.displayName,
        uid: _user.uid,
      );
    }
  }

  void converse() async {
    if (!waitForUserResponse && !_bot.done) {
      var line = await _bot.getNextLine();
      // setup waitForUserResponse for the next iteration
      if (line != null && line['type'] == 'text') {
        waitForUserResponse = false;
      } else {
        waitForUserResponse = true;
      }

      print('_bot.currentLineNumber ${_bot.currentLineNumber}');
      Timer(Duration(milliseconds: 600), () {
        ChatMessage msg = _bot.convertToChatMessage(line);
        postMessage(msg);
      });
    }
  }

  void scrollConversation() {
    Timer(Duration(milliseconds: 300), () {
      _chatViewKey.currentState.scrollController
        ..animateTo(
          _chatViewKey.currentState.scrollController.position.maxScrollExtent,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 300),
        );
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  Future<void> postMessage(ChatMessage message) async {
    var key = DateTime.now().millisecondsSinceEpoch.toString();
    print('sending new message "${message.text}" at $key');
    var documentReference = _firestore.collection('messages').document(key);

    await Firestore.instance.runTransaction((transaction) async {
      await transaction.set(
        documentReference,
        message.toJson(),
      );
    });

    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: _firestore.collection('messages').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
              );
            } else {
              converse();
              scrollConversation();

              List<DocumentSnapshot> items = snapshot.data.documents;
              var messages =
                  items.map((i) => ChatMessage.fromJson(i.data)).toList();
              return DashChat(
                key: _chatViewKey,
                inverted: false,
                onSend: (message) {
                  waitForUserResponse = false;
                  return postMessage(message);
                },
                sendOnEnter: true,
                textInputAction: TextInputAction.send,
                user: user,
                inputDecoration:
                    InputDecoration.collapsed(hintText: "Add message here..."),
                dateFormat: DateFormat('yyyy-MMM-dd'),
                timeFormat: DateFormat('HH:mm'),
                messages: messages,
                showUserAvatar: false,
                showAvatarForEveryMessage: false,
                scrollToBottom: true,
                onPressAvatar: (ChatUser user) {
                  print("OnPressAvatar: ${user.name}");
                },
                onLongPressAvatar: (ChatUser user) {
                  print("OnLongPressAvatar: ${user.name}");
                },
                inputMaxLines: 5,
                messageContainerPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                alwaysShowSend: true,
                inputTextStyle: TextStyle(fontSize: 16.0),
                inputContainerStyle: BoxDecoration(
                  border: Border.all(width: 0.0),
                  color: Colors.white,
                ),
                // quickReplyBuilder: (reply) {
                //   dev.debugger();
                //   return Container();
                // },
                onQuickReply: (Reply reply) {
                  waitForUserResponse = false;
                  if (_bot.done) {
                    Navigator.pushNamed(context, TherapyActivityScreen.route);
                  } else {
                    setState(() {
                      postMessage(
                        ChatMessage(
                          text: reply.value,
                          createdAt: DateTime.now(),
                          user: user,
                        ),
                      );
                    });
                  }
                },
                onLoadEarlier: () {
                  print("loading...");
                },
                shouldShowLoadEarlier: false,
                showTraillingBeforeSend: true,
              );
            }
          },
        ),
      ),
    );
  }
}
