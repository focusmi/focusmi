// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:focusmi/constants/utils.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/features/group_task_planner/services/group_task_planner_services.dart';
import 'package:focusmi/models/taskplan.dart';
import 'package:focusmi/providers/user_provider.dart';

class MyDropDownList extends StatefulWidget {
  int taskid;
  MyDropDownList({
    Key? key,
    required this.taskid,
  }) : super(key: key);

  @override
  State<MyDropDownList> createState() => _MyDropDownListState();
}

class _MyDropDownListState extends State<MyDropDownList> {
  void getTaskPlan() {}
  late List<TaskPlan> taskPlans;
  List<TaskPlan> items = [];
  String? selectedValue;
  late int taskplanid;
  @override
  void initState() {
    taskPlans = List<TaskPlan>.empty(growable: true);
    // TODO: implement initState
    _getTaskPlan()
    ;
    super.initState();
  }

  void _getTaskPlan() async {
    var user_id =
        Provider.of<UserProvider>(context, listen: false).user.user_id;
    Response response = await GTaskPlannerServices.getITaskPlanByUser(user_id);
    Iterable list = json.decode(response.body).cast<Map<String?, dynamic>>();
    setState(() {
      taskPlans = list.map((model) => TaskPlan.fromJson(model)).toList();
    });
  }

  void moveTask(planid) async {

    try {
      GTaskPlannerServices.setTaskAttr('plan_id', widget.taskid, planid);
      showSuccessSnackBar(context, "Task Moved Successfully");
    } catch (e) {
      print("move task");
      print(e);
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: const Row(
            children: [
              Icon(
                Icons.list,
                size: 16,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: Text(
                  'Select Task Plan',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          items: taskPlans
              .map((TaskPlan item) => DropdownMenuItem<String>(
                    value: item.plan_id.toString(),
                    child: Text(
                      item.plan_name.toString(),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value;
              moveTask(value);
            });
          },
          buttonStyleData: ButtonStyleData(
            height: 50,
            width: 160,
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.black26,
              ),
              color: GlobalVariables.primaryColor,
            ),
            elevation: 2,
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(
              Icons.arrow_forward_ios_outlined,
            ),
            iconSize: 14,
            iconEnabledColor: Colors.white,
            iconDisabledColor: Colors.grey,
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: GlobalVariables.primaryColor,
            ),
            offset: const Offset(-20, 0),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: MaterialStateProperty.all(6),
              thumbVisibility: MaterialStateProperty.all(true),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.only(left: 14, right: 14),
          ),
        ),
      ),
    );
  }
}
