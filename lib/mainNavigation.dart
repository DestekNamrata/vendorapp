import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Config/image.dart';
import 'Config/theme.dart';
import 'Screen/DashBoard/dashboardScreen.dart';
import 'Screen/Order/orderScreen.dart';
import 'Screen/Product/productList_screen.dart';
import 'Screen/Profile/profileScreen.dart';
import 'Screen/Sales/salesScreen.dart';

class MainNavigation extends StatefulWidget{
  _MainNavigationState createState()=>_MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation>{
  int _selectedIndex = 0;
  final _searchController = TextEditingController();


  List<BottomNavigationBarItem> _bottomBarItem(BuildContext context) {
    return [
      BottomNavigationBarItem(
        icon: Image.asset(
          Images.dashboard,
          width: 20.0,
          height: 20.0,
        ),
        activeIcon: Image.asset(
          Images.dashboard,
          width: 20.0,
          height: 20.0,
          color: AppTheme.redColor,
        ),
        label: 'Dashboard'
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          Images.product,
          width: 20.0,
          height: 20.0,
        ),
        activeIcon: Image.asset(
          Images.product,
          width: 20.0,
          height: 20.0,
          color: AppTheme.redColor,
        ),
        label: 'Product'
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          Images.order,
          width: 20.0,
          height: 20.0,
        ),
        activeIcon: Image.asset(
          Images.order,
          width: 20.0,
          height: 20.0,
          color: AppTheme.redColor,
        ),
        label: 'Order'
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          Images.sales,
          width: 20.0,
          height: 20.0,
        ),
        activeIcon: Image.asset(
          Images.sales,
          width: 20.0,
          height: 20.0,
          color: AppTheme.redColor,
        ),
        label: 'Sales'

      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          Images.profile,
          width: 20.0,
          height: 20.0,
        ),
        activeIcon: Image.asset(
          Images.profile,
          width: 20.0,
          height: 20.0,
          color: AppTheme.redColor,
        ),
        label:'Profile'

      ),
    ];

  }


  ///On change tab bottom menu
  void _onItemTapped(int index) async {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar:  AppBar(
          title: Text(
            "",
            textAlign:TextAlign.left,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 18.0,
                color: AppTheme.textColor),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            Container(
              height: 40.0,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child:
                    Container(
                      margin: EdgeInsets.only(left:10.0,top:8.0,bottom: 8.0),
                      // alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        // border: Border.all(color: Theme.of(context).unselectedWidgetColor.withOpacity(0.5)),
                        border: Border.all(color: Color(0xFF707070).withOpacity(0.5)),
                        // color: Theme.of(context).cardColor,
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            InkWell(
                                onTap: (){

                                },
                                child:Image.asset(Images.search,height:20.0,width:20.0)),
                            Padding(
                              padding: const EdgeInsets.only(left:8.0),
                              child: Text("Search all products",style: TextStyle(color: AppTheme.textColor,fontSize: 14.0,fontWeight: FontWeight.w500),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                      onTap: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationScreen(notifyList:notificationList)));
                      },
                      child:Stack(children: [
                        // IconButton(
                        //   icon:
                        Image.asset(
                          Images.notiIcon,
                          width: 45.0,
                          height: 45.0,
                        ),
                        // tooltip: "Save Todo and Retrun to List",
                        //   onPressed: () {},
                        // ),
                        // Icon(Icons.notifications,color:Colors.black54,size: 28.0,),
                        Positioned(
                          right: 6,
                          top: 1,
                          child: new Container(
                            padding: EdgeInsets.all(1),
                            decoration: new BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(9.5),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 16,
                              minHeight: 1,
                            ),
                            child: Text(
                              // UtilPreferences.getInt('badgeCnt')!=null? UtilPreferences.getInt('badgeCnt').toString()
                              //     :
                            "0",
                              style: new TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'Poppins'
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),

                      ],
                      )),


                ],
              ),
            )
          ],
        ),

        extendBody: true,
        body: IndexedStack(
          index: _selectedIndex,
          children: <Widget>[
            DashBoardScreen(),
            ProductListScreen(),
            OrderScreen(),
            SalesScreen(),
            ProfileScreen()
          ],
        ),
        bottomNavigationBar: Container(
          // height: 65.0,
            child: BottomNavigationBar(
              items: _bottomBarItem(context),
              // currentIndex:widget.flagNavigate!="1"?_selectedIndex:2 ,
              currentIndex:_selectedIndex ,
              type: BottomNavigationBarType.fixed,
              // unselectedItemColor:Theme.of(context).unselectedWidgetColor,
              unselectedItemColor:AppTheme.bottomTxt,
              selectedItemColor:AppTheme.redColor,
              showUnselectedLabels:true,
              onTap: (index) {
                _onItemTapped(index);
              },


            )
        )
    );
  }
  
}