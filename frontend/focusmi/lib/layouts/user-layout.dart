import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'dart:ui' as ui;
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
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: GlobalVariables.primaryColor,
                ),
                child:Container(
                  alignment: Alignment.topLeft,
                  width: 10,
                  height: 10,
                  child:Row(
                    children: [
                      CircleAvatar(   
                        minRadius: 50,
                        maxRadius: 75,
                        backgroundColor: Colors.red,
                        backgroundImage: new AssetImage('assets/images/new.jpg'),

                      ),
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
        body: widget
      );
  }

  Widget FrostGlassBg(Widget widget){
      return new Scaffold(
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          generateBluredImage(),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              widget,
            ],
          ),
        ],
      ),
    );
  }

  Widget generateBluredImage() {
    return new Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage('assets/images/new.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      //I blured the parent container to blur background image, you can get rid of this part
      child: new BackdropFilter(
        filter: new ui.ImageFilter.blur(sigmaX: 25.0, sigmaY: 25.0),
        child: new Container(
          //you can change opacity with color here(I used black) for background.
          decoration: new BoxDecoration(color: Colors.black.withOpacity(0.2)),
        ),
      ),
    );
  }

 
}