import "package:focusmi/features/appointment/screens/select_councillor.dart";
import "package:focusmi/features/authentication/screens/auth-otp-insert.dart";
import "package:focusmi/features/authentication/screens/auth_choic_screen.dart";
import "package:focusmi/features/authentication/screens/auth_screen.dart";
import "package:focusmi/features/authentication/screens/choose-package.dart";
import "package:focusmi/features/authentication/screens/packages_page.dart";
import "package:focusmi/features/authentication/screens/sigin_screen.dart";
import "package:focusmi/features/authentication/widgets/packages_widget.dart";
import "package:focusmi/features/chat_application/screens/chat_page.dart";
import "package:focusmi/features/group_task_planner/screens/single_task_view.dart";
import "package:focusmi/features/group_task_planner/screens/task_plan_view.dart";
import "package:focusmi/features/individual_task_planner/screens/calendar_task.dart";
import "package:focusmi/features/individual_task_planner/screens/itask_plan_view.dart";
import "package:focusmi/features/individual_task_planner/screens/single_itask_view.dart";
import "package:focusmi/features/mainpage/screens/main_page.dart";
import "package:focusmi/features/mainpage/screens/notification_page.dart";
import "package:focusmi/features/mindfulness_courses/screens/cat_courses.dart";
import "package:focusmi/features/mindfulness_courses/screens/course_content.dart";
import "package:focusmi/features/mindfulness_courses/screens/course_media_player.dart";
import "package:focusmi/features/mindfulness_courses/screens/levels.dart";
import "package:focusmi/features/pomodoro_timer/screens/break_view.dart";
import "package:focusmi/features/pomodoro_timer/screens/pomodoro_timer_view.dart";
import "package:focusmi/features/pomodoro_timer/widgets/countdown_timer.dart";
import "package:focusmi/features/task_group.dart/screens/create_group.dart";
import "package:focusmi/features/task_group.dart/screens/edit_task_group.dart";
import "package:focusmi/features/task_group.dart/screens/group_list.dart";
import "package:flutter/material.dart";
import "package:focusmi/models/course_level.dart";
import "package:focusmi/models/mindfulnesscourses.dart";
import "package:focusmi/models/subtask.dart";
import "package:focusmi/models/task.dart";
import "package:focusmi/models/taskgroup.dart";
import "package:focusmi/models/taskplan.dart";

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    case MainScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const MainScreen(),
      );
    case CreateGroup.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const CreateGroup(),
      );
    case Calendar.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Calendar(),
      );
    case LandingPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const MainScreen(),
      );
    case SignScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SignScreen(),
      );
    case GroupList.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const GroupList(),
      );
    case NotiList.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const NotiList(),
      );
    case EditTaskGroup.routeName:
      final TaskGroup args = routeSettings.arguments as TaskGroup;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => EditTaskGroup(group: args),
      );
    case GroupTaskPlanner.routeName:
      final int group = (routeSettings.arguments as List<dynamic?>)[0];
      final int? planid = (routeSettings.arguments as List<dynamic?>)[1];
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => GroupTaskPlanner(
          group: group,
          plan_id: planid,
        ),
      );
    case ITaskPlanner.routeName:
      final int group = (routeSettings.arguments as List<dynamic?>)[0];
      final int? planid = (routeSettings.arguments as List<dynamic?>)[1];
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => ITaskPlanner(
          user_id: group,
          plan_id: planid,
        ),
      );
    case SingleTaskView.routeName:
      final Task args = routeSettings.arguments as Task;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => SingleTaskView(task: args),
      );
    case ITaskView.routeName:
      final Task args = routeSettings.arguments as Task;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => ITaskView(task: args),
      );
    case CounselorsListWidgetWidget.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => CounselorsListWidgetWidget(),
      );
    case OTPinsert.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => OTPinsert(),
      );
    case ChoosePackage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => ChoosePackage(),
      );
    case PomodoroTimerScreen.routeName:
      final Task args = routeSettings.arguments as Task;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => PomodoroTimerScreen(task: args),
      );
    case CountdownTimer.routeName:
      final Task args = routeSettings.arguments as Task;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => CountdownTimer(task: args),
      );
    case SubscriptionPackagesPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => SubscriptionPackagesPage(),
      );
    case CourseMediaPlayer.routeName:
      final MindfulnessCourse course =
          (routeSettings.arguments as List<dynamic>)[1];
      final MindfulnessCourseLevel level =
          (routeSettings.arguments as List<dynamic>)[0];
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => CourseMediaPlayer(
          level: level,
          course: course,
        ),
      );
    // case ChatRoom.routeName:
    //   final int arg = routeSettings.arguments as int;
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (context) => ChatRoom(
    //       group_id: arg,
    //     ),
    //   );
    
    case BreakView.routeName:
      final Task args = (routeSettings.arguments as List<dynamic>)[0];
      final int btime = (routeSettings.arguments as List<dynamic>)[1];
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => BreakView(
          task: args,
          btime: btime,
        ),
      );
    case LevelsWidget.routeName:
      final MindfulnessCourse args =
          (routeSettings.arguments as MindfulnessCourse);
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => LevelsWidget(
          course: args,
        ),
      );
    case CourseContentWidget.routeName:
      final MindfulnessCourse args =
          (routeSettings.arguments as MindfulnessCourse);
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => CourseContentWidget(course: args),
      );
    case CatLevelWidget.routeName:
      final String args = (routeSettings.arguments as String);
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (context) => CatLevelWidget(
                type: args,
              ));
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Text("Wrong Page !"),
        ),
      );
  }
}
