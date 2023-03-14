enum ValidateType {
  normal,
  email,
  password,
  phone,
  pincode,
  confirmpass,
  incorrectCnfPass,
  age,
  name,
  compName,
  shopDesc,
  shopLoc,
  currAddress,
  workkAddress,
  workLoc,
  provGst,
  accntNum,
  reaccntNum,
  ifsc,
  upi

}

class UtilValidator {
  static const String error_empty = "value_not_empty";
  static const String error_empty_mobile = "value_not_empty_mobile";
  static const String pass_empty = "value_not_valid_password";
  static const String cnfpass_empty = "value_not_valid_cnfpassword";
  static const String error_range = "value_not_valid_range";
  static const String error_email = "Please enter valid email Id";
  static const String error_phone = "value_not_valid_phone";
  static const String max_phone = "Number should have atleast 10 digit";
  static const String passWordLength = "Password Should be Atleast 7 digit";
  static const String incorrectCnfPassMsg = "Confirm password should be same as New Password";
  static const String ageValid = "Please enter valid Age between 18-60 yrs";
  static const String pincode = "Please enter valid pincode";
  static const String name = "Please enter full name";
  static const String compname = "Please enter company/business name";
  static const String shopDesc = "Please enter shop description";
  static const String shopLoc = "Please enter shop location";
  static const String currAddress = "Please enter current address";
  static const String workAddress = "Please enter work address";
  static const String workLoc = "Please enter work location";
  static const String provGstNum = "Please enter valid provisional GSTIN number";
  static const String accntNum = "Please enter valid Account Number";
  static const String re_accntNum = "Account number does not Match with Re-entered account number";
  static const String ifsccode= "Please enter valid IFSC code";
  static const String upi= "Please enter UPI Id";


  static const String error_match = "value_not_match";

  static validate({
    String? data,
    String? cnfData,
    ValidateType type = ValidateType.normal,
    int? min,
    int? max,
    bool allowEmpty = false,
    String? match,
    bool allowEmptyPass=false,
    String flagInput=""
  }) {
    ///Empty
    if(flagInput=="mobile") {
      if (!allowEmpty && data!.isEmpty) {
        return error_empty_mobile;
      }
    }

    ///Match
    if (match != null && data != match) {
      return error_match;
    }

    if (min != null &&
        max != null &&
        (data!.length < min || data!.length > max)) {
      return '$error_range ($min-$max)';
    }

    switch (type) {
      case ValidateType.email:

        ///More pattern
        final Pattern _emailPattern =
            r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$";
        if (!RegExp(_emailPattern.toString()).hasMatch(data!)) {
          return error_email;
        }else{
          return "";
        }
        break;

      case ValidateType.phone:
        if(data!.length!=10)
          return max_phone;
        return "";
      break;

      // case ValidateType.password:
      //   if(data.length<7)
      //     return passWordLength;
      //   return null;
      //   break;

      case ValidateType.password:
        if(data!.isEmpty)
          return pass_empty;
        return null;
        break;

      case ValidateType.confirmpass:
        if(data!.length<7)
          return passWordLength;
        return null;
        break;

      case ValidateType.incorrectCnfPass:
        if(data!=cnfData)
          return incorrectCnfPassMsg;
        return null;
        break;

        //added on 23/12/2020 for age
      case ValidateType.age:
        var datas = int.parse(data!);
        if(datas<18 || datas>60)
          return ageValid;
        return null;
        break;

      case ValidateType.pincode:
        if(data!.length==6)
        return "";
        return pincode;

        break;
      case ValidateType.name:
        if(data!="")
          return "";
        return name;

        break;
      case ValidateType.compName:
        if(data!="")
          return "";
        return compname;

        break;

      case ValidateType.shopDesc:
        if(data!="")
          return "";
        return shopDesc;

        break;
      case ValidateType.shopLoc:
        if(data!="")
          return "";
        return shopLoc;

        break;
      case ValidateType.currAddress:
        if(data!="")
          return "";
        return currAddress;
        break;

      case ValidateType.workkAddress:
        if(data!="")
          return "";
        return workAddress;
        break;

      case ValidateType.workLoc:
        if(data!="")
          return "";
        return workLoc;
        break;

      case ValidateType.provGst:
        final Pattern _gstPattern =
        "\d{2}[A-Z]{5}\d{4}[A-Z]{1}[A-Z\d]{1}[Z]{1}[A-Z\d]{1}";
        if (!RegExp(_gstPattern.toString()).hasMatch(data!)) {
          return provGstNum;
        }else{
          return "";
        }

        break;

      case ValidateType.accntNum:
        final Pattern accntNumPattern =
            "[0-9]{9,18}";
        if (!RegExp(accntNumPattern.toString()).hasMatch(data!)) {
          return accntNum;
        }else{
          return "";
        }
        break;
      case ValidateType.reaccntNum:
       if(data!=accntNum){
         return re_accntNum;
       }else{
         return "";
       }
        break;

      case ValidateType.ifsc:
        final Pattern ifscPattern =
            r"^[A-Z]{4}0[A-Z0-9]{6}$";
        if (!RegExp(ifscPattern.toString()).hasMatch(data!)) {
          return ifsccode;
        }else{
          return "";
        }
        break;

      case ValidateType.upi:
        final Pattern upiPattern =
        r"^[a-zA-Z0-9.-]{2, 256}@[a-zA-Z][a-zA-Z]{2, 64}$";
        if (!RegExp(upiPattern.toString()).hasMatch(data!)) {
          return upi;
        }else{
          return "";
        }

        break;

      default:
        return "";
        // return null;
    }
  }

  ///Singleton factory
  static final UtilValidator _instance = UtilValidator._internal();

  factory UtilValidator() {
    return _instance;
  }

  UtilValidator._internal();
}
