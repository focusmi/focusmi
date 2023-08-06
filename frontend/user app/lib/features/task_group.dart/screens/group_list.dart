import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/features/group_task_planner/screens/task_plan_view.dart';
import 'package:focusmi/features/task_group.dart/screens/edit_task_group.dart';
import 'package:focusmi/features/task_group.dart/services/set_group_services.dart';
import 'package:focusmi/layouts/user-layout.dart';
import 'package:focusmi/models/taskgroup.dart';
import 'package:avatar_glow/avatar_glow.dart';
class GroupList extends StatefulWidget {
  static const String routeName = '/group_list';
  const GroupList({super.key});

  @override
  State<GroupList> createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  List<TaskGroup> characterList =  List<TaskGroup>.empty();

  void getGroupsfromApi() async {
    GroupService.getGroups().then((response) {
      setState(() {
        
        try{
            Iterable list = json.decode(response.body).cast<Map<String?, dynamic>>();
            characterList = list.map((model) => TaskGroup.fromJson(model)).toList();

        }
        catch(e){
          print("-----------");
          print(e);
          print(response.body);
          characterList = List.empty();
        }

        
      });
    });
  }

  void initState() {
    super.initState();
    getGroupsfromApi();
  }
  @override
  Widget build(BuildContext context) {
    
    LayOut layout =LayOut();
    return layout.mainListView(
       Padding(
         padding: const EdgeInsets.symmetric(vertical:8),
         child: ListView.builder(
          itemCount: characterList.length,
          itemBuilder: (context, index){
            return ElevatedButton(
              style:ElevatedButton.styleFrom(
                backgroundColor:const Color.fromARGB(255, 255, 255, 255) ,
                foregroundColor: Colors.white
              ),
              onPressed:(){
                Navigator.pushNamed(
                  context, 
                  GroupTaskPlanner.routeName,
                  arguments: (
                    characterList[index]
                  )
                );
              } ,
              child: Column(
                children: [
                  Container(
                    width:(MediaQuery.of(context).size.width), 
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [ 
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Group Name : ${characterList[index].group_name}",style: TextStyle(color: GlobalVariables.greyFontColor),),
                              Text("Member Count : ${characterList[index].member_count}",style: TextStyle(color: GlobalVariables.greyFontColor),),
                              Text("Created At : ${((characterList[index].created_at).split("T"))[0]}",style: TextStyle(color: GlobalVariables.greyFontColor),),
                              ElevatedButton(
                                onPressed: (){
                                    Navigator.pushNamed(
                                    context,
                                    EditTaskGroup.routeName,
                                    arguments: (
                                      characterList[index]
                                    ),
                                  );
                                }, 
                                child: Text("Edit")
                                )
                            ],
                          ),
                              const SizedBox(width: 100),
                              Row(
                                children: [
                                  Text("${(characterList[index].status)[0].toUpperCase()}${(characterList[index].status).substring(1)}",style: TextStyle(color: GlobalVariables.greyFontColor),),
                                  const SizedBox(width: 5),
                                  characterList[index].status=='active'?
                                  const AvatarGlow(
                                    glowColor: Color(0xff39FF14),    //Neon Color
                                    endRadius: 8.0,

                                    duration: Duration(milliseconds: 3000),
                                    repeat: true,
                                    showTwoGlows: true,
                                    repeatPauseDuration: Duration(milliseconds: 100),

                                    child: CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Color.fromARGB(255, 26, 240, 62),
                                      
                                    ),
                                  ):
                                  const AvatarGlow(
                                    glowColor: Color(0xff39FF14),    //Neon Color
                                    endRadius: 8.0,

                                    duration: Duration(milliseconds: 3000),
                                    repeat: true,
                                    showTwoGlows: true,
                                    repeatPauseDuration: Duration(milliseconds: 100),

                                    child: CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Color.fromARGB(255, 236, 29, 15),
                                      
                                    ),
                                  )
                                  ,
                                ],
                              ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          ),
       )

    ,context);
  }
}

