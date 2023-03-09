import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vendorapp/Screen/registration/registration.dart';

import '../../Config/image.dart';
import '../../Config/theme.dart';
import '../../Model/otpVerifyData.dart';
import '../../Utils/connectivity_check.dart';
import '../../Utils/translate.dart';
import '../../Widget/app_button.dart';
import '../../Widget/app_dialogs.dart';


class OtpScreen extends StatefulWidget{
  // OTPVerify? otpVerify;
  var mobile,verifId;
  OtpScreen({Key? key, this.mobile,this.verifId}) : super(key: key);

  _OtpScreenState createState()=>_OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen>{
  AnimationController? _controller;

  // Variables
  Size? _screenSize;
  var _firstDigit;
  var _secondDigit;
  var _thirdDigit;
  var _fourthDigit;
  var _fifthDigit;
  var _sixthDigit;

  int? _currentDigit;
  String authStatus="",deviceId="",token="";
  var verificationId,otp;
  AuthCredential? authservice;
  bool isconnectedToInternet = false;
  String strTimer="";


  var scaffoldKey = new GlobalKey<ScaffoldState>();
  var number,firebaseUser_Id;
  UserCredential? authResult;
  Timer? countDownTimer;

  int _start=0;

  @override
  void initState() {

  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    countDownTimer = new Timer.periodic(
        oneSec,
            (Timer timer) {
              if (this.mounted) {
                setState(() {
                  if (_start > 60) {
                    timer.cancel();
                  } else {
                    _start = _start + 1;
                    strTimer = _start.toString();
                  }
                });
              }
        });

  }
  @override
  void dispose() {
    if(countDownTimer!=null){
      countDownTimer!.cancel();
    }
    super.dispose();
  }


  // // Step 4
  // void stopTimer() {
  //   setState(() => countDownTimer!.cancel());
  // }


  //check otp
  Future<dynamic> checkotp(dynamic phone) async {
    if (verificationId != null && otp != null) {
      try {
        // authservice =await FirebaseAuth.instance(
        //     PhoneAuthProvider.credential(
        //   verificationId: verificationId,
        //   smsCode: otp,
        // ));
        authservice =
            PhoneAuthProvider.credential(
              verificationId: verificationId,
              smsCode: otp,
            );
      } catch (e) {
        print(e);
      }

      signIn(authservice!,phone);
    }
  }

  //updated to check valid sms code
  //SignIn
  signIn(AuthCredential credential, phone) async {
    authResult = await FirebaseAuth.instance
        .signInWithCredential(credential)
        .catchError((onError) {
      print('SignIn Error: ${onError.toString()}\n\n');
    });

    if (authResult != null) {
      firebaseUser_Id=authResult!.user!.uid.toString();

      print("fb_id"+firebaseUser_Id);
      isconnectedToInternet = await ConnectivityCheck.checkInternetConnectivity();
      if (isconnectedToInternet == true) {
        // if (widget.otpVerify.flagRoleType == "0") { //for customer
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    RegistrationScreen()));

        //
        //   _loginBloc.add(OnLogin(
        //       fbId: firebaseUser_Id.toString(),
        //       fcmId: token,
        //       deviceId: deviceId
        //   ));
        // } else { //for fleet manager
        //   _loginBloc.add(OnFleetLogin(
        //       fbId: firebaseUser_Id.toString(),
        //       mobile: phone,
        //       fcmId: token,
        //       deviceId: deviceId
        //   ));
        // }

      }else{
        CustomDialogs.showDialogCustom(
            "Internet", "Please check your Internet Connection!", context);
      }
    } else {
      // scaffoldKey.currentState.showSnackBar(SnackBar(
      //   content: Text("Please enter valid sms code"),
      // ));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please enter valid sms code"),
      ));
    }
  }
  // Return "OTP" input field
  get _getInputField {
    return
      Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _otpTextField(_firstDigit),
          _otpTextField(_secondDigit),
          _otpTextField(_thirdDigit),
          _otpTextField(_fourthDigit),
          _otpTextField(_fifthDigit),
          _otpTextField(_sixthDigit),
        ],
      );
  }

  ///On show message fail
  Future<void> _showMessage(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
              "OTP Verification",
              style:TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  color: AppTheme.textColor
              )
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  message,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text(
                Translate.of(context)!.translate('close'),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Returns "Otp custom text field"
  Widget _otpTextField(var digit) {
    return
      Expanded(
        child:
        Container(
          width: MediaQuery.of(context).size.width,
          height: 40.0,
          margin: EdgeInsets.all(4.0),
          alignment: Alignment.center,
          child: Text(
            digit != null ? digit.toString() : "",
            style: TextStyle(
                fontSize: 18.0,
                color: AppTheme.textColor,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color:
              digit==null?
              Color(0xFFF70000).withOpacity(0.2)
                  :
              Theme.of(context).primaryColor,  // red as border color
            ),
            color:
            digit==null?
            // Color(0xFFFFD8BC)
            Color(0xFFF70000).withOpacity(0.2)
                :
            Colors.white,

          ),
        ),
      );
  }

  // Returns "Otp" keyboard
  get _getOtpKeyboard {
    return Container(
        margin: EdgeInsets.only(top:5.0),
        height: MediaQuery.of(context).size.width-100,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "1",
                      onPressed: () {
                        _setCurrentDigit(1);
                      }),
                  _otpKeyboardInputButton(
                      label: "2",
                      onPressed: () {
                        _setCurrentDigit(2);
                      }),
                  _otpKeyboardInputButton(
                      label: "3",
                      onPressed: () {
                        _setCurrentDigit(3);
                      }),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "4",
                      onPressed: () {
                        _setCurrentDigit(4);
                      }),
                  _otpKeyboardInputButton(
                      label: "5",
                      onPressed: () {
                        _setCurrentDigit(5);
                      }),
                  _otpKeyboardInputButton(
                      label: "6",
                      onPressed: () {
                        _setCurrentDigit(6);
                      }),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _otpKeyboardInputButton(
                      label: "7",
                      onPressed: () {
                        _setCurrentDigit(7);
                      }),
                  _otpKeyboardInputButton(
                      label: "8",
                      onPressed: () {
                        _setCurrentDigit(8);
                      }),
                  _otpKeyboardInputButton(
                      label: "9",
                      onPressed: () {
                        _setCurrentDigit(9);
                      }),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                  Visibility(
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: _sixthDigit != null,
                    child: _otpKeyboardActionButton(
                        label: Icon(
                          Icons.check_circle,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          // you can dall OTP verification API.
                        }),
                  ),

                  _otpKeyboardInputButton(
                      label: "0",
                      onPressed: () {
                        _setCurrentDigit(0);
                      }),
                  _otpKeyboardActionButton(
                      label: Icon(
                        Icons.backspace,
                        color: Colors.black,
                      ),
                      onPressed: () {
    if (this.mounted) {
      setState(() {
        if (_sixthDigit != null) {
          _sixthDigit = null;
        } else if (_fifthDigit != null) {
          _fifthDigit = null;
        } else if (_fourthDigit != null) {
          _fourthDigit = null;
        } else if (_thirdDigit != null) {
          _thirdDigit = null;
        } else if (_secondDigit != null) {
          _secondDigit = null;
        } else if (_firstDigit != null) {
          _firstDigit = null;
        }
      });
    }
                      }),
                ],
              ),
            ),
          ],
        ));
  }

  // Returns "Otp keyboard input Button"
  Widget _otpKeyboardInputButton({String? label, VoidCallback? onPressed}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: new BorderRadius.circular(40.0),
        child: Container(
          height: 80.0,
          width: 80.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              label!,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Returns "Otp keyboard action Button"
  _otpKeyboardActionButton({Widget? label, VoidCallback? onPressed}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(40.0),
      child: Container(
        height: 80.0,
        width: 80.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Center(
          child: label,
        ),
      ),
    );
  }

  // Current digit
  void _setCurrentDigit(int i) {
    if (this.mounted) {
      setState(() {
        _currentDigit = i;
        if (_firstDigit == null) {
          _firstDigit = _currentDigit;
        } else if (_secondDigit == null) {
          _secondDigit = _currentDigit;
        } else if (_thirdDigit == null) {
          _thirdDigit = _currentDigit;
        } else if (_fourthDigit == null) {
          _fourthDigit = _currentDigit;
        }
        else if (_fifthDigit == null) {
          _fifthDigit = _currentDigit;
        }
        else if (_sixthDigit == null) {
          _sixthDigit = _currentDigit;

          otp = _firstDigit.toString() +
              _secondDigit.toString() +
              _thirdDigit.toString() +
              _fourthDigit.toString() +
              _fifthDigit.toString() +
              _sixthDigit.toString();

          // Verify your otp by here. API call
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            title:Text('',style: TextStyle(
                fontFamily: 'Poppins',fontWeight: FontWeight.w600
            ),)
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage(Images.bg),
          //     fit: BoxFit.cover,
          //   ),
          // ),
          child: Center(
            child: Container(
                margin: EdgeInsets.only(left: 20.0,right: 20.0),
                child:SingleChildScrollView(
                  child:
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // SizedBox(height: 10.0,),
                      // Image.asset(Images.logo,height: 180.0,width:180.0),
                      Text("Verification Code",style: TextStyle(color:Colors.black,
                          fontFamily: 'Poppins',fontWeight:FontWeight.w600,fontSize: 18.0),),
                      SizedBox(height: 10.0,),
                      Text(Translate.of(context)!.translate('otp_verification'),style: TextStyle(color:Colors.black,
                          fontFamily: 'Poppins',fontWeight:FontWeight.w500,fontSize: 13.0),),
                      Text("+91 "+widget.mobile,style: TextStyle(color:Colors.black,
                          fontFamily: 'Poppins',fontWeight:FontWeight.w600,fontSize: 13.0),),
                      SizedBox(height: 35.0,),
                      Padding(
                          padding:EdgeInsets.only(left:25.0,right:25.0),
                          child:_getInputField),

                      //for login api call
                      // BlocBuilder<LoginBloc,LoginState>(builder: (context,login){
                      //   return BlocListener<LoginBloc,LoginState>(listener: (context,state){
                      //     if (state is LoginFail) {
                      //       _showMessage(
                      //         // Translate.of(context).translate(state.code), //commented on 9/12/2020
                      //         Translate.of(context).translate(state.msg),//added on 9/12/2020
                      //       );
                      //     }
                      //     if (state is LoginSuccess) {
                      //       print("isRegistered:-"+state.userModel.isRegistered);
                      //       if(state.userModel.isRegistered=="false"){
                      //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                      //             SignUp(user:authResult.user,signUpDataNavigation:widget.navigateData,phone: widget.otpVerify.phone.toString(),)));
                      //       }
                      //       else {
                      //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>
                      //             MainNavigation(userType: widget.otpVerify.flagRoleType)));
                      //       }
                      //     }
                      //   },
                      //     child:
                          Padding(padding: EdgeInsets.only(left:10.0,right: 10.0,top:55.0),
                              child:
                              AppButton(
                                onPressed: (){
                                  // if(_firstDigit!=null && _secondDigit!=null && _thirdDigit!=null &&
                                  //     _fourthDigit!=null && _fifthDigit!=null && _sixthDigit!=null){
                                    verificationId=widget.verifId;
                                    // checkotp(widget.mobile);
                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                        RegistrationScreen()));
                                  // }else{
                                  //   _showMessage("Please enter Otp");
                                  // }
                                },
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
                                text: 'Verify Now',
                                // loading: login is LoginLoading,
                                loading: true,
                                color: Theme.of(context).primaryColor,
                              )
                          ),
                      //   );
                      // }),
                      SizedBox(height: 25.0,),
                      Text("Didn't receive any code?",style: TextStyle(color:Colors.black,
                          fontFamily: 'Poppins',fontWeight:FontWeight.w400,fontSize: 12.0),),
                      Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){
                             startTimer();
                            },
                              child:Text("Resend New Code",textAlign:TextAlign.center,style: TextStyle(color:Colors.red,
                              fontFamily: 'Poppins',fontWeight:FontWeight.w600,fontSize: 14.0),)),
                          Padding(padding: EdgeInsets.all(5.0),child:Text(strTimer!=""?":  $strTimer sec":"",style: TextStyle(color:Colors.red,
                              fontFamily: 'Poppins',fontWeight:FontWeight.w600,fontSize: 14.0),)),
                        ],
                      ),

                      _getOtpKeyboard

                    ],
                  ),
                )),
          ),
        )

    );

  }

}