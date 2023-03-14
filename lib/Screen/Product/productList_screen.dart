import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Config/image.dart';
import '../../Config/theme.dart';
import '../../Widget/app_button.dart';

class ProductListScreen extends StatefulWidget {
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductListScreen> {
  String titleProdString = "All Product List";
  int selectedRadioTile = 1;


  showBottomDialogForProdList(BuildContext context) {

    return
      showModalBottomSheet(
        isScrollControlled: true,
        // isDismissible: false,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0))),
        context: context,
        builder: (BuildContext context) {
          return Padding(
              padding: MediaQuery.of(context).viewInsets,
              // padding: EdgeInsets.all(10.0),
              child: RadioProdList(title: titleProdString,selRadio:selectedRadioTile));
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Container(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // mainAxisAlignment: MainAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 15.0),
                child: InkWell(
                    onTap: () async{
                      var result=await  showModalBottomSheet(
                          isScrollControlled: true,
                          // isDismissible: false,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0))),
                          context: context,
                          builder: (BuildContext context) {
                            return Padding(
                                padding: MediaQuery.of(context).viewInsets,
                                // padding: EdgeInsets.all(10.0),
                                child: RadioProdList(title: titleProdString,selRadio: selectedRadioTile,));
                          });
                      if(result!=null){
                        setState((){
                          titleProdString=result["title"].toString();
                          selectedRadioTile=result["selradio"];

                        });

                      }
                    },
                    child: Row(
                      children: [
                        Text(
                          titleProdString,
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textColor,
                              fontSize: 12.0),
                        ),
                        Icon(Icons.arrow_drop_down),
                      ],
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 15.0),
                    child: Row(
                      children: [
                        Image.asset(Images.sortIcon),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                          child: Text(
                            "Sort",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textColor,
                                fontSize: 12.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 15.0),
                    child: Row(
                      children: [
                        Image.asset(Images.filterIcon),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                          child: Text(
                            "Filter",
                            style: TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textColor,
                                fontSize: 12.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, right: 8.0, top: 15.0),
                    child: InkWell(
                        onTap: () {},
                        child: Container(
                            height: 25.0,
                            width: 25.0,
                            margin: EdgeInsets.only(right: 8.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.0),
                                color: Theme.of(context).primaryColor),
                            child: Icon(
                              Icons.add,
                              size: 20.0,
                              color: Colors.white,
                            ))),
                  ),
                ],
              ),

              //   Expanded(child:InkWell(
              //       onTap: (){
              //         showBottomDialogForProdList(context);
              //         },
              //       child:ListTile(tileColor:Color(0xFFF5F5F5),title: Text("Awaiting approval",style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w600,
              //           color:AppTheme.textColor,fontSize: 12.0),),
              //         trailing: Icon(Icons.arrow_drop_down),)
              //   )),
              //for sort
              // Expanded(child:InkWell(
              //     onTap: (){
              //
              //     },
              //     child:ListTile(tileColor:Color(0xFFF5F5F5),title: Text("Sort",style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w500,
              //         color:AppTheme.textColor,fontSize: 12.0),),
              //       leading: Image.asset(Images.sortIcon),)
              // )),
              // //filter
              // Expanded(child:InkWell(
              //     onTap: (){
              //
              //     },
              //     child:ListTile(tileColor:Color(0xFFF5F5F5),title: Text("Filter",style: TextStyle(fontFamily: "Poppins",fontWeight: FontWeight.w500,
              //         color:AppTheme.textColor,fontSize: 12.0),),
              //       leading: Image.asset(Images.filterIcon),)
              // )),
              // //add product
              // InkWell(
              //     onTap: (){
              //
              //     },
              //     child:Container(
              //       height: 25.0,
              //       width: 25.0,
              //       margin: EdgeInsets.only(right: 8.0),
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(50.0),
              //         color: Theme.of(context).primaryColor
              //       ),
              //         child:Icon(Icons.add,size: 20.0,color: Colors.white,))
              // ),
            ],
          )
        ],
      )),
    );
  }
}

class RadioProdList extends StatefulWidget {
  String title;
  int selRadio;

  RadioProdList({Key? key, required this.title,required this.selRadio}) : super(key: key);

  _RadioProdState createState() => _RadioProdState();
}

class _RadioProdState extends State<RadioProdList> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        //list type
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("List Type",style: TextStyle(fontWeight: FontWeight.w600,fontFamily: "Poppins",
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
        //all product List
        Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor:
                          Theme.of(context).unselectedWidgetColor,
                    ),
                    child: RadioListTile(
                      activeColor: AppTheme.redColor,
                      title: Text(
                        "All product List",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0,
                            fontFamily: 'Poppins',
                            color: AppTheme.textColor),
                        // )
                      ),
                      value: 1,
                      groupValue: widget.selRadio,
                      onChanged: (int? value) {
                        setState(() {
                          widget.selRadio = value!;
                          widget.title = "All product List";
                          print("value" + widget.selRadio.toString());
                        });
                      },
                    ))),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Text(
                "(108)",
                style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14.0,
                fontFamily: 'Poppins',
                color: AppTheme.textColor),
              ),
            ),
          ],
        ),

        //awaiting approval
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Theme(
                  data: Theme.of(context).copyWith(
                    unselectedWidgetColor:
                        Theme.of(context).unselectedWidgetColor,
                  ),
                  child: RadioListTile(
                    activeColor: AppTheme.redColor,
                    title: Text(
                      "Awaiting approval",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
                          fontFamily: 'Poppins',
                          color: AppTheme.textColor),
                      // )
                    ),
                    value: 2,
                    groupValue: widget.selRadio,
                    onChanged: (int? value) {
                      setState(() {
                        widget.selRadio = value!;
                        widget.title = "Awaiting Approval";
                        print("value" + widget.selRadio.toString());
                      });
                    },
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Text(
                "(28)",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0,
                    fontFamily: 'Poppins',
                    color: AppTheme.textColor),
                // )
              ),
            )
          ],
        ),
        //apply
        Padding(padding: EdgeInsets.only(left:10.0,right: 10.0,top:30.0,bottom:10.0),
            child:
            AppButton(
              onPressed: (){
                Navigator.pop(context, {"title":widget.title,"selradio":widget.selRadio});

              },
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
              text: 'Apply',
              // loading: login is LoginLoading,
              loading: true,
              color: Theme.of(context).primaryColor,
            )
        ),
      ],
    );
  }
}
