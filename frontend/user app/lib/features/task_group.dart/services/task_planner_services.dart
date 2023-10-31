import 'package:focusmi/constants/global_variables.dart';
import 'package:focusmi/models/taskplan.dart';
import 'package:http/http.dart' as http;

class TaskPlannerServices{

  static void createTaskPlan(groupid, planname, location, schedule_date, schedule_type, time, reminder_status)async{
    try{
      var taskPlan =  TaskPlan(plan_id: 0, group_id: groupid, plan_name: planname, location: location, schedule_date: schedule_date, schedule_type: schedule_type, time: time, reminder_status: reminder_status, created_date: '');
      http.Response res = await http.post(Uri.parse('$uri/api/create-task-plan'),body:taskPlan.toJson(),headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      });
    }
    catch(e){
      print(e);
    }
  }
  

}