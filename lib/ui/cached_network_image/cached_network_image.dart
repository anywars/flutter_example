import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class CachedNetworkImagePage extends StatefulWidget {
  static final routeName = "/cached_network_image";

  @override
  State createState() => _CachedNetworkImageState();
}

class _CachedNetworkImageState extends State<CachedNetworkImagePage> {
  var crossAxisCount = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cached Network Image"), ),
      body: Container(
        child: GridView.count(
          crossAxisCount: crossAxisCount,
          children: [
            for (var i=0; i<10; i++) ...{
              getView(),
            }
          ],
        ),
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (crossAxisCount == 2)
              crossAxisCount = 1;
            else
              crossAxisCount = 2;
          });
        },
        child: const Icon(Icons.navigation),
      ),
    );
  }


  Widget getView() {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      child: InkWell(
        onTap: () {},
        enableFeedback: true,
        child: CachedNetworkImage(
          imageUrl: "http://via.placeholder.com/350x150",
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}