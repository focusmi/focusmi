import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/features/appointment/screens/select_councillor.dart';
import 'package:focusmi/providers/user_provider.dart';
import 'package:provider/provider.dart';


class TaskPlannerLayout{

  static Widget mainBoard(Widget widget,navigationbar,appBarName,context){
    var user = Provider.of<UserProvider>(context,listen: false).user;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Text(
              appBarName,
              style: const TextStyle(
                color:Colors.white,
                fontSize: 18
              ),
            )
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body:widget,
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
                 Navigator.pushNamed(context, CounselorsListWidgetWidget.routeName);
                  // Update the state of the app
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
      bottomNavigationBar: navigationbar,
    );
  }
}