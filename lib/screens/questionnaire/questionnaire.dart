import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:hcl_better_health/bot/bot.dart';
import 'package:hcl_better_health/constants.dart';
import 'package:hcl_better_health/screens/therapy/activity/activity.dart';
import 'package:hcl_better_health/screens/therapy/therapy.dart';

class QuestionnaireScreen extends StatefulWidget {
  static final String route = 'questionnaire';

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
      backgroundColor: kLightGrey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: kBlack,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Icon(
          // Icons.chat_bubble_outline,
          Icons.question_answer,
          size: 26,
          color: kBlack,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        bottom: false,
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
                messages: messages,
                onSend: (message) {
                  waitForUserResponse = false;
                  return postMessage(message);
                },
                sendOnEnter: true,
                textInputAction: TextInputAction.send,
                user: user,
                // remove the avatar containers
                avatarBuilder: (user) => Container(),
                // remove the scroll to bottom button
                scrollToBottomWidget: () => Container(),
                messagePadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                messageContainerPadding: EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 2,
                ),
                messageDecorationBuilder: (ChatMessage msg, bool isUser) {
                  return BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft:
                          isUser ? Radius.circular(15) : Radius.circular(3),
                      topRight:
                          isUser ? Radius.circular(3) : Radius.circular(15),
                      bottomRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                    ),
                    color: msg.user.containerColor != null
                        ? msg.user.containerColor
                        : isUser
                            ? Theme.of(context).accentColor
                            : Color.fromRGBO(225, 225, 225, 1),
                  );
                },
                messageTimeBuilder: (time, [message]) {
                  return Container();
                },
                inputToolbarPadding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 16,
                  bottom: 40,
                ),
                inputDecoration: InputDecoration(
                  // icon: null,
                  hintText: "Answer here...",
                  fillColor: kLightGrey,
                  filled: true,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
                inputMaxLines: 5,
                inputTextStyle: TextStyle(fontSize: 14.0),
                inputContainerStyle: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      color: kLightGrey,
                    ),
                  ),
                ),
                dateFormat: DateFormat('yyyy-MMM-dd'),
                timeFormat: DateFormat('HH:mm'),
                scrollToBottom: true,
                quickReplyPadding: EdgeInsets.all(10),
                quickReplyBuilder: (reply) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      border: Border.all(
                          width: 1.0, color: Theme.of(context).accentColor),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Text(
                      reply.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),
                  );
                },
                onQuickReply: (Reply reply) {
                  waitForUserResponse = false;
                  if (_bot.done) {
                    Navigator.pushNamed(context, TherapyScreen.route);
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
