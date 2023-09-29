

import 'package:flutter/material.dart';
import 'package:focusmi/features/appointment/screens/select_councillor.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/features/pomodoro_timer/screens/pomodoro_timer_view.dart';
import 'package:focusmi/features/task_group.dart/screens/create_group.dart';
import 'package:focusmi/models/task.dart';
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
    Widget mainLayoutPage(Widget widget){
    return Scaffold(
        
        body: widget
      );
  }

  Widget mainLayoutWithDrawer(context,Widget widget,appbarname){
    var user = Provider.of<UserProvider>(context,listen: false).user;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Text(
                '$appbarname',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18
                ),
              ),
            ],
          ),
          backgroundColor: GlobalVariables.primaryColor, 
        ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
             DrawerHeader(
                  decoration:const BoxDecoration(
                    color: GlobalVariables.primaryColor,
                  ),
                  child:SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                      child: Container(
                        alignment: Alignment.topLeft,
                            
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                                radius: 40, //radius of avatar
                                backgroundColor: Colors.green, //color
                                 backgroundImage:NetworkImage('$uri/api/assets/image/user-profs/profile-0.jpg'),
                              
                            ),
                           
                        Column(
                          
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user.username,style:const TextStyle(
                                color: Colors.white,
                                fontSize: 15
                            ),
                            ),
                            Text(user.email,style:const TextStyle(
                                color: Colors.white,
                                fontSize: 14
                            ),
                            ),
                          ],
                        ) 
                          ],
                            
                    
                          ),
                          ),
                    ),
                  ),
                  ),
              
              
              ListTile(
                title: const Text('Task Planner',style: TextStyle(fontSize: 15),),
                //selected: _selectedIndex == 0,
                onTap: () {
                  // Update the state of the app
                  //_onItemTapped(0);
                  // Then close the drawer
                
                },
              ),
              ListTile(
                title: const Text('Task Groups',style: TextStyle(fontSize: 15),),
                //selected: _selectedIndex == 1,
                onTap: () {
                  // Update the state of the app
                // _onItemTapped(1);
                  // Then close the drawer
            
                },
              ),
              ListTile(
                title: const Text('Mindfulness Courses',style: TextStyle(fontSize: 15),),
                //selected: _selectedIndex == 2,
                onTap: () {
                  // Update the state of the app
                // _onItemTapped(2);
                  // Then close the drawer
        
                },
              ),
              ListTile(
                title: const Text('Meet Professional',style: TextStyle(fontSize: 15),),
                //selected: _selectedIndex == 2,
                onTap: () {
                  // Update the state of the app
                  //Navigator.pushNamed(context, CounselorsListWidget.routeName);
                // _onItemTapped(2);
                  // Then close the drawer
        
                },
                
              ),
                ListTile(
                title: const Text('My Profile',style: TextStyle(fontSize: 15),),
                //selected: _selectedIndex == 2,
                onTap: () {
                  // Update the state of the app
                // _onItemTapped(2);
                  // Then close the drawer
        
                },)
            ],
          ),
        ),
        body: widget,
      
      );
}


  Widget mainLayoutWithDrawerFloatingBtn(context,Widget widget,appbarname,Task task){
    var user = Provider.of<UserProvider>(context,listen: false).user;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title:Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Text(
                '$appbarname',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18
                ),
              ),
            ],
          ),
          backgroundColor: GlobalVariables.primaryColor, 
        ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
             DrawerHeader(
                  decoration:const BoxDecoration(
                    color: GlobalVariables.primaryColor,
                  ),
                  child:SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                      child: Container(
                        alignment: Alignment.topLeft,
                            
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                                radius: 40, //radius of avatar
                                backgroundColor: Colors.green, //color
                                 backgroundImage:NetworkImage('$uri/api/assets/image/user-profs/profile-0.jpg'),
                              
                            ),
                           
                        Column(
                          
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user.username,style:const TextStyle(
                                color: Colors.white,
                                fontSize: 15
                            ),
                            ),
                            Text(user.email,style:const TextStyle(
                                color: Colors.white,
                                fontSize: 14
                            ),
                            ),
                          ],
                        ) 
                          ],
                            
                    
                          ),
                          ),
                    ),
                  ),
                  ),
              
              
              ListTile(
                title: const Text('Task Planner',style: TextStyle(fontSize: 15),),
                //selected: _selectedIndex == 0,
                onTap: () {
                  // Update the state of the app
                  //_onItemTapped(0);
                  // Then close the drawer
                
                },
              ),
              ListTile(
                title: const Text('Task Groups',style: TextStyle(fontSize: 15),),
                //selected: _selectedIndex == 1,
                onTap: () {
                  // Update the state of the app
                // _onItemTapped(1);
                  // Then close the drawer
            
                },
              ),
              ListTile(
                title: const Text('Mindfulness Courses',style: TextStyle(fontSize: 15),),
                //selected: _selectedIndex == 2,
                onTap: () {
                  // Update the state of the app
                // _onItemTapped(2);
                  // Then close the drawer
        
                },
              ),
              ListTile(
                title: const Text('Meet Professional',style: TextStyle(fontSize: 15),),
                //selected: _selectedIndex == 2,
                onTap: () {
                  // Update the state of the app
                  //Navigator.pushNamed(context, CounselorsListWidget.routeName);
                // _onItemTapped(2);
                  // Then close the drawer
        
                },
                
              ),
                ListTile(
                title: const Text('My Profile',style: TextStyle(fontSize: 15),),
                //selected: _selectedIndex == 2,
                onTap: () {
                  // Update the state of the app
                // _onItemTapped(2);
                  // Then close the drawer
        
                },)
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
              child:Icon(Icons.timer,color: Colors.white,),
              shape:CircleBorder(),
              onPressed:()=>Navigator.pushNamed(context,PomodoroTimerScreen.routeName,arguments: task) ,
            )
          )
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
                    alignment: Alignment.topCenter,
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
                      crossAxisAlignment:CrossAxisAlignment.start,
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
                title: const Text('Task Planner',style: TextStyle(fontSize: 15),),
                //selected: _selectedIndex == 0,
                onTap: () {
                  // Update the state of the app
                  //_onItemTapped(0);
                  // Then close the drawer
                
                },
              ),
              ListTile(
                title: const Text('Task Groups',style: TextStyle(fontSize: 15),),
                //selected: _selectedIndex == 1,
                onTap: () {
                  // Update the state of the app
                // _onItemTapped(1);
                  // Then close the drawer
            
                },
              ),
              ListTile(
                title: const Text('Mindfulness Courses',style: TextStyle(fontSize: 15),),
                //selected: _selectedIndex == 2,
                onTap: () {
                  // Update the state of the app
                // _onItemTapped(2);
                  // Then close the drawer
        
                },
              ),
              ListTile(
                title: const Text('Meet Professional',style: TextStyle(fontSize: 15),),
                //selected: _selectedIndex == 2,
                onTap: () {
                  // Update the state of the app
                // _onItemTapped(2);
                 Navigator.pushNamed(context, CounselorsListWidgetWidget.routeName);
                  // Then close the drawer
        
                },
                
              ),
                ListTile(
                title: const Text('My Profile',style: TextStyle(fontSize: 15),),
                //selected: _selectedIndex == 2,
                onTap: () {
                  // Update the state of the app
                // _onItemTapped(2);
                  // Then close the drawer
        
                },)
              
             
            ],
          ),
        ),
        body: widget
  
         
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
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
             DrawerHeader(
                  decoration:const BoxDecoration(
                    color: GlobalVariables.primaryColor,
                  ),
                  child:SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                      child: Container(
                        alignment: Alignment.topLeft,
                            
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                                radius: 40, //radius of avatar
                                backgroundColor: Colors.green, //color
                                 backgroundImage:NetworkImage('$uri/api/assets/image/user-profs/profile-0.jpg'),
                              
                            ),
                           
                        Column(
                          
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user.username,style:const TextStyle(
                                color: Colors.white,
                                fontSize: 15
                            ),
                            ),
                            Text(user.email,style:const TextStyle(
                                color: Colors.white,
                                fontSize: 14
                            ),
                            ),
                          ],
                        ) 
                          ],
                            
                    
                          ),
                          ),
                    ),
                  ),
                  ),
              
              
              ListTile(
                title: const Text('Task Planner',style: TextStyle(fontSize: 15),),
                //selected: _selectedIndex == 0,
                onTap: () {
                  // Update the state of the app
                  //_onItemTapped(0);
                  // Then close the drawer
                
                },
              ),
              ListTile(
                title: const Text('Task Groups',style: TextStyle(fontSize: 15),),
                //selected: _selectedIndex == 1,
                onTap: () {
                  // Update the state of the app
                // _onItemTapped(1);
                  // Then close the drawer
            
                },
              ),
              ListTile(
                title: const Text('Mindfulness Courses',style: TextStyle(fontSize: 15),),
                //selected: _selectedIndex == 2,
                onTap: () {
                  // Update the state of the app
                // _onItemTapped(2);
                  // Then close the drawer
        
                },
              ),
              ListTile(
                title: const Text('Meet Professional',style: TextStyle(fontSize: 15),),
                //selected: _selectedIndex == 2,
                onTap: () {
                  // Update the state of the app
                // _onItemTapped(2);
                  Navigator.pushNamed(context, CounselorsListWidgetWidget.routeName);
                  // Then close the drawer
        
                },
                
              ),
                ListTile(
                title: const Text('My Profile',style: TextStyle(fontSize: 15),),
                //selected: _selectedIndex == 2,
                onTap: () {
                  // Update the state of the app
                // _onItemTapped(2);
                  // Then close the drawer
        
                },)
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