
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'dart:ui' as ui;

import 'package:focusmi/features/authentication/screens/auth_screen.dart';
import 'package:focusmi/features/task_group.dart/screens/create_group.dart';
import 'package:focusmi/features/task_group.dart/screens/group_list.dart';
import 'package:focusmi/providers/user_provider.dart';
import 'package:provider/provider.dart';
class LayOut{

  Widget mainLayout(Widget widget){
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:const Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                'FocusMi',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          backgroundColor: GlobalVariables.primaryColor, 
        ),
        body: widget
      );
  }

  Widget mainLayoutWithDrawer(context,Widget widget,appbarname){
    var user = Provider.of<UserProvider>(context,listen: false).user;
    bool floatActionToggle ;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                '${appbarname}',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          backgroundColor: GlobalVariables.primaryColor, 
        ),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration:const BoxDecoration(
                  color: GlobalVariables.primaryColor,
                ),
                child:Container(
                  alignment: Alignment.topLeft,
                  width: 10,
                  height: 10,
                  child:const Column(
                    children: [
                      // CircleAvatar(   
                      //   minRadius: 50,
                      //   maxRadius: 75,
                      //   backgroundColor: Colors.red,
                      //   backgroundImage: new AssetImage('assets/images/new.jpg'),

                      // ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Thomas King",style:TextStyle(
                          color: Colors.white,
                       ),
                      ),
                      Text("Thomas@nobel.com",style:TextStyle(
                          color: Colors.white,
                       ),
                      ),
                    ],
                  ) 
                    ],
                      

                    ),
                    ),
                ),
              
              
              ListTile(
                title: const Text('Home'),
                //selected: _selectedIndex == 0,
                onTap: () {
                  // Update the state of the app
                  //_onItemTapped(0);
                  // Then close the drawer
                
                },
              ),
              ListTile(
                title: const Text('Busines'),
                //selected: _selectedIndex == 1,
                onTap: () {
                  // Update the state of the app
                // _onItemTapped(1);
                  // Then close the drawer
            
                },
              ),
              ListTile(
                title: const Text('School'),
                //selected: _selectedIndex == 2,
                onTap: () {
                  // Update the state of the app
                // _onItemTapped(2);
                  // Then close the drawer
        
                },
              ),
            ],
          ),
        ),
        body: widget,
      
      );
}

 Widget createGruopLayout(context,Widget widget,appbarname){
    var user = Provider.of<UserProvider>(context,listen: false).user;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                '${appbarname}',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          backgroundColor: GlobalVariables.primaryColor, 
        ),
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration:const BoxDecoration(
                  color: GlobalVariables.primaryColor,
                ),
                child:Container(
                  alignment: Alignment.topLeft,
                  width: 10,
                  height: 10,
                  child:const Column(
                    children: [
                      // CircleAvatar(   
                      //   minRadius: 50,
                      //   maxRadius: 75,
                      //   backgroundColor: Colors.red,
                      //   backgroundImage: new AssetImage('assets/images/new.jpg'),

                      // ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Thomas King",style:TextStyle(
                          color: Colors.white,
                       ),
                      ),
                      Text("Thomas@nobel.com",style:TextStyle(
                          color: Colors.white,
                       ),
                      ),
                    ],
                  ) 
                    ],
                      

                    ),
                    ),
                ),
              
              
              ListTile(
                title: const Text('Home'),
                //selected: _selectedIndex == 0,
                onTap: () {
                  // Update the state of the app
                  //_onItemTapped(0);
                  // Then close the drawer
                
                },
              ),
              ListTile(
                title: const Text('Busines'),
                //selected: _selectedIndex == 1,
                onTap: () {
                  // Update the state of the app
                // _onItemTapped(1);
                  // Then close the drawer
            
                },
              ),
              ListTile(
                title: const Text('School'),
                //selected: _selectedIndex == 2,
                onTap: () {
                  // Update the state of the app
                // _onItemTapped(2);
                  // Then close the drawer
        
                },
              ),
            ],
          ),
        ),
        body: widget,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        
          floatingActionButton: SizedBox(
            height: 60,
            width:(MediaQuery.of(context).size.width)*0.98,
          
            child: FloatingActionButton.extended(
              backgroundColor: GlobalVariables.primaryColor,
              label:Text(
                "Create Group",
                style: TextStyle(
                  color: Colors.white
                ),
              ),
              onPressed:()=>Navigator.pushNamed(context,CreateGroup.routeName) ,
            )
          )
      
      );
  }

    Widget mainListView(Widget widget,BuildContext context){
      var user = Provider.of<UserProvider>(context,listen: false).user;
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title:const Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Task Groups',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            backgroundColor: GlobalVariables.primaryColor, 
          ),
          drawer: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration:const BoxDecoration(
                    color: GlobalVariables.primaryColor,
                  ),
                  child:Container(
                    alignment: Alignment.topLeft,
                    width: 10,
                    height: 10,
                    child:Row(
                      children: [
                        // CircleAvatar(   
                        //   minRadius: 50,
                        //   maxRadius: 75,
                        //   backgroundColor: Colors.red,
                        //   backgroundImage: new AssetImage('assets/images/new.jpg'),

                        // ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(user.username,style:const TextStyle(
                            color: Colors.white,
                        ),
                        ),
                        Text(user.email,style:const TextStyle(
                            color: Colors.white,
                        ),
                        ),
                      ],
                    ) 
                      ],
                        

                      ),
                      ),
                  ),
                
                
                ListTile(
                  title: const Text('Home'),
                  //selected: _selectedIndex == 0,
                  onTap: () {
                    // Update the state of the app
                    //_onItemTapped(0);
                    // Then close the drawer
                  
                  },
                ),
                ListTile(
                  title: const Text('Business'),
                  //selected: _selectedIndex == 1,
                  onTap: () {
                    // Update the state of the app
                  // _onItemTapped(1);
                    // Then close the drawer
              
                  },
                ),
                ListTile(
                  title: const Text('School'),
                  //selected: _selectedIndex == 2,
                  onTap: () {
                    // Update the state of the app
                  // _onItemTapped(2);
                    // Then close the drawer
          
                  },
                ),
              ],
            ),
          ),
          body: widget,
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: SizedBox(
            height: 75,
            width: 75,
          
            child: FloatingActionButton(
              backgroundColor: GlobalVariables.primaryColor,
              child:Icon(Icons.add,color: Colors.white,),
              shape:CircleBorder(),
              onPressed:()=>Navigator.pushNamed(context,CreateGroup.routeName) ,
            )
          ),
        );
}




 
}