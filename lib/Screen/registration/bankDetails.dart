import 'package:flutter/cupertino.dart';

import '../../Config/theme.dart';
import '../../Utils/translate.dart';
import '../../Utils/utilOther.dart';
import '../../Utils/validate.dart';
import '../../Widget/app_text_input.dart';

class BankDetails extends StatefulWidget{
  var currStep;
  BankDetails({Key? key,this.currStep}):super(key: key);

  _BankDetailsState createState()=>_BankDetailsState();
}

class _BankDetailsState extends State<BankDetails>{
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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