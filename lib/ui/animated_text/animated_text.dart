import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class AnimatedTextPage extends StatefulWidget {
  static final routeName = "/animated_text";

  @override
  State createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedTextPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Animated Text"),),
      body: SingleChildScrollView(
        child: Column(
          children: [

            _rotate(),

          ],
        ),
      ),
    );
  }


  Widget _rotate() {
    return SizedBox(
      width: 250.0,
      child: DefaultTextStyle(
        style: const TextStyle(
          fontSize: 30.0,
          fontFamily: 'Bobbers',
        ),
        child: AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText('It is not enough to do your best,'),
              TyperAnimatedText('you must know what to do,'),
              TyperAnimatedText('and then do your best'),
              TyperAnimatedText('- W.Edwards Deming'),
            ],
      ),
    ),
    );
  }
}