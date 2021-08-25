import 'package:careerfinder/ui/SplashScreen.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /*SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
    ));*/
    return MaterialApp(
      title: 'career-finder',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

