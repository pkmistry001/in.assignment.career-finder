import 'package:careerfinder/bloc/home_page_bloc.dart';
import 'package:careerfinder/data/wrapper/all_jobs_wrapper.dart';
import 'package:careerfinder/event/home_page_event.dart';
import 'package:careerfinder/state/home_page_state.dart';
import 'package:careerfinder/ui/registration_screen.dart';
import 'package:careerfinder/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class HomePageScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageScreenState();
}

class HomePageScreenState extends State<HomePageScreen> {
  var screenSize;
  bool loadingProgress = false;
  List<AllJobsDto>? allJobList = [];
  static HomePageState? initialState = LoadingState();
  HomePageBloc _homePageBloc = HomePageBloc(initialState!);

  @override
  void initState() {
    super.initState();
    _homePageBloc.add(GetAllJobsEvent());
  }


  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery
        .of(context)
        .size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 0,
          leading: Icon(Icons.menu,color: Colors.white,),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: screenSize.width*0.02),
                child: Icon(Icons.search,color: Colors.white,)),
            Padding(
                padding: EdgeInsets.only(right: screenSize.width*0.04),
                child: Icon(Icons.filter_alt_sharp,color: Colors.white,))
          ],
        ),
        body: ModalProgressHUD(
          child: Container(
            child: BlocListener<HomePageBloc, HomePageState>(
              bloc: _homePageBloc,
              listener: (context, state) {
                setState(() {
                  loadingProgress = true;
                });
                if (state is GetAllJobsSuccess) {
                  setState(() {
                    loadingProgress = false;
                    if(state.response!.staus !=null && state.response!.staus =="true"){
                      allJobList!.addAll(state.response!.data as List<AllJobsDto>);
                    }else{
                      showErrorToast(state.response!.message);
                    }

                  });
                }

                if (state is LoadingFailure) {
                  print("State is:${state.props}");
                  showErrorToast("Something went wrong");
                }
              },
              child: loadingProgress?Container():allJobList !=null && allJobList!.length>0?buildScreen():emptyMessage(),
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
Widget emptyMessage(){
    return Center(
      child: Container(
        height: screenSize.height*0.2,
        margin: EdgeInsets.only(left: screenSize.width*0.01,right: screenSize.width*0.01,top: screenSize.height*0.01),
        child: Column(
          children: [
            Container(child: Icon(Icons.hourglass_empty,size: screenSize.height*0.06,color: Colors.black.withOpacity(0.6),),),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: screenSize.width*0.03,right: screenSize.width*0.02,top: screenSize.height*0.02,bottom: screenSize.height*0.02),
              child: Text("Nothing to show. PLease try again later",style: TextStyle(color: Colors.black.withOpacity(0.6),fontSize: screenSize.height*0.02,)),
            ),
          ],
        ),
      ),
    );
}
  Widget buildScreen() {
    return Container(
      child: ListView.builder(
          itemCount: allJobList!.length, itemBuilder: (context, index) {
        return InkWell(
            onTap: () {
              // pageNavigate(couponList[index],index);
            },
            child: itemBuilder(allJobList![index]));
      }),
    );
  }

  Widget itemBuilder(AllJobsDto allJobsDto) {
    return Container(
      margin: EdgeInsets.only(left: screenSize.width*0.01,right: screenSize.width*0.01,top: screenSize.height*0.01),
      child: Card(
        shadowColor: Colors.grey,
        elevation: 6,
        child: Container(
          padding: EdgeInsets.only(left: screenSize.width*0.03,right: screenSize.width*0.02,top: screenSize.height*0.01),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${allJobsDto.designation!=null?allJobsDto.designation:""}",style: TextStyle(color: Colors.black.withOpacity(0.6),fontSize: screenSize.height*0.02,  ),),
              SizedBox(height: screenSize.height*0.01,),
              Text("${allJobsDto.author!=null?allJobsDto.author:""}",style: TextStyle(color: Colors.black.withOpacity(0.3),fontSize: screenSize.height*0.02,  ),),
              SizedBox(height: screenSize.height*0.01,),
              Row(
                children: [
                  chip("${allJobsDto.exp !=null?allJobsDto.exp:""}",Icons.work_outlined),
                  chip("${allJobsDto.jobLocation !=null?allJobsDto.jobLocation:""}",Icons.location_on),
                ],
              ),
              SizedBox(height: screenSize.height*0.01,),
              Row(
                children: [
                  Icon(Icons.info_outlined,size: screenSize.height*0.025,),
                  SizedBox(width: screenSize.width*0.02,),
                  Text("${allJobsDto.technology !=null?allJobsDto.technology:""}",style: TextStyle(color: Colors.black.withOpacity(0.6),fontSize: screenSize.height*0.02,  ),),
                ],
              ),
              SizedBox(height: screenSize.height*0.01,),
            ],
          ),
        ),
      ),
    );
  }
  Widget chip(String text, IconData icon){
    return Container(
      padding: EdgeInsets.only(left: screenSize.width*0.02,right: screenSize.width*0.02,top:screenSize.height*0.005,bottom: screenSize.height*0.005 ),
      margin: EdgeInsets.only(right: screenSize.width*0.02, ),
      // width:  screenSize.width*0.4,
      // height:  screenSize.height*0.04,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.all(Radius.circular(18))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon,size: screenSize.height*0.02,),
          SizedBox(width: screenSize.width*0.02,),
          Text(text)
        ],
      ),
    );
  }



  Future navigateToRegister() async {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (BuildContext context) => RegistrationScreen()));
  }

/*Future pageNavigate() async{
    print("show dialog in login ${SPrefUtil.getUserInfo()!.showDialog}");
    if(SPrefUtil.getUserInfo()!.showDialog!){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (BuildContext context) => MobileNumberVerificationScreen()),
      );
    }else{
      Navigator.of(context).pushReplacement(
       MaterialPageRoute(
           builder: (BuildContext context) => HomePage(page: 0,)),
     );
    }
  }*/
  bool isPasswordValid(String? password) => password !=null && password.length == 6;

  bool isEmailValid(String? email) {
    var pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(email!);
  }
}
mixin InputValidationMixin {
  bool isPasswordValid(String password) => password.length == 6;

  bool isEmailValid(String email) {
    var pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(email);
  }
}
