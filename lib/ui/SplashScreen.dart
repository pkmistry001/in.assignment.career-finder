import 'package:careerfinder/ui/homepage_screen.dart';
import 'package:careerfinder/ui/login_screen.dart';
import 'package:careerfinder/ui/registration_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => SplashScreenState();

}
class SplashScreenState extends State<SplashScreen> {

  var screenSize;

  @override
  void initState() {
    super.initState();
    pageNavigate();
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Container(
          width: screenSize.width,
          height: screenSize.height,
          child: Icon(Icons.search,color: Colors.white,size: screenSize.height*0.25,),
        ),
      ),
    );
  }

  Future pageNavigate() async {
    await new Future.delayed(const Duration(milliseconds: 3000));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (BuildContext context) => RegistrationScreen()),
    );
  }

}