import 'dart:async';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vendorapp/Screen/registration/bankDetails.dart';
import 'package:vendorapp/Screen/registration/basic_info.dart';

import '../../Config/font.dart';
import '../../Config/image.dart';
import '../../Config/theme.dart';
import '../../Utils/translate.dart';
import '../../Utils/utilOther.dart';
import '../../Utils/validate.dart';
import '../../Widget/app_button.dart';
import '../../Widget/app_text_input.dart';
import '../../Widget/stepper_button.dart';
import '../../mainNavigation.dart';
import '../user/login_screen.dart';
import 'officeWorkAdd.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  //basic info
  final _textFullNameController = TextEditingController();
  final _textEmailController = TextEditingController();
  final _textMobileController = TextEditingController();
  final _textCompNameController = TextEditingController();
  final _textShopDescController = TextEditingController();
  final _textShopLocController = TextEditingController();
  final _focusFullName = FocusNode();
  final _focusCompName= FocusNode();
  final _focusEmail = FocusNode();
  final _focusMobile = FocusNode();
  final _focusShopDesc = FocusNode();
  final _focusShopLoc = FocusNode();
  String _validFullName="",_validCompName="",_validEmail="",_validMobile="",_validShopDesc="",_validShopLoc="";

  //office&work
  final _textCurrAddController = TextEditingController();
  final _textPinBillController = TextEditingController();
  final _textCountryBillController = TextEditingController();
  final _textCountryWorkController = TextEditingController();
  final _textWorkLocController = TextEditingController();
  final _textWorkAddController = TextEditingController();
  final _textWorkPinController = TextEditingController();
  final _textProvGstController = TextEditingController();
  final _focusCurrAddName = FocusNode();
  final _focusPinBillName= FocusNode();
  final _focusWorkLoc = FocusNode();
  final _focusWorkAdd = FocusNode();
  final _focusWorkPin = FocusNode();
  final _focusProvGst = FocusNode();
  String _validCurrAdd="",_validPinBill="",_validWorkLoc="",_validWorkAdd="",_validWorkPin="",_validProvGst="",_validBillCountry="",_valiWorkCountry="";
  String verification="0"; //for gstNum 1=no gst num

  //bank details
  final _textAccntHolderontroller = TextEditingController();
  final _textAcntTypeController = TextEditingController();
  final _textAcntNumController = TextEditingController();
  final _textReEnterAcntNumController = TextEditingController();
  final _textIFSCController = TextEditingController();
  final _textUPIIDController = TextEditingController();

  final _focusAcntHolderName = FocusNode();
  final _focusAcntType= FocusNode();
  final _focusAcntNum = FocusNode();
  final _focusReEnterAcntNum = FocusNode();
  final _focusIFSC = FocusNode();
  final _focusUPI = FocusNode();

  String _validAcntHolder="",_validAcntType="",_validAcntNum="",_validReAcntNum="",_validIFSC="",_validUPI="";

  String dropdownValue = '+ 91';
  String? phoneNum;
  String? role;
  bool loading = true;
  int _currentStep = 0;
  bool isCompleted = false;

  var stateItems = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhatisgarh',
    'Delhi',
    'Goa',
    'Gujarat',
    'Hariyana',
    'Himachal Pradesh',
    'Jammu and Kashmir',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    ' Mizoram',
    'Nagaland',
    'Odisha',
    'Pondicherry',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
    'Andaman and Nicobar Islands',
    'Chandigarh',
    'Dadra & Haveli and Daman & Diu',
    'Ladakh',
    'Other Territory'
  ];

  var cityItems = [
    'Pune',
    'Mumbai',
  ];

  var _dropDownValue,dropdownCityValue;

  List<Step> stepList() => [
    Step(
      state: _currentStep <= 0 ? StepState.indexed : StepState.complete,
      // state: _currentStep <= 0 ? Icon(Icons.circle): StepState.complete,
      isActive: _currentStep >= 0,
      title: Text('Basic Info',style:  TextStyle(fontSize: 12.0),),
      content: BasicInfoWid(context)
    ),
    Step(
      state: _currentStep <= 1 ? StepState.indexed : StepState.complete,
      isActive: _currentStep >= 1,
      title: Text('Office & Work',style:  TextStyle(fontSize: 12.0),),
      content: OfficeWorkWidget(context),
    ),
    Step(
      state: StepState.complete,
      isActive: _currentStep >= 2,
      title: Text('Bank Details',style: TextStyle(fontSize: 12.0),),
      content: bankDetWidget(context),
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  tapped(int step){
    setState(() => _currentStep = step);
  }

  continued(){
    _currentStep < 2 ?
    setState(() => _currentStep += 1): null;
  }
  cancel(){
    _currentStep > 0 ?
    setState(() => _currentStep -= 1) : null;
  }

  void ValidateBasicInfo(){
    UtilOther.hiddenKeyboard(context);
    setState(() {
      _validFullName = UtilValidator.validate(
          data: _textFullNameController.text,
          type: ValidateType.name
      );
      _validEmail = UtilValidator.validate(
          data: _textEmailController.text,
          type: ValidateType.email
      );
      _validCompName = UtilValidator.validate(
          data: _textCompNameController.text,
        type:ValidateType.compName
      );
      _validShopDesc = UtilValidator.validate(
          data: _textShopDescController.text,
          type:ValidateType.shopDesc
      );
      // _validShopLoc = UtilValidator.validate(
      //     data: _textShopDescController.text,
      //     type:ValidateType.shopLoc
      // );
      if (_validFullName==""&&_validEmail==""&&_validCompName==""&&_validShopDesc=="") {
        print("validate");
        // _loginBloc.add(OnLogin(custId: _textMobileController.text,custPwd: _textPasswordController.text,
        //     fcmToken: fcmToken));
        setState(() {
          _currentStep += 1;
        });
      }
    });
  }

  void ValidateOfficeWork(){
    UtilOther.hiddenKeyboard(context);
    setState(() {
      _validCurrAdd = UtilValidator.validate(
          data: _textCurrAddController.text,
          type: ValidateType.currAddress
      );
      _validPinBill = UtilValidator.validate(
          data: _textPinBillController.text,
          type: ValidateType.pincode
      );
      // _validWorkLoc = UtilValidator.validate(
      //     data: _textWorkLocController.text,
      //     type:ValidateType.workLoc
      // );
      _validWorkAdd = UtilValidator.validate(
          data: _textWorkAddController.text,
          type:ValidateType.workkAddress
      );
      _validWorkPin = UtilValidator.validate(
          data: _textWorkPinController.text,
          type:ValidateType.pincode
      );


      _validProvGst=UtilValidator.validate(
        data: _textProvGstController.text,
        type: ValidateType.provGst
      ) ;

      if(verification=="0"){
        if (_validCurrAdd==""&&_validPinBill==""&&_validWorkAdd==""&&_validWorkPin=="") {
          print("validate");
          // _loginBloc.add(OnLogin(custId: _textMobileController.text,custPwd: _textPasswordController.text,
          //     fcmToken: fcmToken));
          setState(() {
            _currentStep += 1;
          });
        }

      }else if (_validCurrAdd==""&&_validPinBill==""&&_validWorkAdd==""&&_validWorkPin==""&&_validProvGst=="") {
        print("validate");
        // _loginBloc.add(OnLogin(custId: _textMobileController.text,custPwd: _textPasswordController.text,
        //     fcmToken: fcmToken));
        setState(() {
          _currentStep += 1;
        });
      }

    });
  }

  void ValidateBankDet(){
    UtilOther.hiddenKeyboard(context);
    setState(() {
      _validAcntHolder = UtilValidator.validate(
          data: _textAccntHolderontroller.text,
          type: ValidateType.name
      );
      _validAcntType = UtilValidator.validate(
          data: _textAcntTypeController.text,
      );
      _validAcntNum = UtilValidator.validate(
          data: _textAcntNumController.text,
          type:ValidateType.accntNum
      );
      _validReAcntNum = UtilValidator.validate(
          data: _textReEnterAcntNumController.text,
          type:ValidateType.accntNum
      );
      _validIFSC = UtilValidator.validate(
          data: _textIFSCController.text,
          type:ValidateType.ifsc
      );
      _validUPI = UtilValidator.validate(
          data: _textUPIIDController.text,
          type:ValidateType.upi
      );

      if (_validAcntHolder==""&&_validAcntType==""&&_validAcntNum==""&&_validReAcntNum==""&&_validWorkPin==""&&_validProvGst=="") {
        print("validate");
        // _loginBloc.add(OnLogin(custId: _textMobileController.text,custPwd: _textPasswordController.text,
        //     fcmToken: fcmToken));
        setState(() {
          _currentStep += 1;
        });
      }

    });
  }

  static Future<void> showRegisterationDialog(String title,String content ,BuildContext context) async{
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: new Text(title),
              content: new Text(content),
              actions: <Widget>[
                new TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: InkWell(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MainNavigation()));
                      },
                        child:Text("Ok")))
              ]
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,

          backgroundColor: Colors.white,
          leading: InkWell(
              onTap: (){
                Navigator.of(context).pop();
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => ServiceRequestDetailsScreen()));
              },
              child: Icon(Icons.arrow_back_ios,color: Colors.black,)),
          title: Text('',style:TextStyle(fontSize: 12.0) ,),
        ),
        body:
        // Column(
        //   children: [
        //     Expanded(
        //         child:Theme(
        //     data:Theme.of(context).copyWith(
        //   colorScheme: ColorScheme.light(primary: Color(0xFFF70000))
        // ),child:
        //         Stepper(
        //         type: StepperType.horizontal,
        //           currentStep: _currentStep,
        //         steps: stepList(),
        //           controlsBuilder: (BuildContext context, ControlsDetails controls) {
        //           return Padding(
        //             padding: const EdgeInsets.symmetric(vertical: 5.0),
        //             child:
        //             Row(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: <Widget>[
        //                 if (_currentStep != 0)
        //                   StepperButton(
        //                     onPressed: () async {
        //                       if (_currentStep == 0) {
        //                         return;
        //                       }
        //
        //                       setState(() {
        //                         _currentStep -= 1;
        //                       });
        //                     },
        //                     shape: const RoundedRectangleBorder(
        //                         borderRadius:
        //                         BorderRadius.all(Radius.circular(50))),
        //                     text: 'Back',
        //                     loading: loading,
        //                   ),
        //                 StepperButton(
        //
        //                   onPressed: () async {
        //                     final isLastStep = _currentStep == stepList().length - 1;
        //                     if(isLastStep)
        //                     {
        //                       setState(() {
        //                         isCompleted = true;
        //                       });
        //                     }
        //                     else
        //                     {
        //                       setState(() {
        //                         _currentStep += 1;
        //                       });
        //                     }
        //                   },
        //                   shape: const RoundedRectangleBorder(
        //                       borderRadius:
        //                       BorderRadius.all(Radius.circular(50))),
        //                   text: 'Next',
        //                   loading: loading,
        //                 ),
        //               ],
        //             ),
        //             );
        //       },
        //     ))),
        //   ],
        // ),
        Container(
          color: Colors.white,

          child: Theme(
                data:Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(primary: Color(0xFFF70000))
            ),child: Stepper(
                  type: StepperType.horizontal,
                  physics: ScrollPhysics(),
                  currentStep: _currentStep,
                  // onStepTapped: (step) => tapped(step),
                  // onStepContinue:  continued,
                  // onStepCancel: cancel,
                  steps: stepList(),
            controlsBuilder: (BuildContext context, ControlsDetails controls) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    if (_currentStep != 0)
                      Expanded(child:StepperButton(
                        onPressed: () async {
                          if (_currentStep == 0) {
                            return;
                          }

                          setState(() {
                            _currentStep -= 1;
                          });
                        },
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(50))),
                        text: 'Previous',
                        loading: loading,
                      )),
                    Expanded(child:StepperButton(

                      onPressed: () async {
                        final isLastStep = _currentStep == stepList().length - 1;
                        if(isLastStep)
                        {
                          setState(() {
                            isCompleted = true;
                            showRegisterationDialog("Registration", "You have sucsessfuly Registered", context);
                          });
                        }
                        else
                        {
                          // if(_currentStep==0){
                            //   ValidateBasicInfo();
                            // }else if(_currentStep==1){
                            //     ValidateOfficeWork();
                            // }else if(_currentStep==2){
                            //
                            // }
                            setState(() {
                            _currentStep += 1;
                          });
                        }
                      },
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(50))),
                      text: 'Continue',
                      loading: loading,
                    )),
                  ],
                ),

              );
            },
          )),
        ),
      
    );
  }
  //basicInfo
  Widget BasicInfoWid(BuildContext context){
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Basic Information",style: TextStyle(
                fontSize: 15.0,fontWeight: FontWeight.w600,
                fontFamily: "Poppins",color: AppTheme.textColor
            ),),
            //full name
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: AppTextInput(
                hintText: Translate.of(context)!.translate('input_name'),
                errorText: Translate.of(context)!.translate(_validFullName),
                focusNode: _focusFullName,
                textInputAction: TextInputAction.next,
                onTapIcon: () async {
                  await Future.delayed(Duration(milliseconds: 100));
                  _textFullNameController.clear();
                },
                onSubmitted: (text) {
                  UtilOther.fieldFocusChange(
                    context,
                    _focusFullName,
                    _focusEmail,
                  );
                },
                onChanged: (text) {
                  setState(() {
                    _validFullName = UtilValidator.validate(
                        data: _textFullNameController.text,
                        type: ValidateType.name
                    );
                  });
                },
                // icon: Icon(Icons.clear),
                controller: _textFullNameController,
              ),
            ),
            //email
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: AppTextInput(
                hintText: Translate.of(context)!.translate('email'),
                errorText: Translate.of(context)!.translate(_validEmail),
                focusNode: _focusEmail,
                textInputAction: TextInputAction.next,
                onTapIcon: () async {
                  await Future.delayed(Duration(milliseconds: 100));
                  _textEmailController.clear();
                },
                onSubmitted: (text) {
                  UtilOther.fieldFocusChange(
                    context,
                    _focusEmail,
                    _focusShopDesc,
                  );
                },
                onChanged: (text) {
                  setState(() {
                    _validEmail = UtilValidator.validate(
                        data: _textEmailController.text,
                        type: ValidateType.email
                    );
                  });
                },
                // icon: Icon(Icons.clear),
                controller: _textEmailController,
              ),
            ),
            //mobile
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: AppTextInput(
                enabled: false,
                hintText: Translate.of(context)!.translate('mobile'),
                errorText: Translate.of(context)!.translate(_validMobile),
                focusNode: _focusMobile,
                textInputAction: TextInputAction.next,
                onTapIcon: () async {
                  await Future.delayed(Duration(milliseconds: 100));
                  _textMobileController.clear();
                },

                onChanged: (text) {
                  setState(() {
                    _validMobile = UtilValidator.validate(
                      data: _textMobileController.text,
                    );
                  });
                },
                // icon: Icon(Icons.clear),
                controller: _textMobileController,
              ),
            ),
            //shop desc
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Text("Shop Details",style: TextStyle(
                  fontSize: 15.0,fontWeight: FontWeight.w600,
                  fontFamily: "Poppins",color: AppTheme.textColor
              ),),
            ),

            //comp name
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: AppTextInput(
                hintText: Translate.of(context)!.translate('input_compName'),
                errorText: Translate.of(context)!.translate(_validCompName),
                focusNode: _focusCompName,
                textInputAction: TextInputAction.next,
                onTapIcon: () async {
                  await Future.delayed(Duration(milliseconds: 100));
                  _textCompNameController.clear();
                },
                onSubmitted: (text) {
                  UtilOther.fieldFocusChange(
                    context,
                    _focusCompName,
                    _focusShopDesc,
                  );
                },
                onChanged: (text) {
                  setState(() {
                    _validCompName = UtilValidator.validate(
                      data: _textCompNameController.text,
                      type: ValidateType.compName
                    );
                  });
                },
                // icon: Icon(Icons.clear),
                controller: _textCompNameController,
              ),
            ),
            //shop desc
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: AppTextInput(
                maxLines: 3,
                hintText: Translate.of(context)!.translate('shop_desc'),
                errorText: Translate.of(context)!.translate(_validShopDesc),
                focusNode: _focusShopDesc,
                textInputAction: TextInputAction.next,
                onTapIcon: () async {
                  await Future.delayed(Duration(milliseconds: 100));
                  _textShopDescController.clear();
                },

                onChanged: (text) {
                  setState(() {
                    _validShopDesc = UtilValidator.validate(
                      data: _textShopDescController.text,
                      type: ValidateType.shopDesc
                    );
                  });
                },
                // icon: Icon(Icons.clear),
                controller: _textShopDescController,
              ),
            ),
            //shop location
            Container(
              margin: EdgeInsets.only(top:8.0),
              // alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                // border: Border.all(color: Theme.of(context).unselectedWidgetColor.withOpacity(0.5)),
                border: Border.all(color: Color(0xFFF5F5F5)),
                // color: Theme.of(context).cardColor,
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Shop or Pickup Location",style: TextStyle(color: AppTheme.textColor,fontSize: 14.0,fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                      onTap: (){

                      },
                        child:Image.asset(Images.myLoc, width: 20.0,
                      height: 20.0,)),
                  ],
                ),
              ),
            )
            // Padding(
            //   padding: const EdgeInsets.only(top:8.0),
            //   child: AppTextInput(
            //     enabled: true,
            //     hintText: Translate.of(context)!.translate('shop_loc'),
            //     errorText: Translate.of(context)!.translate(_validShopLoc),
            //     focusNode: _focusShopLoc,
            //     textInputAction: TextInputAction.next,
            //     onTapIcon: () async {
            //       print("clicked");
            //     },
            //     icon: Image.asset(Images.myLoc, width: 20.0,
            //       height: 20.0,),
            //     onTap: (){
            //
            //     },
            //
            //     onChanged: (text) {
            //       setState(() {
            //         _validShopLoc = UtilValidator.validate(
            //           data: _textShopLocController.text,
            //           type: ValidateType.shopLoc
            //         );
            //       });
            //     },
            //     // icon: Icon(Icons.clear),
            //     controller: _textShopLocController,
            //   ),
            // ),


          ],
        ),
      ),
    );
  }

  //office work
  Widget OfficeWorkWidget(BuildContext context){
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Billing Address",style: TextStyle(
                fontSize: 15.0,fontWeight: FontWeight.w600,
                fontFamily: "Poppins",color: AppTheme.textColor
            ),),
            //bill address
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: AppTextInput(
                maxLines: 3,
                hintText: Translate.of(context)!.translate('curr_address'),
                errorText: Translate.of(context)!.translate(_validCurrAdd),
                focusNode: _focusCurrAddName,
                textInputAction: TextInputAction.next,
                onTapIcon: () async {
                  await Future.delayed(Duration(milliseconds: 100));
                  _textCurrAddController.clear();
                },
                onSubmitted: (text) {
                  UtilOther.fieldFocusChange(
                    context,
                    _focusCurrAddName,
                    _focusPinBillName,
                  );
                },
                onChanged: (text) {
                  setState(() {
                    _validCurrAdd = UtilValidator.validate(
                      data: _textCurrAddController.text,
                      type: ValidateType.currAddress
                    );
                  });
                },
                // icon: Icon(Icons.clear),
                controller: _textCurrAddController,
              ),
            ),
            //bill pincode
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: AppTextInput(
                hintText: Translate.of(context)!.translate('pincode'),
                errorText: Translate.of(context)!.translate(_validPinBill),
                focusNode: _focusPinBillName,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,

                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                onTapIcon: () async {
                  await Future.delayed(Duration(milliseconds: 100));
                  _textPinBillController.clear();
                },
                onSubmitted: (text) {
                  UtilOther.fieldFocusChange(
                    context,
                    _focusPinBillName,
                    _focusWorkAdd,
                  );
                },
                onChanged: (text) {
                  setState(() {
                    _validPinBill = UtilValidator.validate(
                      data: _textPinBillController.text,
                      type: ValidateType.pincode
                    );
                  });
                },
                // icon: Icon(Icons.clear),
                controller: _textPinBillController,
              ),
            ),
            //for state
            Container(
                margin: EdgeInsets.only(
                  top: 15.0,
                ),
                decoration: BoxDecoration(
                  // border: Border.all(color: Theme.of(context).unselectedWidgetColor.withOpacity(0.5)),
                  border: Border.all(color: Color(0xFFF5F5F5)),
                  // color: Theme.of(context).cardColor,
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          hint: _dropDownValue == null
                              ? Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                'State',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                    fontFamily: 'Poppins'),
                              ))
                              : Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                _dropDownValue,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                    fontFamily: 'Poppins'),
                              )),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: TextStyle(color: Colors.black),
                          items: stateItems.map(
                                (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(
                                  val,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                      fontFamily: 'Poppins'),
                                ),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            setState(
                                  () {
                                _dropDownValue = val;
                                print(_dropDownValue);
                              },
                            );
                          },
                        )))),
            //for city
            Container(
                margin: EdgeInsets.only(
                  top: 15.0,
                ),
                decoration: BoxDecoration(
                  // border: Border.all(color: Theme.of(context).unselectedWidgetColor.withOpacity(0.5)),
                  border: Border.all(color: Color(0xFFF5F5F5)),
                  // color: Theme.of(context).cardColor,
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          hint: dropdownCityValue == null
                              ? Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                'City',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                    fontFamily: 'Poppins'),
                              ))
                              : Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                dropdownCityValue,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                    fontFamily: 'Poppins'),
                              )),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: TextStyle(color: Colors.black),
                          items: cityItems.map(
                                (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(
                                  val,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                      fontFamily: 'Poppins'),
                                ),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            setState(
                                  () {
                                dropdownCityValue = val;
                                print(dropdownCityValue);
                              },
                            );
                          },
                        )))),
            //country
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: AppTextInput(
                enabled: false,
                hintText: Translate.of(context)!.translate('country'),
                errorText: Translate.of(context)!.translate(_validBillCountry),
                textInputAction: TextInputAction.next,

                // icon: Icon(Icons.clear),
                controller: _textCountryBillController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Text("Work Address",style: TextStyle(
                  fontSize: 15.0,fontWeight: FontWeight.w600,
                  fontFamily: "Poppins",color: AppTheme.textColor
              ),),
            ),
            //work location
            Container(
              margin: EdgeInsets.only(top:8.0,bottom: 8.0),
              // alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                // border: Border.all(color: Theme.of(context).unselectedWidgetColor.withOpacity(0.5)),
                border: Border.all(color: Color(0xFFF5F5F5)),
                // color: Theme.of(context).cardColor,
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Work Location",style: TextStyle(color: AppTheme.textColor,fontSize: 14.0,fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                        onTap: (){

                        },
                        child:Image.asset(Images.myLoc, width: 20.0,
                          height: 20.0,color: AppTheme.redColor,)),
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top:8.0),
            //   child:
            //   AppTextInput(
            //     hintText: Translate.of(context)!.translate('work_loc'),
            //     errorText: Translate.of(context)!.translate(_validWorkLoc),
            //     focusNode: _focusWorkLoc,
            //     textInputAction: TextInputAction.next,
            //     onTapIcon: () async {
            //       await Future.delayed(Duration(milliseconds: 100));
            //       _textWorkLocController.clear();
            //     },
            //     onSubmitted: (text) {
            //       UtilOther.fieldFocusChange(
            //         context,
            //         _focusWorkLoc,
            //         _focusWorkAdd,
            //       );
            //     },
            //     icon:Icon(Icons.location_searching,color: Colors.red,),
            //     onChanged: (text) {
            //       setState(() {
            //         _validWorkLoc = UtilValidator.validate(
            //           data: _textWorkLocController.text,
            //           type: ValidateType.workLoc
            //         );
            //       });
            //     },
            //     // icon: Icon(Icons.clear),
            //     controller: _textWorkLocController,
            //   ),
            // ),
            //work address
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: AppTextInput(
                maxLines: 3,
                hintText: Translate.of(context)!.translate('work_address'),
                errorText: Translate.of(context)!.translate(_validWorkAdd),
                focusNode: _focusWorkAdd,
                textInputAction: TextInputAction.next,
                onTapIcon: () async {
                  await Future.delayed(Duration(milliseconds: 100));
                  _textWorkAddController.clear();
                },
                onSubmitted: (text) {
                  UtilOther.fieldFocusChange(
                    context,
                    _focusWorkAdd,
                    _focusWorkPin,
                  );
                },
                onChanged: (text) {
                  setState(() {
                    _validWorkAdd = UtilValidator.validate(
                      data: _textWorkAddController.text,
                      type: ValidateType.workkAddress
                    );
                  });
                },
                // icon: Icon(Icons.clear),
                controller: _textWorkAddController,
              ),
            ),
            //work pincode
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: AppTextInput(
                hintText: Translate.of(context)!.translate('pincode'),
                errorText: Translate.of(context)!.translate(_validWorkPin),
                focusNode: _focusWorkPin,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                textInputAction: TextInputAction.next,
                onTapIcon: () async {
                  await Future.delayed(Duration(milliseconds: 100));
                  _textWorkPinController.clear();
                },

                onChanged: (text) {
                  setState(() {
                    _validWorkPin = UtilValidator.validate(
                        data: _textWorkPinController.text,
                        type: ValidateType.pincode
                    );
                  });
                },
                // icon: Icon(Icons.clear),
                controller: _textWorkPinController,
              ),
            ),
            //for state
            Container(
                margin: EdgeInsets.only(
                  top: 15.0,
                ),
                decoration: BoxDecoration(
                  // border: Border.all(color: Theme.of(context).unselectedWidgetColor.withOpacity(0.5)),
                  border: Border.all(color: Color(0xFFF5F5F5)),
                  // color: Theme.of(context).cardColor,
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          hint: _dropDownValue == null
                              ? Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                'State',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                    fontFamily: 'Poppins'),
                              ))
                              : Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                _dropDownValue,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                    fontFamily: 'Poppins'),
                              )),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: TextStyle(color: Colors.black),
                          items: stateItems.map(
                                (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(
                                  val,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                      fontFamily: 'Poppins'),
                                ),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            setState(
                                  () {
                                _dropDownValue = val;
                                print(_dropDownValue);
                              },
                            );
                          },
                        )))),
            //for city
            Container(
                margin: EdgeInsets.only(
                  top: 15.0,
                ),
                decoration: BoxDecoration(
                  // border: Border.all(color: Theme.of(context).unselectedWidgetColor.withOpacity(0.5)),
                  border: Border.all(color: Color(0xFFF5F5F5)),
                  // color: Theme.of(context).cardColor,
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          hint: dropdownCityValue == null
                              ? Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                'City',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                    fontFamily: 'Poppins'),
                              ))
                              : Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                dropdownCityValue,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0,
                                    fontFamily: 'Poppins'),
                              )),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: TextStyle(color: Colors.black),
                          items: cityItems.map(
                                (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(
                                  val,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                      fontFamily: 'Poppins'),
                                ),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            setState(
                                  () {
                                    dropdownCityValue = val;
                                print(dropdownCityValue);
                              },
                            );
                          },
                        )))),
            //work country
            AppTextInput(
              enabled: false,
              hintText: Translate.of(context)!.translate('country'),
              errorText: Translate.of(context)!.translate(_valiWorkCountry),
              textInputAction: TextInputAction.next,

              // icon: Icon(Icons.clear),
              controller: _textCountryWorkController,
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Text("Tax Details",style: TextStyle(
                  fontSize: 15.0,fontWeight: FontWeight.w600,
                  fontFamily: "Poppins",color: AppTheme.textColor
              ),),
            ),
            Container(
                margin: EdgeInsets.only(top:10.0),

                child:
                Column(
                  children: [
                    Row(
                      children: [
                        Theme(
                            data: ThemeData(
                              unselectedWidgetColor:Colors.grey,
                              // selectedRowColor: AppTheme.redColor
                            ),
                            child: Radio<String>(
                              value: "0",
                              fillColor:
                              MaterialStateColor.resolveWith((states) => AppTheme.redColor),
                              groupValue: verification,
                              onChanged: (String? value) {
                                setState(() {
                                  verification = value!;
                                });

                              },
                            )),
                        Text(
                          'I have GSTIN number',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                              color: AppTheme.textColor
                          ),
                        ),

                      ],
                    ),
                    Row(
                      children: [
                        Theme(
                            data: ThemeData(
                                unselectedWidgetColor: Colors.grey,
                                selectedRowColor: AppTheme.redColor
                            ),
                            child: Radio<String>(
                              value: "1",
                              fillColor:
                              MaterialStateColor.resolveWith((states) => AppTheme.redColor),
                              groupValue: verification,
                              onChanged: (String? value) {
                                setState(() {
                                  verification = value!;
                                  // controller.onChangehasgst;
                                });
                              },
                            )),
                        Text(
                          'I dont have GSTIN number',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppTheme.textColor
                          ),
                        ),
                      ],
                    )

                  ],
                )
            ),
            //provision gstin
            if(verification=="1")
              AppTextInput(
                hintText: Translate.of(context)!.translate('prov_gstin'),
                errorText: Translate.of(context)!.translate(_validProvGst),
                textInputAction: TextInputAction.next,

                onChanged: (text) {
                  setState(() {
                    _validProvGst = UtilValidator.validate(
                        data: _textProvGstController.text,
                        type: ValidateType.provGst
                    );
                  });
                },
                // icon: Icon(Icons.clear),
                controller: _textProvGstController,
              ),
          ],
        ),
      ),
    );
  }

  //bank details
  Widget bankDetWidget(BuildContext context){
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Bank Details",style: TextStyle(
                fontSize: 15.0,fontWeight: FontWeight.w600,
                fontFamily: "Poppins",color: AppTheme.textColor
            ),),
            //acnt holder name
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child:
              AppTextInput(
                hintText: Translate.of(context)!.translate('accnt_holder'),
                errorText: Translate.of(context)!.translate(_validAcntHolder),
                focusNode: _focusAcntHolderName,
                textInputAction: TextInputAction.next,
                onTapIcon: () async {
                  await Future.delayed(Duration(milliseconds: 100));
                  _textAccntHolderontroller.clear();
                },
                onSubmitted: (text) {
                  UtilOther.fieldFocusChange(
                    context,
                    _focusAcntHolderName,
                    _focusAcntType,
                  );
                },
                onChanged: (text) {
                  setState(() {
                    _validAcntHolder = UtilValidator.validate(
                      data: _textAccntHolderontroller.text,
                    );
                  });
                },
                // icon: Icon(Icons.clear),
                controller: _textAccntHolderontroller,
              ),
            ),
            //account type
            AppTextInput(
              hintText: Translate.of(context)!.translate('accnt_type'),
              errorText: Translate.of(context)!.translate(_validAcntType),
              focusNode: _focusAcntType,
              textInputAction: TextInputAction.next,
              onTapIcon: () async {
                await Future.delayed(Duration(milliseconds: 100));
                _textAcntTypeController.clear();
              },
              onSubmitted: (text) {
                UtilOther.fieldFocusChange(
                  context,
                  _focusAcntType,
                  _focusAcntNum,
                );
              },
              onChanged: (text) {
                setState(() {
                  _validAcntType = UtilValidator.validate(
                    data: _textAcntTypeController.text,
                  );
                });
              },
              // icon: Icon(Icons.clear),
              controller: _textAcntTypeController,
            ),
            //account number
            AppTextInput(
              hintText: Translate.of(context)!.translate('accnt_num'),
              errorText: Translate.of(context)!.translate(_validAcntNum),
              focusNode: _focusAcntNum,
              textInputAction: TextInputAction.next,
              onTapIcon: () async {
                await Future.delayed(Duration(milliseconds: 100));
                _textAcntNumController.clear();
              },
              onSubmitted: (text) {
                UtilOther.fieldFocusChange(
                  context,
                  _focusAcntNum,
                  _focusReEnterAcntNum,
                );
              },
              onChanged: (text) {
                setState(() {
                  _validAcntNum = UtilValidator.validate(
                    data: _textAcntNumController.text,
                  );
                });
              },
              // icon: Icon(Icons.clear),
              controller: _textAcntNumController,
            ),
            //re enter accnt num
            AppTextInput(
              hintText: Translate.of(context)!.translate('accnt_re_num'),
              errorText: Translate.of(context)!.translate(_validReAcntNum),
              focusNode: _focusReEnterAcntNum,
              textInputAction: TextInputAction.next,
              onTapIcon: () async {
                await Future.delayed(Duration(milliseconds: 100));
                _textReEnterAcntNumController.clear();
              },
              onSubmitted: (text) {
                UtilOther.fieldFocusChange(
                  context,
                  _focusReEnterAcntNum,
                  _focusIFSC,
                );
              },
              onChanged: (text) {
                setState(() {
                  _validReAcntNum = UtilValidator.validate(
                    data: _textReEnterAcntNumController.text,
                  );
                });
              },
              // icon: Icon(Icons.clear),
              controller: _textReEnterAcntNumController,
            ),
            //ifsc code
            AppTextInput(
              hintText: Translate.of(context)!.translate('ifsc'),
              errorText: Translate.of(context)!.translate(_validIFSC),
              focusNode: _focusIFSC,
              textInputAction: TextInputAction.next,
              onTapIcon: () async {
                await Future.delayed(Duration(milliseconds: 100));
                _textIFSCController.clear();
              },
              onSubmitted: (text) {
                UtilOther.fieldFocusChange(
                  context,
                  _focusIFSC,
                  _focusUPI,
                );
              },
              onChanged: (text) {
                setState(() {
                  _validIFSC = UtilValidator.validate(
                    data: _textIFSCController.text,
                  );
                });
              },
              // icon: Icon(Icons.clear),
              controller: _textIFSCController,
            ),
            //upi id
            AppTextInput(
              hintText: Translate.of(context)!.translate('upi_id'),
              errorText: Translate.of(context)!.translate(_validUPI),
              focusNode: _focusUPI,
              textInputAction: TextInputAction.next,
              onTapIcon: () async {
                await Future.delayed(Duration(milliseconds: 100));
                _textUPIIDController.clear();
              },

              onChanged: (text) {
                setState(() {
                  _validUPI = UtilValidator.validate(
                    data: _textUPIIDController.text,
                  );
                });
              },
              // icon: Icon(Icons.clear),
              controller: _textUPIIDController,
            ),
          ],
        ),
      ),
    );
  }


}




