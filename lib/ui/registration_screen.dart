import 'package:careerfinder/bloc/register_bloc.dart';
import 'package:careerfinder/event/register_event.dart';
import 'package:careerfinder/state/register_state.dart';
import 'package:careerfinder/ui/homepage_screen.dart';
import 'package:careerfinder/ui/login_screen.dart';
import 'package:careerfinder/utils/toast_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  var screenSize;
  int? selectedRadio;
  bool loadingProgress = false;
  final formGlobalKey = GlobalKey <FormState>();
  var registrationData = new Map<String, dynamic>();
  static RegisterState? initialState = LoadingState();
  RegisterBloc _registerBloc = RegisterBloc(initialState!);

  @override
  void initState() {
    super.initState();
    selectedRadio = 1;
  }

  setSelectedRadio(var val) {
    setState(() {
      selectedRadio = val;
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
            child: BlocListener<RegisterBloc, RegisterState>(
              bloc: _registerBloc,
              listener: (context, state) {
                setState(() {
                  loadingProgress = true;
                });
                if (state is RegisterSuccess) {
                  print("State is:${state.response!.staus!}");
                  setState(() {
                    loadingProgress = false;
                  });
                  if (state.response!.staus != null && state.response!.staus == "true") {
                    navigateToHomePage();
                  }else{
                    showErrorToast(state.response!.message);
                  }
                }

                if (state is LoadingFailure) {
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
              width: screenSize.width * 0.02,
              height: screenSize.height * 0.02,
              child: CircularProgressIndicator(
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
                    "Signup",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: screenSize.height * 0.04),
                  )),
              radioButtonOptions(),
              registrationForm(),
              SizedBox(height: screenSize.height * 0.04,),
              registrationButton(),
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

  Widget registrationButton() {
    return ElevatedButton(
      onPressed: (){
        selectedRadio ==1? registrationData['type'] = 'seeker': registrationData['type'] = 'recruiter';
        if(!formGlobalKey.currentState!.validate()) {
          return;
        }
        formGlobalKey.currentState!.save();
        _registerBloc.add(PostRegisterDataEvent(registrationData));
      },
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.15, vertical: screenSize.height * 0.015),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20))),
      child: Text("Signup", style: TextStyle(
          color: Colors.white, fontSize: screenSize.height * 0.023),),
    );
  }

  Widget registrationForm() {
    return Container(
      // height: screenSize.height*0.06,
      // width: screenSize.width*0.35,
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
                if(email!.isEmpty){
                  return "Email is required.";
                }
                if (isEmailValid(email))
                  return null;
                else
                  return 'Enter a valid email address';
              },
              onSaved: (email){
                registrationData['email'] = email;
              },
            ),
            SizedBox(height:screenSize.height * 0.03,),
            Text('You Name'),
            TextFormField(
              keyboardType: TextInputType.text,
              validator: (name) {
                if(name!.isEmpty){
                  return 'Name is required';
                }
              },
              onSaved: (name){
                registrationData['name'] = name;
              },
            ),
            SizedBox(height:screenSize.height * 0.03,),
            Text('You Number'),
            TextFormField(
              keyboardType: TextInputType.number,
              validator: (num) {
                if(num!.isEmpty){
                  return 'Mobile Number is required';
                }
                if (isNumberValid(num))
                  return null;
                else
                  return 'Mobile Number must be 10 digit';
              },
              onSaved: (num){
                registrationData['mno'] = num;
              },
            ),
            SizedBox(height:screenSize.height * 0.03,),
            Text('Password'),
            TextFormField(
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              validator: (pass) {
                if(pass!.isEmpty){
                  return 'Password is required';
                }
                if (isPasswordValid(pass))
                  return null;
                else
                  return 'Password length must be 6 character';
              },
              onSaved: (pass){
                registrationData['ps'] = pass;
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
            text: 'Already have an account?',
            style: TextStyle(
                color: Colors.black, fontSize: screenSize.height * 0.02),
            children: <TextSpan>[
              TextSpan(text: ' Login',
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: screenSize.height * 0.02),
                  recognizer: TapGestureRecognizer(
                  )
                    ..onTap = () {
                      navigateToLogin();
                    }),

            ]
        ),
      ) ,
    );
  }

  Future navigateToLogin() async {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (BuildContext context) => LoginScreen()));
  }
  Future navigateToHomePage() async {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (BuildContext context) => HomePageScreen()));
  }

  //form validators methods
  bool isPasswordValid(String? password) => password !=null && password.length >= 6;

  bool isNumberValid(String? number) => number !=null && number.length == 10;

  bool isEmailValid(String? email) {
    var pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(email!);
  }
}

