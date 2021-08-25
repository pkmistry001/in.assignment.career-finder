import 'package:careerfinder/bloc/login_bloc.dart';
import 'package:careerfinder/event/login_event.dart';
import 'package:careerfinder/state/login_state.dart';
import 'package:careerfinder/ui/registration_screen.dart';
import 'package:careerfinder/utils/toast_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'homepage_screen.dart';
// import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  var screenSize;
  int? selectedRadio;
  bool loadingProgress = false;
  var loginData = new Map<String, dynamic>();
  final formGlobalKey = GlobalKey <FormState>();
  static LoginState? initialState = LoadingState();
  LoginBloc _loginBloc = LoginBloc(initialState!);

  @override
  void initState() {
    super.initState();
    selectedRadio = 1;
  }

  @override
  void dispose() {
    super.dispose();
  }

  setSelectedRadio(var val) {
    setState(() {
      selectedRadio = val;
      print("selected radio $selectedRadio");
    });
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery
        .of(context)
        .size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: ModalProgressHUD(
          child: Container(
            child: BlocListener<LoginBloc, LoginState>(
              bloc: _loginBloc,
              listener: (context, state) {
                setState(() {
                  loadingProgress = true;
                });
                if (state is LoginSuccess) {
                  setState(() {
                    loadingProgress = false;
                  });
                  if (state.response!.staus != null && state.response!.staus =="true") {
                    navigateToHomePage();
                  }else{
                    showErrorToast(state.response!.message);
                  }
                }

                if (state is LoginFailure) {
                  setState(() {
                    loadingProgress = false;
                  });
                  showErrorToast("Something went wrong");
                }
              },
              child: buildScreen(),
              listenWhen: (previous, current) {
                print(previous.toString());
                print(current.toString());
                return true;
              },
            ),
          ),
          inAsyncCall: loadingProgress,
          progressIndicator: Center(
            child: Container(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                backgroundColor: Colors.amber,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildScreen() {
    return Container(
      child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                      top: screenSize.height * 0.03,
                      bottom: screenSize.height * 0.03),
                  child: Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: screenSize.height * 0.04),
                  )),
              radioButtonOptions(),
              loginForm(),
              SizedBox(height: screenSize.height * 0.04,),
              loginButton(),
              richText()
            ],
          )),
    );
  }

  Widget radioButtonOptions() {
    return Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            children: [
              Radio(
                value: 1,
                groupValue: selectedRadio,
                activeColor: Colors.blue,
                onChanged: (val) {
                  print("Radio $val");
                  setSelectedRadio(val);
                },
              ),
              new Text(
                'Seeker',
                style: new TextStyle(fontSize: screenSize.height * 0.025,
                    fontWeight: selectedRadio == 1
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: selectedRadio == 1 ? Colors.blue : Colors.black),
              ),
            ],
          ),
          Row(
            children: [
              Radio(
                value: 2,
                groupValue: selectedRadio,
                activeColor: Colors.blue,
                onChanged: (val) {
                  print("Radio $val");
                  setSelectedRadio(val);
                },
              ),
              new Text(
                'Recruiter',
                style: new TextStyle(fontSize: screenSize.height * 0.025,
                    fontWeight: selectedRadio == 2
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: selectedRadio == 2 ? Colors.blue : Colors.black),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget loginButton() {
    return ElevatedButton(
      onPressed: (){
        selectedRadio ==1? loginData['type'] = "seeker": loginData['type'] = "recruiter";
        if(!formGlobalKey.currentState!.validate()) {
          return;
        }
        formGlobalKey.currentState!.save();
        _loginBloc.add(PostLoginDataEvent(loginData));
        if (formGlobalKey.currentState!.validate()) {
          formGlobalKey.currentState!.save();
          // use the email provided here
        }
      },
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.15, vertical: screenSize.height * 0.015),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40))),
      child: Text("Login", style: TextStyle(
          color: Colors.white, fontSize: screenSize.height * 0.023),),
    );
  }

  Widget loginForm() {
    return Container(
      margin: EdgeInsets.only(left: screenSize.width * 0.05,
          right: screenSize.width * 0.05,
          bottom: screenSize.height * 0.06),
      child: Form(
        key: formGlobalKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenSize.height * 0.04,),
            Text('Your email'),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              validator: (email) {
                if (isEmailValid(email)) return null;
                else return 'Enter a valid email address';
              },
              onSaved: (email){
                loginData['email'] = email;
              },
            ),
            SizedBox(height:screenSize.height * 0.03,),
            Text('Password'),
            TextFormField(
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              validator: (pass) {
                if (isPasswordValid(pass)) return null;
                else return 'Password length must be 6 character';
              },
              onSaved: (pass){
                loginData['ps'] = pass;
              },
            )
          ],
        ),
      ),
    );
  }

  Widget richText() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: screenSize.height * 0.05),
      child: RichText(
        text: TextSpan(
            text: 'Don\'t have an account?',
            style: TextStyle(
                color: Colors.black, fontSize: screenSize.height * 0.02),
            children: <TextSpan>[
              TextSpan(text: ' Register',
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: screenSize.height * 0.02),
                  recognizer: TapGestureRecognizer(
                  )
                    ..onTap = () {
                      navigateToRegister();
                    }),

            ]
        ),
      ) ,
    );
  }

  Future navigateToRegister() async {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (BuildContext context) => RegistrationScreen()));
  }
  Future navigateToHomePage() async {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (BuildContext context) => HomePageScreen()));
  }

  bool isPasswordValid(String? password) => password !=null && password.length >= 6;

  bool isEmailValid(String? email) {
    var pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(email!);
  }
}
