// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/layouts/user-layout.dart';
import 'package:focusmi/models/groupmembers.dart';
import 'package:focusmi/models/subtask.dart';
import 'package:focusmi/models/task.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:focusmi/widgets/texts.dart';

class SingleTaskView extends StatefulWidget {
  static const routeName = '/single_task_view';
  final Task task;

  SingleTaskView({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<SingleTaskView> createState() => _SingleTaskViewState();
}

class _SingleTaskViewState extends State<SingleTaskView> {
  late List<SubTask> subTasks;
  late List<GroupMember> memberList;
  late List<GroupMember> showMemeberList;
  late List<GroupMember> selectedMemberList;
  late Map<GroupMember, List<GroupMember>> subTaskAllocation;
  late TextEditingController _searchValue;
  late Map<int, List<GroupMember>> _subTaskAllocation;
  late bool toggleInput;
  late TextEditingController _subtaskValue;
  late DateTime dateTime;
  late DateTime? showDateTime;
  late DateTime now;
  late TimeOfDay nowtime;
  late TimeOfDay? showTime;
  late Color? label;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subTasks = List<SubTask>.empty(growable: true);
    subTaskAllocation = {};
    GroupMember dummyMember = GroupMember(
        1, 'Morgan Stern', 'stern@county.com', 'active', 'profile.jpg');
    GroupMember dummyMember1 = GroupMember(
        1, 'Willy Stern', 'Gunny@county.com', 'active', 'profile.jpg');
    GroupMember dummyMember2 = GroupMember(
        1, 'Rita Stern', 'rita@county.com', 'active', 'profile.jpg');
    memberList = List<GroupMember>.empty(growable: true);
    memberList.add(dummyMember);
    memberList.add(dummyMember1);
    memberList.add(dummyMember2);
    showMemeberList = List<GroupMember>.empty(growable: true);
    selectedMemberList = List<GroupMember>.empty(growable: true);
    _searchValue = TextEditingController();
    _subTaskAllocation = {};
    toggleInput = false;
    _searchValue = TextEditingController();
    _subtaskValue = TextEditingController();

    // fixed the date to taday\
    now = DateTime.now();
    dateTime = DateTime(now.year, now.month, now.day);
    showDateTime = null;
    showTime = null;
    nowtime = TimeOfDay.now();
    label = Colors.white;
  }

  void searchMember(text) {
    setState(() {
      showMemeberList.clear();
    });
    String val = text.toLowerCase();
    for (var member in memberList) {
      if (val != '') {
        var re = RegExp('^[a-zA-z]*${val}[a-zA-Z0-9]*');
        if (re.hasMatch(member.email.toLowerCase()) ||
            re.hasMatch(member.username.toLowerCase())) {
          setState(() {
            showMemeberList.add(member);
          });
        }
      } else {
        setState(() {
          showMemeberList.clear();
        });
      }
    }
  }

  void addMember(member) {
    setState(() {
      selectedMemberList.add(member);
    });
  }

  void addSubTask(taskname, taskid) {
    setState(() {
      subTasks.add(SubTask(
      stack_id: subTasks.length + 1,
      task_id: taskid,
      sub_priority: 0,
      sub_label: taskname,
      sub_status: 'pending',
      created_at: ''));
      _subTaskAllocation[subTasks.length] = [];
    });
  }

  void allocateMember(GroupMember member, subtask) {
    setState(() {
      _subTaskAllocation[subtask]?.add(member);
      print(_subTaskAllocation);
    });
  }

  Future<DateTime?> pickDate() => showDatePicker(context: context, initialDate: dateTime, firstDate: DateTime(now.year-1, now.month, now.day), lastDate: DateTime(now.year+1, now.month, now.day));
  Future<TimeOfDay?> pickTime() => showTimePicker(context: context, initialTime: nowtime);
  void setSchedule()async{
    DateTime? resultDate = await pickDate();
    if(resultDate!=null){
      TimeOfDay? resultTime = await pickTime();
      setState(() {
        showDateTime = resultDate;
      });
      if(resultDate!=null){
        setState(() {
          showTime = resultTime;
        });
      }
    }

  }

  Widget _buildAddMemberPopup(BuildContext context, subtaskid) {
    return AlertDialog(
      title:const Text("Add Member"),
      content: StatefulBuilder(
        builder: (BuildContext , StateSetter setState) {
          return Container(
            width: 200,
            child: Column(
              children: [
                TextField(
                  controller: _searchValue,
                  onChanged: (text) {
                    setState(() {
                      showMemeberList.clear();
                    });
                    String val = text.toLowerCase();
                    for (var member in memberList) {
                      if (val != '') {
                        var re = RegExp('^[a-zA-z]*${val}[a-zA-Z0-9]*');
                        if (re.hasMatch(member.email.toLowerCase()) ||
                            re.hasMatch(member.username.toLowerCase())) {
                          setState(() {
                            showMemeberList.add(member);
                          });
                        }
                      } else {
                        setState(() {
                          showMemeberList.clear();
                        });
                      }
                    }
                  },
                ),
                //member list
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: showMemeberList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          allocateMember(showMemeberList[index], subtaskid);
                        },
                        child: Row(
                          children: [
                            //Image.network('$uri/api/assets/image/user-profs/team.png'),
                            Column(
                              children: [
                                Text(showMemeberList[index].username),
                                Text(showMemeberList[index].email),
                              ],
                            )
                          ],
                        ),
                      );
                    })
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    LayOut layout = LayOut();
    return layout.mainLayoutWithDrawer(
        context,
        SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:18.0,vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                      Container(
                       width: MediaQuery.of(context).size.width,
                        child: Text(
                          widget.task.task_name,
                          style:TextStyle(
                            fontSize: 24,
                            color: GlobalVariables.greyFontColor
                          ) 
                          ),
                      ),
                      (widget.task.description != '')
                          ? Text("Description" + widget.task.description)
                          : SizedBox(
                              width: 0,
                              height: 0,
                            ),
                      Container(
                          width:MediaQuery.of(context).size.width,
                          child: Text("Created On :" + widget.task.created_at,style: TextStyle(
                            color: GlobalVariables.greyFontColor
                          ),)
                        ),
                      Container(
                        height: 10,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: label
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    height: 85,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                        color: GlobalVariables.textFieldBgColor,
                        
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:8.0, vertical: 10),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: const Column(
                                children: [
                                  CircleAvatar(
                                    
                                   backgroundColor: Color.fromARGB(255, 123, 17, 211),
                                    child: Icon(Icons.format_list_bulleted,color: Colors.white,)
                                  ),
                                  Text("Change Taskplan",style: TextStyle(color: GlobalVariables.greyFontColor, fontSize:12),)
                                ],
                              ),
                      
                            ),
                            const SizedBox(width: 30,),
                            
                            Container(
                              child: const Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.amber,
                                   child:Icon(Icons.move_to_inbox,color: Colors.white,)
                                  ),
                                  Text("Add to My Tasks",style: TextStyle(color: GlobalVariables.greyFontColor, fontSize:12),)
                                ],
                              ),
                      
                            )
                      
                          ],
                        ),
                      ),
                    ),
                  )
                  ,
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: GlobalVariables.textFieldBgColor,
                        
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.label,color: GlobalVariables.greyFontColor,),
                              SizedBox(width: 5,),
                              Text("Label :",style:TextStyle(color:GlobalVariables.greyFontColor)),
                              SizedBox(width: 20,),
                              Container(
                                width: 220,
                                child: BlockPicker(onColorChanged: (color){
                                  setState(() {
                                    label= color;
                                  });
                                },pickerColor: Colors.white,),
                              )
                            ],
                          ),
                          SizedBox(),
                          Container(width: 15,height: 5,)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,)
                  ,
                   Container(
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: GlobalVariables.textFieldBgColor,
                        
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          SizedBox(height: 10,),
                          (showDateTime!=null)?
                          Row(
                                children: [
                                  Icon(Icons.schedule,color: GlobalVariables.greyFontColor,),
                                  SizedBox(width: 5,),
                                  Text("Edit Deadline",style: TextStyle(color: GlobalVariables.greyFontColor),),
                    
                                  ],
                                ):SizedBox(width: 0,height: 0,) ,
                          SizedBox(height:5),
                          Row(
                            
                            children:[
                              SizedBox(width: 5,),
                              (showDateTime!=null)? CustomText.normalText('Date :'):SizedBox(width: 0,height: 0,),
                               (showDateTime!=null)? CustomText.normalText("${showDateTime?.year}-${(showDateTime?.month).toString().padLeft(2,'0')}-${(showDateTime?.day).toString().padLeft(2,'0')}"):SizedBox(width: 0,height: 0,),
                              (showDateTime!=null)?const SizedBox(width: 20,):SizedBox(width: 0,height: 0,),
                              (showTime!=null)?CustomText.normalText('Time :'):SizedBox(width: 0,height: 0,),
                              (showTime!=null)?CustomText.normalText("${(showTime?.hour)?.toString().padLeft(2,'0')}:${(showTime?.minute)?.toString().padLeft(2,'0')}"):SizedBox(width: 0,height: 0,),
                    
                              (showDateTime==null)?Row(
                              children:[
                              SizedBox(width: 5,),
                              GestureDetector(
                              onTap: (){
                                setSchedule();
                              }, child:Row(
                                children: [
                                  Icon(Icons.schedule,color: GlobalVariables.greyFontColor,),
                                  SizedBox(width: 5,),
                                  CustomText.normalText("Set Deadline"),
                    
                                  ],
                                ) 
                              ),]
                              ):SizedBox(width: 0,height: 0,),
                            SizedBox(width: 5,),
                    
                            ],
                          ),
                          SizedBox(height: 14,),
                          Row(
                            children: [
                              SizedBox(width:0),
                              Icon(Icons.add_location,color: GlobalVariables.greyFontColor,),
                              SizedBox(width: 5,),
                              Text("Add Location",style: TextStyle(
                                color: GlobalVariables.greyFontColor
                              ),)
                            ],
                          )
                        ],
                      ),
                    ),
                   ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                            itemCount: subTasks.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical:4),
                                child: Container(
                                  decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: GlobalVariables.textFieldBgColor,
                              
                                     )
                                   ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 32,
                                          child: Row(
                                            children: [
                                              Container(
                                                child: CustomText.normalText(subTasks[index].sub_label),
                                                width: 315,
                                              ),
                                              Container(
                                                    child: GestureDetector(
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) =>
                                                            _buildAddMemberPopup(
                                                                context,
                                                                subTasks[index].stack_id),
                                                      );
                                                    },
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                        color: Colors.white
                                                      ),
                                                      child: const Center(
                                                        child: Icon(
                                                          Icons.add,
                                                          color: GlobalVariables.primaryColor,
                                                        ),
                                                      ),
                                                    )
                                                    ),
                                                  )
                                              
                                            ],
                                          ),
                                        ),
                                        (_subTaskAllocation[subTasks[index].stack_id]?.length!=0)?Container(
                                          height: 60,
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              top:BorderSide(
                                                color: GlobalVariables.textFieldBgColor
                                              )
                                            )
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                                            child: Row(
                                                                              
                                              children: [
                                                Center(
                                                  child: Container(
                                                    width: 330,
                                                    child: ListView.builder(
                                                        shrinkWrap: true,
                                                        scrollDirection: Axis.horizontal,
                                                        itemCount:_subTaskAllocation[subTasks[index].task_id]?.length,
                                                        itemBuilder: (context, subindex) {
                                                          return Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 5),
                                                            child: CustomText.normalText(((_subTaskAllocation[subTasks[index].stack_id])?[subindex])?.username ??''),
                                                          );
                                                        }),
                                                  ),
                                                ),
                                                    
                                              ],
                                            ),
                                          ),
                                        ):SizedBox(width: 0,height: 0,)
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                        (toggleInput)
                            ? Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: GlobalVariables.textFieldBgColor
                                )
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical:8.0, horizontal:5),
                                child: Row(
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width*0.7,
                                        child: TextField(
                                          controller: _subtaskValue,
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              addSubTask(_subtaskValue.text, 1);
                                              _subtaskValue.text = '';
                                              toggleInput = false;
                                            });
                                          },
                                          child: Container(
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: const Text("Add",style: TextStyle(
                                                color:Colors.white
                                              ),),
                                            ),
                                            
                                            decoration: BoxDecoration(
                                              color: GlobalVariables.primaryColor,
                                              borderRadius: BorderRadius.circular(8),
                                              border: Border.all(
                                                  color: GlobalVariables.textFieldBgColor
                                              )
                                            ),
                                          ))

                                    ],
                                  ),
                              ),
                            )
                            : GestureDetector(
                                child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: const Text("+Add Sub Task",style: TextStyle(color: GlobalVariables.greyFontColor),),
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    toggleInput = true;
                                  });
                                },
                              )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        "Edit Task");
  }
}
