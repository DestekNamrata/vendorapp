import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vendorapp/Config/theme.dart';
import 'package:vendorapp/Utils/utilOther.dart';

import '../../Utils/translate.dart';
import '../../Utils/validate.dart';
import '../../Widget/app_text_input.dart';
import '../../Widget/stepper_button.dart';

class BasicInfo extends StatefulWidget{
  var currStep;
  bool completed;
  BasicInfo({Key? key,this.currStep,required this.completed}):super(key: key);

  @override
  State<BasicInfo> createState() => BasicInfoState();
}

class BasicInfoState extends State<BasicInfo>{
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

  void ValidateBasicInfo(){
    UtilOther.hiddenKeyboard(context);
    setState(() {
      _validFullName = UtilValidator.validate(
          data: _textFullNameController.text,
        type: ValidateType.name
      );
      if (_validFullName=="") {
        print("validate");
        // _loginBloc.add(OnLogin(custId: _textMobileController.text,custPwd: _textPasswordController.text,
        //     fcmToken: fcmToken));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
            AppTextInput(
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
                    );
                  });
                },
                // icon: Icon(Icons.clear),
                controller: _textCompNameController,
              ),
            ),
            //shop desc
            AppTextInput(
              maxLines: 5,
              hintText: Translate.of(context)!.translate('shop_desc'),
              errorText: Translate.of(context)!.translate(_validShopDesc),
              focusNode: _focusCompName,
              textInputAction: TextInputAction.next,
              onTapIcon: () async {
                await Future.delayed(Duration(milliseconds: 100));
                _textShopDescController.clear();
              },

              onChanged: (text) {
                setState(() {
                  _validShopDesc = UtilValidator.validate(
                    data: _textShopDescController.text,
                  );
                });
              },
              // icon: Icon(Icons.clear),
              controller: _textCompNameController,
            ),
            //shop location
            AppTextInput(
              enabled: true,
              hintText: Translate.of(context)!.translate('shop_loc'),
              errorText: Translate.of(context)!.translate(_validShopLoc),
              focusNode: _focusShopLoc,
              textInputAction: TextInputAction.next,
              onTapIcon: () async {
                print("clicked");
              },
              icon: Icon(Icons.location_searching),
              onTap: (){

              },

              onChanged: (text) {
                setState(() {
                  _validShopLoc = UtilValidator.validate(
                    data: _textShopLocController.text,
                  );
                });
              },
              // icon: Icon(Icons.clear),
              controller: _textShopLocController,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                if (widget.currStep != 0)
                  Expanded(child:StepperButton(
                    onPressed: () async {
                      if (widget.currStep == 0) {
                        ValidateBasicInfo();
                        return;
                      }

                      setState(() {
                        widget.currStep -= 1;
                      });
                    },
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.all(Radius.circular(50))),
                    text: 'Previous',
                    loading: true,
                  )),
                // Expanded(child:StepperButton(
                //
                //   onPressed: () async {
                //     final isLastStep = widget.currStep == widget.stepList!.length - 1;
                //     if(isLastStep)
                //     {
                //       setState(() {
                //         widget.completed = true;
                //       });
                //     }
                //     else
                //     {
                //       setState(() {
                //         widget.currStep += 1;
                //       });
                //     }
                //   },
                //   shape: const RoundedRectangleBorder(
                //       borderRadius:
                //       BorderRadius.all(Radius.circular(50))),
                //   text: 'Continue',
                //   loading: true,
                // )),
              ],
            ),

          ],
        ),
      ),
    );
  }

}