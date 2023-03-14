import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vendorapp/Config/image.dart';
import 'package:vendorapp/Config/theme.dart';
import 'package:intl/intl.dart';

import '../../Utils/translate.dart';
import '../../Widget/app_button.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';


class DashBoardScreen extends StatefulWidget{
  _DashBoardScreenState createState()=>_DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen>{

  String dateTime = "",allTimeTitle="All Time";
  final _textStartDateController = TextEditingController();
  final _textEndDateController = TextEditingController();
  var _validStartDate, _validEndDate;
  final _focusStartDate = FocusNode();
  final _focusEndDate = FocusNode();
  var _dropDownValue;
  var timeItems = [
    'Last Week',
    'Last Month',
    'Last Year'
  ];
  Future _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate:DateTime(1970),
      lastDate: DateTime.now(),
    );

    print(picked);

    if (picked != null)
      setState(() {
        dateTime = DateFormat("yyyy-MM-dd").format(picked);
        _textStartDateController.text=dateTime;
      });
  }

  showBottomDialogForAllTime(BuildContext context){
    return
      showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: false,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0))),
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            // padding: EdgeInsets.all(10.0),
            child: DropDownAllTime(title:_dropDownValue)
          );

        });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;


    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.7;
    final double itemWidth = size.width / 2;
    // TODO: implement build
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () async{
                // showBottomDialogForAllTime(context);
                String result=await showModalBottomSheet(
                    isScrollControlled: true,
                    isDismissible: false,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0))),
                    context: context,
                    builder: (BuildContext context) {
                      return Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          // padding: EdgeInsets.all(10.0),
                          child: DropDownAllTime(title: allTimeTitle,)
                      );

                    });
                if(result!=null){
                 setState(() {
                   allTimeTitle=result;
                 });
                }

              },
                child:ListTile(tileColor:Color(0xFFF5F5F5),title: Text(allTimeTitle,style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w500,
                color:AppTheme.textColor),),
                  trailing: Icon(Icons.arrow_drop_down),)
            ),


    GridView.count(
              primary: false,
              padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              crossAxisCount: 2,
              childAspectRatio: (itemWidth / itemHeight),
              // childAspectRatio: .7,
              shrinkWrap: true,
              children: <Widget>[
                InkWell(
                  onTap: (){
                    print("clicked");
                  },
                    child:Container(
                  decoration: BoxDecoration(
                      color: Colors.white,

                      image: DecorationImage(
                          image: AssetImage(Images.dashBg),
                          fit: BoxFit.fill
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25.0,bottom: 5),
                    child: Column(
                      children: [
                        Text("3054",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 24,
                              color: Color(0xFF062C56),
                              fontWeight: FontWeight.w500
                          ),),
                        Text("Total Products",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: Color(0xFF062C56).withOpacity(0.8),

                              fontWeight: FontWeight.w500
                          ),),
                        Spacer(
                          flex: 3,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('More Info',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',

                                  fontSize: 12,
                                  fontWeight: FontWeight.w500
                              ),),
                            Icon(Icons.arrow_circle_right_outlined,color: Colors.white,size: 16.0,)
                          ],
                        )

                      ],
                    ),
                  ),
                )),
                InkWell(
                  onTap: (){},
                    child:Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Images.dashBg),
                          fit: BoxFit.fill
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25.0,bottom: 5),
                    child: Column(
                      children: [
                        Text("\u{20B9}30.1K",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 24,
                              color: Color(0xFF062C56),
                              fontWeight: FontWeight.w500
                          ),),
                        Text("Total Sale",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: Color(0xFF062C56).withOpacity(0.8),

                              fontWeight: FontWeight.w500
                          ),),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('More Info',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',

                                  fontSize: 12,
                                  fontWeight: FontWeight.w500
                              ),),
                            Icon(Icons.arrow_circle_right_outlined,color: Colors.white,size: 16.0,)
                          ],
                        )
                      ],
                    ),
                  ),
                )),

                InkWell(
                  onTap: (){},
                    child:Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Images.dashBg),
                          fit: BoxFit.fill
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25.0,bottom: 5),
                    child: Column(
                      children: [
                        Text("214",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 24,
                              color: Color(0xFF062C56),

                              fontWeight: FontWeight.w500
                          ),),
                        Text("Total Orders",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: Color(0xFF062C56).withOpacity(0.8),
                              fontWeight: FontWeight.w500
                          ),),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('More Info',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',

                                  fontSize: 12,
                                  fontWeight: FontWeight.w500
                              ),),
                            Icon(Icons.arrow_circle_right_outlined,color: Colors.white,size: 16.0,)
                          ],
                        )
                      ],
                    ),
                  ),
                )),

                InkWell(
                  onTap: (){},
                    child:Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(Images.dashBg),
                          fit: BoxFit.fill
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 25.0,bottom: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("13",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 24,
                              color: Color(0xFF062C56),
                              fontWeight: FontWeight.w500
                          ),),
                        Text("Return & Refund Orders",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              color: Color(0xFF062C56).withOpacity(0.8),

                              fontWeight: FontWeight.w600
                          ),),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('More Info',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',

                                  fontSize: 12,
                                  fontWeight: FontWeight.w500
                              ),),
                            Icon(Icons.arrow_circle_right_outlined,color: Colors.white,size: 16.0,)
                          ],
                        )
                      ],
                    ),
                  ),
                )),


              ],
            ),
            SizedBox(height: 25.0,),

            Padding(
              padding: const EdgeInsets.only(left:10.0,right: 10.0),
              child: Text("Latest Orders",style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
                color: Colors.black
              ),),
            ),
            SizedBox(height: 25.0,),
            ListView.builder(
                itemCount: 10,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  return InkWell(
                    onTap: (){
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>ServiceProviderProfileScreen()));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width ,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        // color: Colors.white70,
                        elevation: 5,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width * 0.28,
                                  maxHeight: MediaQuery.of(context).size.width * 0.28,
                                ),
                                child: CachedNetworkImage(
                                  filterQuality: FilterQuality.medium,
                                  // imageUrl: Api.PHOTO_URL + widget.users.avatar,
                                  imageUrl: "https://picsum.photos/250?image=9",
                                  // imageUrl: myTaskData.machineImg == null
                                  //     ? "https://picsum.photos/250?image=9"
                                  //     : myTaskData.machineImg.toString(),
                                  placeholder: (context, url) {
                                    return Shimmer.fromColors(
                                      baseColor: Theme.of(context).hoverColor,
                                      highlightColor: Theme.of(context).highlightColor,
                                      enabled: true,
                                      child: Container(
                                        height: 80,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(0),
                                        ),
                                      ),
                                    );
                                  },
                                  imageBuilder: (context, imageProvider) {
                                    return Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.circular(0),
                                      ),
                                    );
                                  },
                                  errorWidget: (context, url, error) {
                                    return Shimmer.fromColors(
                                      baseColor: Theme.of(context).hoverColor,
                                      highlightColor: Theme.of(context).highlightColor,
                                      enabled: true,
                                      child: Container(
                                        height: 80,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Icon(Icons.error),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Microtek",
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,

                                          color: AppTheme.textColor,
                                          fontWeight: FontWeight.w600
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "Omron HEM-7212 Automatic Blood Pres...",
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 12,
                                          color: AppTheme.textColor,
                                          fontWeight: FontWeight.w600
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Quantity:",
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 12,
                                              color: Color(0xFF939393),
                                              fontWeight: FontWeight.w300
                                          ),
                                        ),
                                        // SizedBox(
                                        //   width: MediaQuery.of(context).size.width/9,
                                        // ),
                                        Padding(
                                          padding: const EdgeInsets.only(left:8.0),
                                          child: Text('02',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 12,
                                              color:AppTheme.textColor,
                                              fontWeight: FontWeight.w600
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),

                                      ],
                                    ),

                                    Row(
                                      children: [
                                        Text(
                                          "Status:",
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 12,
                                              color: Color(0xFF939393),
                                              fontWeight: FontWeight.w300
                                          ),
                                        ),
                                        // SizedBox(
                                        //   width: MediaQuery.of(context).size.width/11,
                                        // ),
                                        Padding(
                                          padding: const EdgeInsets.only(left:8.0),
                                          child: Text(
                                            'New',
                                            //"Step 1",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 12,
                                              color: AppTheme.textColor,
                                              fontWeight: FontWeight.w600
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      ],
                                    ),


                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),

          ],
        ),
      ),
    );
  }

}

class DropDownAllTime extends StatefulWidget{
  var title;
  DropDownAllTime({Key? key,required this.title}):super(key: key);
  _DropDownAllState createState()=>_DropDownAllState();
}

class _DropDownAllState extends State<DropDownAllTime>{
  String dateTimeStart = "",dateTimeEnd="";
  final _textStartDateController = TextEditingController();
  final _textEndDateController = TextEditingController();
  var _validStartDate, _validEndDate;
  final _focusStartDate = FocusNode();
  final _focusEndDate = FocusNode();
  var _dropDownValue;
  String flagDate="0";
  var timeItems = [
    'Last Week',
    'Last Month',
    'Last Year'
  ];
  Future _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate:DateTime.now(),
      lastDate: DateTime(2030),
    );

    print(picked);

    if (picked != null)
      setState(() {
        dateTimeStart = DateFormat("yyyy-MM-dd").format(picked);
        dateTimeEnd = DateFormat("yyyy-MM-dd").format(picked);
        if(flagDate=="0"){
          _textStartDateController.text=dateTimeStart;

        }else{
          _textEndDateController.text=dateTimeEnd;

        }
      });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Date Filter",style: TextStyle(fontWeight: FontWeight.w600,fontFamily: "Poppins",
                  fontSize: 14.0),),
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Image.asset(Images.roundCancel,width: 20.0,height: 20.0,),)

            ],
          ),
        ),
        Container(height: 3,
          width: MediaQuery.of(context).size.width,
          color: Color(0xFFF5F5F5),),

        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //all time drop down
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
                                  'All Time',
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
                            items: timeItems.map(
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
                                  widget.title=_dropDownValue;
                                  print(_dropDownValue);
                                },
                              );
                            },
                          )))),
              Padding(padding: EdgeInsets.only(top: 8.0),
                  child: Text("Or",textAlign:TextAlign.center,style: TextStyle(color:Colors.black,fontWeight:FontWeight.w500,fontSize: 14.0,fontFamily: "Poppins"))),
              //start date
              Container(
                  height: 50.0,
                  margin: EdgeInsets.only(
                    top: 15.0,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFF5F5F5)),
                    // color: Theme.of(context).cardColor,
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top:10.0),
                              child: TextField(
                                textAlignVertical: TextAlignVertical.center,
                                enabled: false,
                                controller: _textStartDateController,
                                focusNode: _focusStartDate,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500),
                                decoration: InputDecoration(
                                  counterText: "",

                                  hintStyle: TextStyle(fontWeight: FontWeight.w400,
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                      fontFamily: 'Poppins'),
                                  hintText:
                                  Translate.of(context)!.translate('start_date'),
                                  border: InputBorder.none,
                                ),
                              ),
                            )),
                        InkWell(
                            onTap: () {
                              flagDate="0";//for start date
                              _selectDate();
                            },
                            child: Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child:Icon(Icons.calendar_today_rounded,color: Theme.of(context).primaryColor,)))
                      ],
                    ),



                  )),
              //end date
              Container(
                  height: 50.0,
                  margin: EdgeInsets.only(
                    top: 15.0,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFF5F5F5)),
                    // color: Theme.of(context).cardColor,
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child:
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top:10.0),
                              child: TextField(
                                textAlignVertical: TextAlignVertical.center,

                                controller: _textEndDateController,
                                focusNode: _focusEndDate,
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Poppins',
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500),
                                decoration: InputDecoration(
                                  counterText: "",

                                  hintStyle: TextStyle(fontWeight: FontWeight.w400,
                                      fontSize: 14.0,
                                      color: Colors.grey,
                                      fontFamily: 'Poppins'),
                                  hintText:
                                  Translate.of(context)!.translate('end_date'),
                                  border: InputBorder.none,
                                ),
                              ),
                            )),
                        InkWell(
                            onTap: () {
                              flagDate="1";//for end date

                              _selectDate();
                            },
                            child: Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child:Icon(Icons.calendar_today_rounded,color: Theme.of(context).primaryColor,)))
                      ],
                    ),



                  )),

              Padding(padding: EdgeInsets.only(left:10.0,right: 10.0,top:55.0),
                  child:
                  AppButton(
                    onPressed: (){
                    // if(_dropDownValue==null){
                    //   Fluttertoast.showToast(msg: "Please select all time");
                    // }else if(_textStartDateController.text.toString().isEmpty){
                    //   Fluttertoast.showToast(msg: "Please enter start date");
                    //
                    // }else if(_textEndDateController.text.toString().isEmpty){
                    //   Fluttertoast.showToast(msg: "Please enter end date");
                    //
                    // }else
                      if(_textStartDateController.text.toString().isNotEmpty) {
                        if (_textEndDateController.text.toString().contains(
                            _textStartDateController.text.toString())) {
                          Fluttertoast.showToast(
                              msg: "Please enter different start and end date");
                        }else{
                          Navigator.pop(context,widget.title);
                        }
                      }else{
                        Navigator.pop(context,widget.title);
                      }
                    },
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
                    text: 'Apply',
                    // loading: login is LoginLoading,
                    loading: true,
                    color: Theme.of(context).primaryColor,
                  )
              ),
            ],
          ),
        )
      ],
    );
  }

}

