import 'dart:convert';
import 'dart:math';

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
  Random random = Random();
  void getGroupsfromApi() async {
    GroupService.getGroups().then((response) {
      setState(() {
        
        try{
            Iterable list = json.decode(response.body).cast<Map<String?, dynamic>>();
            characterList = list.map((model) => TaskGroup.fromJson(model)).toList();

        }
        catch(e){
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
         padding: const EdgeInsets.symmetric(vertical:18),
         child: ListView.builder(

          itemCount: characterList.length,
          itemBuilder: (context, index){
            return Padding(
              padding: const EdgeInsets.symmetric(vertical:8.0),
              child: Container(
                child: GestureDetector(
                    onTap:(){
                      Navigator.pushNamed(
                        context, 
                        GroupTaskPlanner.routeName,
                        arguments: (
                          [characterList[index].group_id, null]
                        )
                      );
                    } ,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical:3.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: GlobalVariables.textFieldBgColor)
                      ),
                      child: Column(
                        children: [
                          Container(
                            width:(MediaQuery.of(context).size.width), 
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(12, 5, 12, 0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [ 
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Container(
                                      
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Group : ${characterList[index].group_name}",style: TextStyle(color: GlobalVariables.greyFontColor),),
                                              Text("Member Count : ${int.parse(characterList[index].member_count??"1")-1}",style: TextStyle(color: GlobalVariables.greyFontColor),),
                                              Text("Created On : ${((characterList[index].created_at)?.split("T"))?[0]}",style: TextStyle(color: GlobalVariables.greyFontColor),),
                                              
                                            ],
                                          ),
                                        ),
                                      ),
                                          const SizedBox(width: 130),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: GlobalVariables.primaryColor
                                            )
                                            ,
                                            onPressed: (){
                                                Navigator.pushNamed(
                                                context,
                                                EditTaskGroup.routeName,
                                                arguments: (
                                                  characterList[index]
                                                ),
                                              );
                                            }, 
                                            child:const Icon(Icons.edit,color: Colors.white,)
                                            )
                                         
                                    ],
                                  ),
                                      LinearProgressIndicator(
                                
                                        value: random.nextInt(10)/10,
                                        color:GlobalVariables.primaryColor,
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          ),
       )

    ,context);
  }
}

