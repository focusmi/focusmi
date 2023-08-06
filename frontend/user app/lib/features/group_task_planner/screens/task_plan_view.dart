// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:focusmi/layouts/task_planner_layout.dart';
import 'package:focusmi/models/subtask.dart';
import 'package:focusmi/models/task.dart';
import 'package:focusmi/models/taskgroup.dart';
import 'package:focusmi/models/taskplan.dart';

class GroupTaskPlanner extends StatefulWidget {
  static const String routeName = '/task_plan_view';
  final TaskGroup group;

  const GroupTaskPlanner({
    Key? key,
    required this.group,
  }) : super(key: key);
  

  @override
  State<GroupTaskPlanner> createState() => _GroupTaskPlannerState();
}


class _GroupTaskPlannerState extends State<GroupTaskPlanner> {
  int _selectedIndex = 0;
  Task entryTask = new Task(task_id: 0, plan_id: 0, timer_id: 0, duration: 0, task_status: '', priority: 0, created_date: '', created_time: '', completed_date: '', completed_time: '', color: '', description: '', is_text_field: true,task_name: '');
  late TextEditingController taskCreate;
  List<TaskPlan> taskPlans = List<TaskPlan>.empty(growable: true);
  Map taskMap = Map();
  List<Task> tasks = List<Task>.empty(growable: true);
  List<SubTask> subTasks = List<SubTask>.empty(growable: true);
  List<TextEditingController> taskPlanControllers = List<TextEditingController>.empty(growable: true);
  late var taskPlanEditName;

  void addTaskPlan(){
    var taskid = taskPlans.length+1;
    var groupid = widget.group.group_id;
    var name = 'Task Plan - $taskid';
    setState(() {
      taskPlans.add(
        TaskPlan(plan_id: taskid, group_id: groupid, plan_name: name, location: '', schedule_date: '', schedule_type: '', time: '', reminder_status: '', created_date: '',is_edit: false)
      );
    });
     taskMap[taskid]=List<Task>.empty(growable: true);
    print(taskMap);
  }

  void addTask(){
    var taskid  = tasks.length+1;
    setState(() {
      taskMap[entryTask.plan_id].add(
        Task(task_id: taskid, plan_id:entryTask.plan_id, timer_id: 0, duration: 0, task_status: 'pending' , priority:0, created_date: '', created_time: '', completed_date: '', completed_time: '', color: '', description: '', is_text_field: false,task_name:taskCreate.text )
      );
      entryTask.plan_id=0;
    });

  }

  void createTask(plan_id){ 
    setState(() {
      taskMap.forEach(
        (key,value){
          var val =value.indexWhere((item) => item.task_id==0);
          (val!=-1)?value.removeAt(val):val=0;
        }
      );
        taskCreate.text='';
        taskMap[plan_id].add(entryTask);
        entryTask.plan_id = plan_id;
      });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void initState() {
    taskPlanEditName = 0;
    taskCreate = TextEditingController();
    super.initState();
    
  }
  void _onPressedText(index){
    setState(() {
      taskPlans[index].is_edit=true;
      taskPlanControllers[index].text=taskPlans[index].plan_name;
    });
  }
  void _addTaskPlanName(index){
    setState(() {
      taskPlans[index].plan_name = taskPlanControllers[index].text;
      taskPlans[index].is_edit =false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TaskPlannerLayout.mainBoard(
      Container(
    
      child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: taskPlans.length,
                      scrollDirection:Axis.horizontal,
                      itemBuilder: (context, index){
                      taskPlanControllers.add(TextEditingController());
                        return Column(
                          children: [
                            Container(
                              child: (taskPlans[index].is_edit!=null && taskPlans[index].is_edit!=true )? 
                              ElevatedButton(
                                child: Text(
                                  taskPlans[index].plan_name

                                ),
                                onPressed:() {
                                  _onPressedText(index);
                                },
                                )
                              : Row(
                                children: [
                                  Container(width: 100,child: TextField(
                                    controller: taskPlanControllers[index],
                                  )),
                                  ElevatedButton(onPressed: (){
                                    _addTaskPlanName(index);
                                  }, 
                                  child:const Icon(Icons.add))
                                ],
                              ),
                            ),
                            SizedBox(
                          
                              width: 200,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: taskMap[taskPlans[index].plan_id].length,
                                itemBuilder: (context, subindex){
                                  return Container(
                                    
                                    child:Text(
                                     ((taskMap[taskPlans[index].plan_id])[subindex].task_name)
                                    )
                                  );
                                }
                              ),
                            ),
                            (entryTask.plan_id != taskPlans[index].plan_id)?
                            ElevatedButton(
                              onPressed: (){
                              createTask(taskPlans[index].plan_id);
                              }, 
                               child: Text("Create Task")
                             ):
                            Container(
                              width: 100,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 200,
                                    child: TextField(
                                      controller: taskCreate,
                                  
                                      ),
                                  ),
                                    ElevatedButton(
                                      onPressed: (){addTask();}, 
                                      child: Icon(Icons.add)
                                      )
                                ],
                              )
                            )

                          ],
                        );
                      }
                    )
        
      ),
      BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: ElevatedButton(
              child:const Icon(Icons.add),
              onPressed: (){
                addTaskPlan();
                print(taskPlanEditName);
              },
            ),
            label: 'Task Plan',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Group',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),        
      "Task Planner"
    );
  }
}

