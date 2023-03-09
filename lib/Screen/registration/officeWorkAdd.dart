import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Config/theme.dart';
import '../../Utils/translate.dart';
import '../../Utils/utilOther.dart';
import '../../Utils/validate.dart';
import '../../Widget/app_text_input.dart';

class OfficeWorkAddress extends StatefulWidget{
  var currStep;
  OfficeWorkAddress({Key? key,this.currStep}):super(key: key);

  _OfficeWorkAddressState createState()=>_OfficeWorkAddressState();
}

class _OfficeWorkAddressState extends State<OfficeWorkAddress>{
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                maxLines: 4,
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
                    );
                  });
                },
                // icon: Icon(Icons.clear),
                controller: _textCurrAddController,
              ),
            ),
            //bill pincode
            AppTextInput(
              hintText: Translate.of(context)!.translate('pincode'),
              errorText: Translate.of(context)!.translate(_validPinBill),
              focusNode: _focusPinBillName,
              textInputAction: TextInputAction.next,
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
                  );
                });
              },
              // icon: Icon(Icons.clear),
              controller: _textPinBillController,
            ),
            //country
            AppTextInput(
              enabled: false,
              hintText: Translate.of(context)!.translate('country'),
              errorText: Translate.of(context)!.translate(_validBillCountry),
              textInputAction: TextInputAction.next,

              // icon: Icon(Icons.clear),
              controller: _textCountryBillController,
            ),
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: Text("Work Address",style: TextStyle(
                  fontSize: 15.0,fontWeight: FontWeight.w600,
                  fontFamily: "Poppins",color: AppTheme.textColor
              ),),
            ),
            //work location
            Padding(
              padding: const EdgeInsets.only(top:8.0),
              child:
              AppTextInput(
                hintText: Translate.of(context)!.translate('work_loc'),
                errorText: Translate.of(context)!.translate(_validWorkLoc),
                focusNode: _focusWorkLoc,
                textInputAction: TextInputAction.next,
                onTapIcon: () async {
                  await Future.delayed(Duration(milliseconds: 100));
                  _textWorkLocController.clear();
                },
                onSubmitted: (text) {
                  UtilOther.fieldFocusChange(
                    context,
                    _focusWorkLoc,
                    _focusWorkAdd,
                  );
                },
                icon:Icon(Icons.location_searching,color: Colors.red,),
                onChanged: (text) {
                  setState(() {
                    _validWorkLoc = UtilValidator.validate(
                      data: _textWorkLocController.text,
                    );
                  });
                },
                // icon: Icon(Icons.clear),
                controller: _textWorkLocController,
              ),
            ),
            //work address
            AppTextInput(
              maxLines: 4,
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
                  );
                });
              },
              // icon: Icon(Icons.clear),
              controller: _textWorkLocController,
            ),
            //work pincode
            AppTextInput(
              hintText: Translate.of(context)!.translate('pincode'),
              errorText: Translate.of(context)!.translate(_validWorkPin),
              focusNode: _focusWorkPin,
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

              // icon: Icon(Icons.clear),
              controller: _textProvGstController,
            ),
          ],
        ),
      ),
    );
  }

}