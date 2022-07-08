import 'package:flutter/material.dart';

void main() {
  runApp(Application());
}

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application>
    with SingleTickerProviderStateMixin {
  var maxSlide = 225.0;
  var childRadius = 0.0;
  late AnimationController animationController =
      AnimationController(vsync: this, duration: Duration(milliseconds: 1000));

  void toggle() {
    if (animationController.isDismissed) {
      childRadius = 30;
      animationController.forward();
    } else {
      animationController.reverse().whenComplete(() => childRadius = 0.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GestureDetector(
          onTap: toggle,
          child: AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              var slide = animationController.value * maxSlide;
              var scale = 1 - (animationController.value * 0.3);
              return Stack(
                children: [
                  myDrawer(),
                  Transform(
                      alignment: Alignment.centerLeft,
                      transform: Matrix4.identity()
                        ..translate(slide)
                        ..scale(scale),
                      child: myChild()),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget myDrawer() {
    return Container(
      color: Colors.blueAccent[700],
      child: Row(
        children: [
          Flexible(
            flex: 55,
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Text(
                    "Omid Header",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(),
                  ListTile(
                    title: Text(
                      "home",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text(
                      "plan",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "shop",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "news",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "logout",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Exit",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(onPressed: () {}, child: Text('subscribe'))
                ],
              ),
            ),
          ),
          Flexible(
            flex: 45,
            child: Container(),
          ),
        ],
      ),
    );
  }

  Widget myChild() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(childRadius)),
          boxShadow: const [BoxShadow(blurRadius: 30.0, color: Colors.black)]),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(childRadius)),
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  toggle();
                },
                icon: const Icon(Icons.view_headline)),
          ),
          body: Container(
            decoration: const BoxDecoration(
              boxShadow: [BoxShadow(blurRadius: 30.0, color: Colors.black)],
              gradient: LinearGradient(
                colors: [
                  Colors.blueAccent,
                  Colors.redAccent,
                ],
                begin: Alignment.topLeft,
              ),
            ),
            child: Center(
              child: Text(
                "omid test app",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
