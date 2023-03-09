import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppMobileInput extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final VoidCallback? onTapIcon;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final Icon? icon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  var errorText;
  final int? maxLines;
  final int? maxLength;
  final bool? enabled;
  final String? prefix;
  final String? prefixIconText;

  final List<TextInputFormatter>? inputFormatters; //added on 23/02/2021


  AppMobileInput({
    Key? key,
    this.hintText,
    this.controller,
    this.focusNode,
    this.onTapIcon,
    this.onChanged,
    this.onSubmitted,
    this.icon,
    this.keyboardType,
    this.textInputAction,
    this.errorText,
    this.maxLines = 1,
    this.maxLength,
    this.inputFormatters,
    this.enabled,
    this.prefix,
    this.prefixIconText
  }) : super(key: key);

  Widget _buildErrorLabel(BuildContext context) {
    if (errorText == null) {
      return Container();
    }

    return Container(
      padding: EdgeInsets.only(top:5.0),
      child: Align(
        alignment: Alignment.topLeft,
        child:
        Text(
          errorText,
          style: Theme.of(context)
              .textTheme
              .caption!
              .copyWith(color: Theme.of(context).errorColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            // border: Border.all(color: Theme.of(context).unselectedWidgetColor.withOpacity(0.5)),
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[

              TextField(
                readOnly: false,
                enabled:enabled ,
                // textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                onSubmitted: onSubmitted,
                inputFormatters:inputFormatters,
                controller: controller,
                focusNode: focusNode,
                onChanged: onChanged,
                keyboardType: keyboardType,
                textInputAction: textInputAction,
                maxLines: maxLines,
                maxLength: maxLength,
                style: TextStyle(color: Colors.black,fontSize: 14.0,fontWeight: FontWeight.w500),
                decoration: InputDecoration(
                  counterText: "",
                  hintStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                      color: Colors.black45),
                  hintText: hintText,
                  prefixIcon: Padding(padding: EdgeInsets.only(left:15,top:13.0,bottom:13.8,right: 5.0),
                      child: Text(prefixIconText ?? "",
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 14.0),)),
                    prefixIconConstraints: BoxConstraints(maxWidth: 50),

            prefix: Text(
                    prefix ?? "",
                    style:TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 13.0),
                  ),
                  suffixIcon: icon != null
                      ?
                  IconButton(
                    icon: icon!,
                    onPressed: onTapIcon,
                  )
                      : null,
                  border: InputBorder.none,

                ),
              )

              // _buildErrorLabel(context)
            ],
          ),
        ),
        _buildErrorLabel(context)
      ],
    );

  }
}
