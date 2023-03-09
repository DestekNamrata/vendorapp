import 'dart:async';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vendorapp/Screen/registration/bankDetails.dart';
import 'package:vendorapp/Screen/registration/basic_info.dart';

import '../../Config/font.dart';
import '../../Widget/app_button.dart';
import '../../Widget/stepper_button.dart';
import '../user/login_screen.dart';
import 'officeWorkAdd.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  String dropdownValue = '+ 91';
  String? phoneNum;
  String? role;
  bool loading = true;
  int _currentStep = 0;
  bool isCompleted = false;



  List<Step> stepList() => [
    Step(
      state: _currentStep <= 0 ? StepState.indexed : StepState.complete,
      // state: _currentStep <= 0 ? Icon(Icons.circle): StepState.complete,
      isActive: _currentStep >= 0,
      title: Text('Basic Info',style:  TextStyle(fontSize: 12.0),),
      content: BasicInfo(currStep:_currentStep,completed:isCompleted),
    ),
    Step(
      state: _currentStep <= 1 ? StepState.indexed : StepState.complete,
      isActive: _currentStep >= 1,
      title: Text('Office & Work',style:  TextStyle(fontSize: 12.0),),
      content: OfficeWorkAddress(currStep:_currentStep),
    ),
    Step(
      state: StepState.complete,
      isActive: _currentStep >= 2,
      title: Text('Bank Details',style: TextStyle(fontSize: 12.0),),
      content: BankDetails(currStep:_currentStep),
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
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: <Widget>[
                //     if (_currentStep != 0)
                //       Expanded(child:StepperButton(
                //         onPressed: () async {
                //           if (_currentStep == 0) {
                //             return;
                //           }
                //
                //           setState(() {
                //             _currentStep -= 1;
                //           });
                //         },
                //         shape: const RoundedRectangleBorder(
                //             borderRadius:
                //             BorderRadius.all(Radius.circular(50))),
                //         text: 'Previous',
                //         loading: loading,
                //       )),
                //     Expanded(child:StepperButton(
                //
                //       onPressed: () async {
                //         final isLastStep = _currentStep == stepList().length - 1;
                //         if(isLastStep)
                //         {
                //           setState(() {
                //             isCompleted = true;
                //           });
                //         }
                //         else
                //         {
                //           setState(() {
                //             _currentStep += 1;
                //           });
                //         }
                //       },
                //       shape: const RoundedRectangleBorder(
                //           borderRadius:
                //           BorderRadius.all(Radius.circular(50))),
                //       text: 'Continue',
                //       loading: loading,
                //     )),
                //   ],
                // ),
                Text("")
              );
            },

                )),


        ),
      
    );
  }

}




