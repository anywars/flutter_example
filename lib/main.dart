import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_example/ui/google/google_maps.dart';
import 'package:flutter_example/ui/google/google_sign_in.dart';
import 'package:flutter_example/ui/image_picker/image_picker.dart';
import 'package:flutter_example/ui/local_auth/local_auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        ImagePickerPage.routeName: (context) => ImagePickerPage(),
        SignInPage.routeName: (context) => SignInPage(),
      },
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _examples = [ImagePickerPage.routeName, SignInPage.routeName, MapsPage.routeName, LocalAuthPage.routeName];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: _examples.length,
        itemBuilder: (context, position) {
          return OpenContainer(
            transitionType: ContainerTransitionType.fade,
            closedBuilder: (_, open) {
              return Card(child: getRow(position),);
            },
            openBuilder: (_, open) {
              var example = _examples[position];
              if (example == ImagePickerPage.routeName) {
                return ImagePickerPage();
              }

              else if (example == MapsPage.routeName) {
                return MapsPage();
              }

              else if (example == LocalAuthPage.routeName) {
                return LocalAuthPage();
              }

              else {
                return SignInPage();
              }
            });
        },
      ),

    );
  }

  Widget getRow(int i) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Text(_examples[i]),
      ),
    );
  }
}
