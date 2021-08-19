import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/ext/analytics.dart';

class MessageArguments {
  final RemoteMessage? message;
  final bool openedApplication;
  MessageArguments(this.message, this.openedApplication):
        assert(message != null);
}

class MessagingPage extends StatefulWidget {
  static final routeName = "/messaging";

  @override
  State createState() => _MessageState();
}

class _MessageState extends State<MessagingPage> {

  Widget row(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Row(
        children: [
          Text("$title:"),
          Text(value ?? "N/A"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as MessageArguments?;
    final message = args?.message;
    final notification = message?.notification;
    Analytics.instance.logEvent("screen_message");

    return Scaffold(
      appBar: AppBar(title: Text("Messaging"),),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              row('Triggered application open', "${args?.openedApplication.toString()}"),
              if (message != null) ...[
                row('Message ID', message.messageId!),
                row('Sender ID', message.senderId ?? ''),
                row('Category', message.category ?? ''),
                row('Collapse Key', message.collapseKey ?? ''),
                row('Content Available', message.contentAvailable.toString()),
                row('Data', message.data.toString()),
                row('From', message.from ?? ''),
                row('Message ID', message.messageId ?? ''),
                row('Sent Time', message.sentTime!.toString()),
                row('Thread ID', message.threadId ?? ''),
                row('Time to Live (TTL)', message.ttl.toString())
              ],

              if (notification != null) ...[
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(children: [
                    const Text('Remote Notification', style: TextStyle(fontSize: 18),),
                    row('Title', notification.title ?? '',),
                    row('Body', notification.body ?? '',)
                  ])
                )
              ],

            ],
          ),
        ),
      ),
    );
  }


}