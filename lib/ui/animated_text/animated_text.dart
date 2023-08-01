import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/controller/animated_text_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedTextPage extends GetView<AnimatedTextController> {
  static final routeName = "/animated_text";

  @override
  Widget build(BuildContext context) {
    final _widgets = <Widget>[_typewriter(), _typer(), _combination(), _flicker(), _wavyText(), _textLiquidFill(), _colorize(), _scale(), _fade(), _rotate()];
    return Scaffold(
      appBar: AppBar(title: Text("Animated Text"),),
      body: GridView.count(
        crossAxisCount: 2,
        // scrollDirection: Axis.horizontal,
        children: [

          for (var i=0; i<_widgets.length; i++) ...{
            Container(
              decoration: BoxDecoration(color: Colors.orange[800],),
              height: 300.0,
              width: 300.0,
              child: Center(
                key: ValueKey("rotate"),
                child: _widgets[i],
              ),
            ),
          }

        ],
      ),
    );
  }

  Widget _rotate() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(width: 20.0, height: 100.0, ),
        const Text('Be', style: TextStyle(fontSize: 43.0),),
        const SizedBox(width: 20.0, height: 100.0, ),
        DefaultTextStyle(
          style: TextStyle(fontSize: 40.0, fontFamily: 'Horizon', ),
          child: AnimatedTextKit(
            animatedTexts: [
              RotateAnimatedText('AWESOME'),
              RotateAnimatedText('OPTIMISTIC'),
              RotateAnimatedText(
                'DIFFERENT',
                textStyle: const TextStyle(
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
            // onTap: onTap,
            isRepeatingAnimation: true,
            totalRepeatCount: 10,
          ),
        ),
      ],
    );
  }

  Widget _fade() {
    return DefaultTextStyle(
      style: const TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
      ),
      child: AnimatedTextKit(
        animatedTexts: [
          FadeAnimatedText('do IT!'),
          FadeAnimatedText('do it RIGHT!!'),
          FadeAnimatedText('do it RIGHT NOW!!!'),
        ],
        // onTap: onTap,
      ),
    );
  }

  Widget _typer() {
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
    // onTap: onTap,
    ),
    ),
    );
  }

  Widget _typewriter() {
    return SizedBox(
      width: 250.0,
      child: DefaultTextStyle(
        style: GoogleFonts.dancingScript(fontSize: 30),
        child: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText('Discipline is the best tool'),
            TypewriterAnimatedText('Design first, then code', cursor: '|'),
            TypewriterAnimatedText('Do not patch bugs out, rewrite them',
                cursor: '<|>'),
            TypewriterAnimatedText('Do not test bugs out, design them out',
                cursor: '💡'),
          ],
          // onTap: onTap,
        ),
      ),
    );
  }

  Widget _scale() {
    return DefaultTextStyle(
      style: const TextStyle(
        fontSize: 70.0,
        fontFamily: 'Canterbury',
      ),
      child: AnimatedTextKit(
        animatedTexts: [
          ScaleAnimatedText('Think'),
          ScaleAnimatedText('Build'),
          ScaleAnimatedText('Ship'),
        ],
        // onTap: onTap,
      ),
    );
  }

  final _colorizeTextStyle = TextStyle(
    fontSize: 50.0,
    fontFamily: 'Horizon',
  );
  final _colorizeColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];
  Widget _colorize() {
    return AnimatedTextKit(
      animatedTexts: [
        ColorizeAnimatedText(
          'Larry Page',
          textStyle: _colorizeTextStyle,
          colors: _colorizeColors,
        ),
        ColorizeAnimatedText(
          'Bill Gates',
          textStyle: _colorizeTextStyle,
          colors: _colorizeColors,
        ),
        ColorizeAnimatedText(
          'Steve Jobs',
          textStyle: _colorizeTextStyle,
          colors: _colorizeColors,
        ),
      ],
      // onTap: onTap,
    );
  }

  Widget _textLiquidFill() {
    return TextLiquidFill(
      text: 'LIQUIDY',
      loadDuration: Duration(seconds: 3),
      waveColor: Colors.blueAccent,
      boxBackgroundColor: Colors.redAccent,
      textStyle: const TextStyle(
        fontSize: 70,
        fontWeight: FontWeight.bold,
      ),
      boxHeight: 300,
    );
  }

  Widget _wavyText() {
    return DefaultTextStyle(
        style: const TextStyle(
        fontSize: 20.0,
      ),
      child: AnimatedTextKit(
        animatedTexts: [
          WavyAnimatedText(
            'Hello World',
            textStyle: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          WavyAnimatedText('Look at the waves'),
          WavyAnimatedText('They look so Amazing'),
        ],
      )
    );
  }

  Widget _flicker() {
    return DefaultTextStyle(
      style: const TextStyle(
        fontSize: 35,
        color: Colors.white,
        shadows: [
          Shadow(
            blurRadius: 7.0,
            color: Colors.white,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: AnimatedTextKit(
        repeatForever: true,
        animatedTexts: [
          FlickerAnimatedText('Flicker Frenzy'),
          FlickerAnimatedText('Night Vibes On'),
          FlickerAnimatedText("C'est La Vie !"),
        ],
        // onTap: onTap,
      ),
    );
  }

  Widget _combination() {
    return AnimatedTextKit(
      // onTap: onTap,
      animatedTexts: [
        WavyAnimatedText(
          'On Your Marks',
          textStyle: GoogleFonts.sourceCodePro(fontSize: 28, ),
        ),
        FadeAnimatedText(
          'Get Set',
          textStyle: GoogleFonts.staatliches(fontSize: 32, fontWeight: FontWeight.bold)
        ),
        ScaleAnimatedText(
          'Ready',
          textStyle: GoogleFonts.dancingScript(fontSize: 48, fontWeight: FontWeight.bold)
        ),
        RotateAnimatedText(
          'Go!',
          textStyle: const TextStyle(
            fontSize: 64.0,
          ),
          rotateOut: false,
          duration: const Duration(milliseconds: 400),
        )
      ],
    );
  }


}