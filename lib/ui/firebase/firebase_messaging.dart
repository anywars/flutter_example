import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/controller/message_controller.dart';
import 'package:flutter_example/common/analytics.dart';
import 'package:get/get.dart';

class MessageArguments {
  final RemoteMessage? message;
  final bool openedApplication;
  MessageArguments(this.message, this.openedApplication):
        assert(message != null);
}

class MessagingPage extends GetView<MessageController> {
  static final routeName = "/messaging";

  @override
  Widget build(BuildContext context) {
    final message = controller.arguments?.message;
    final notification = message?.notification;

    return Scaffold(
      appBar: AppBar(title: Text("Messaging"),),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              _row('Triggered application open', "${controller.arguments?.openedApplication.toString()}"),
              if (message != null) ...[
                _row('Message ID', message.messageId!),
                _row('Sender ID', message.senderId ?? ''),
                _row('Category', message.category ?? ''),
                _row('Collapse Key', message.collapseKey ?? ''),
                _row('Content Available', message.contentAvailable.toString()),
                _row('Data', message.data.toString()),
                _row('From', message.from ?? ''),
                _row('Message ID', message.messageId ?? ''),
                _row('Sent Time', message.sentTime!.toString()),
                _row('Thread ID', message.threadId ?? ''),
                _row('Time to Live (TTL)', message.ttl.toString())
              ],

              if (notification != null) ...[
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Column(children: [
                    const Text('Remote Notification', style: TextStyle(fontSize: 18),),
                    _row('Title', notification.title ?? '',),
                    _row('Body', notification.body ?? '',)
                  ])
                )
              ],

            ],
          ),
        ),
      ),
    );
  }

  Widget _row(String title, String? value) {
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

}