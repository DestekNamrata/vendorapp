import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendorapp/Screen/registration/registration.dart';

import '../../Config/font.dart';
import '../../Utils/progressDialog.dart';
import '../../Utils/translate.dart';
import '../../Utils/utilOther.dart';
import '../../Utils/validate.dart';
import '../../Widget/app_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Widget/app_mobile_input.dart';
import 'otp_screen.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  String dropdownValue = '+ 91';
  String? phoneNum;
  String? role;
  bool loading=false;
  final _formKey = GlobalKey<FormState>();
  String prefix="",authStatus="";
  var _validMobile="",verificationId;
  var scaffoldKey = new GlobalKey<ScaffoldState>();
  final _focusMobile = FocusNode();


  @override
  void initState() {
    // TODO: implement initState
    //saveDeviceTokenAndId();
    super.initState();
   // _phoneNumberController.clear();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phoneNumberController.dispose();
  }

  // void saveDeviceTokenAndId() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   //for device Id
  //   var deviceInfo = DeviceInfoPlugin();
  //   if (Platform.isAndroid) {
  //     // import 'dart:io'
  //     var androidDeviceId = await deviceInfo.androidInfo;
  //     // print("androiId" + androidDeviceId.androidId);
  //     sharedPreferences.setString('deviceId', androidDeviceId.androidId);
  //   } else {
  //     var iosDeviceId = await deviceInfo.iosInfo;
  //     sharedPreferences.setString('deviceId', iosDeviceId.identifierForVendor);
  //     print("iosId" + iosDeviceId.identifierForVendor);
  //   }
  // }


  void ValidateSignIn(){
    UtilOther.hiddenKeyboard(context);
    setState(() async {
        prefix="+91 ";
        _validMobile = UtilValidator.validate(
            data: _phoneNumberController.text,
            type: ValidateType.phone
        );
        var number;
      if (_validMobile==""  ) {
        number="+91"+_phoneNumberController.text;
        await PsProgressDialog.showProgressWithoutMsg(
            context);
        // setState((){
          // loading=true;

        // });
        verifyPhoneNumber(context,number);
        // _loginBloc.add(OnLogin(custId: _textMobileController.text,custPwd: _textPasswordController.text,
        //     fcmToken: fcmToken));
      }
    });
  }

  Future<void> verifyPhoneNumber(BuildContext context,String number) async {

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: number,
        timeout: const Duration(seconds: 15),
        verificationCompleted: (AuthCredential authCredential) {
          //  signIn(authCredential);
          print('verfication completed called sent called');
          //commented on 14/062021
          // setState(() {
          //   authStatus = "sucess";
          // });
          // if (authStatus != "") {
          //   scaffoldKey?.currentState?.showSnackBar(SnackBar(
          //     content: Text(authStatus),
          //   ));
          // }
        },
        verificationFailed: (FirebaseAuthException authException) {
          print(authException.message! + "Inside auth failed");
          setState(() {
            // authStatus = "Authentication failed";
            authStatus = authException.message!;
          });
          // loader.remove();
          // Helper.hideLoader(loader);
          if (authStatus != "") {
            // scaffoldKey.currentState.showSnackBar(SnackBar(
            //   content: Text(authStatus),
            // ));
            Fluttertoast.showToast(msg: authStatus);

          }
        },
        codeSent: (String? verId, [int? forceCodeResent]) {
          // loader.remove();
          // Helper.hideLoader(loader);
          // this.verificationId = verId;
          setState(() {
            authStatus = "OTP has been successfully sent";
            // user.deviceToken = verId;
            verificationId = verId;
            loading=false;
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>
                OtpScreen(
                    mobile:_phoneNumberController.text,
                    verifId:verificationId.toString(),
                )));

            //  users.deviceToken = verId;
          });
          if (authStatus != "") {
            // scaffoldKey.currentState.showSnackBar(SnackBar(
            //   content: Text(authStatus),
            // ));
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(authStatus),
            ));

          }
        },
        codeAutoRetrievalTimeout: (String verId) {
          // user.deviceToken = verId;
          //    print('coderetreival sent called' + verificationId);
          setState(() {
            authStatus = "TIMEOUT";
          });
        },
      );
    }catch(e){
      print(e);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
            Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.10,
                    ),
                    Center(
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.25,
                          child: Image.asset(
                              'assets/images/Logo.png')),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                  ],
                ),
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Column(
                          children: [

                           Padding(padding: EdgeInsets.only(bottom: 30.0),child: Text(
                             "Enter your mobile number",style: TextStyle(
                             fontFamily: 'Poppins',fontWeight: FontWeight.w400,
                             color: Colors.white.withOpacity(0.8),
                             fontSize: 16.0
                           ),
                           )),

                            SizedBox(
                              width:
                              MediaQuery.of(context).size.width * 0.8,

                              child: AppMobileInput(
                                enabled: true,
                                // prefix: "+91 ",
                                prefixIconText: "+91",
                                maxLength: 10,
                                hintText: Translate.of(context)
                                    !.translate('mobile'),
                                errorText: Translate.of(context)
                                    !.translate(_validMobile),
                                icon: Icon(Icons.clear),
                                controller: _phoneNumberController,
                                focusNode: _focusMobile,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.phone,
                                onChanged: (text) {
                                  setState(() {
                                    _validMobile = UtilValidator.validate(
                                        data: _phoneNumberController.text,
                                        type: ValidateType.phone,
                                      flagInput:"mobile"

                                    );
                                  });
                                },

                                onTapIcon: () async {
                                  await Future.delayed(
                                      Duration(milliseconds: 100));
                                  _phoneNumberController.clear();
                                },
                              )),
                              // TextFormField(
                              //   controller: _phoneNumberController,
                              //   keyboardType: TextInputType.number,
                              //   maxLength: 10,
                              //   cursorColor: primaryAppColor,
                              //   decoration: InputDecoration(
                              //     disabledBorder: OutlineInputBorder(
                              //       borderRadius:
                              //       BorderRadius.circular(8.0),
                              //       borderSide: const BorderSide(
                              //         color: Colors.white,
                              //         width: 1.0,
                              //       ),
                              //     ),
                              //     errorBorder: OutlineInputBorder(
                              //       borderRadius:
                              //       BorderRadius.circular(8.0),
                              //       borderSide: const BorderSide(
                              //         color: Colors.red,
                              //         width: 1.0,
                              //       ),
                              //     ),
                              //     fillColor: Colors.white,
                              //     filled: true,
                              //     focusedBorder: OutlineInputBorder(
                              //       borderRadius:
                              //       BorderRadius.circular(10.0),
                              //       borderSide: const BorderSide(
                              //           color: Colors.white, width: 1.0),
                              //     ),
                              //     focusedErrorBorder: OutlineInputBorder(
                              //         borderRadius:
                              //         BorderRadius.circular(8.0),
                              //         borderSide: const BorderSide(
                              //           color: Colors.white,
                              //           width: 1.0,
                              //         )),
                              //     enabledBorder: OutlineInputBorder(
                              //       borderRadius:
                              //       BorderRadius.circular(8.0),
                              //       borderSide: const BorderSide(
                              //         color: Colors.white,
                              //         width: 1.0,
                              //       ),
                              //     ),
                              //     hintText: 'Mobile Number',
                              //     contentPadding: const EdgeInsets.fromLTRB(
                              //         20.0, 20.0, 0.0, 0.0),
                              //     hintStyle: GoogleFonts.poppins(
                              //         color: Colors.grey,
                              //         fontSize: 12.0,
                              //         fontWeight: FontWeight.w500),
                              //   ),
                              //   onChanged: (val) {
                              //     setState(() {
                              //       _validMobile = UtilValidator.validate(
                              //           data: _phoneNumberController.text,
                              //           type: ValidateType.phone
                              //       );
                              //     });
                              //   },
                              // ),

                            // ),
                            const SizedBox(
                              height: 7.0,
                            ),

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40.0),
                              child: AppButton(
                                onPressed: () async {
                                  // ValidateSignIn();
                                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>
                                      OtpScreen(
                                        mobile:_phoneNumberController.text,
                                        verifId:verificationId.toString(),
                                      )));
                                  },
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                                text: 'Verify Number',
                                loading: true,
                                color: Theme.of(context).buttonColor,


                              )
                            ),
                          ],
                        ),
                        SizedBox(height: 10),

                        if(loading==true)
                          SizedBox(
                            width: 10,
                            height: 10,
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                              color: Colors.red,
                            ),
                          ),



                        // TextButton(
                        //     child: const Text(
                        //       'Do not have any account? Create Account',
                        //       style: TextStyle(
                        //           color: Colors.white,
                        //           letterSpacing: 1,
                        //           fontWeight: FontWeight.w400,
                        //           fontSize: 14),
                        //     ),
                        //     onPressed: () {
                        //       Navigator.of(context).pushReplacement(
                        //           MaterialPageRoute(builder: (context) => RegistrationScreen()));
                        //     })
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

    );
  }
}
