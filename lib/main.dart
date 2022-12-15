import 'package:flutter/material.dart';
import 'package:the_way_smart_people_talk/global.dart';
import 'package:the_way_smart_people_talk/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GlobalAppProfile.init()
      .then((value) => runApp(const TheWaySmartPeopleTalk()));
}

class TheWaySmartPeopleTalk extends StatelessWidget {
  const TheWaySmartPeopleTalk({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Way Smart People Talk',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
