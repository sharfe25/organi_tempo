import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gantt_chart/gantt_chart.dart';
import 'package:organi_tempo/components/curve_painter.dart';
import 'package:organi_tempo/home_view.dart';
import 'package:organi_tempo/models/Activity.dart';

class GanttView extends StatefulWidget {
  final List<Activity> activities;
  const GanttView({Key? key, required this.activities}) : super(key: key);

  @override
  State<GanttView> createState() => _GanttViewState();
}

class _GanttViewState extends State<GanttView> {
  List<GanttAbsoluteEvent> events = [];
  Activity? startDateActivity;
  Activity? endDateActivity;
  int eventDuration = 0;

  @override
  void initState() {
    super.initState();
    setEvents();
  }

  int daysBetween(DateTime from, DateTime to) {
     from = DateTime(from.year, from.month, from.day);
     to = DateTime(to.year, to.month, to.day);
   return (to.difference(from).inHours / 24).round();
  }

  void setEvents() {
    setState(() {
      endDateActivity = widget.activities.reduce((activityWithStartDate,activity) => activityWithStartDate.endDate.isAfter(activity.endDate) ? activityWithStartDate : activity);
      startDateActivity = widget.activities.reduce((activityWithStartDate,activity) => activityWithStartDate.startDate.isBefore(activity.startDate) ? activityWithStartDate : activity);
      if(startDateActivity != null && endDateActivity != null){
        eventDuration = daysBetween(startDateActivity!.startDate, endDateActivity!.endDate);
      }
    });
    
    for (var activity in widget.activities) {
      setState(() {
        events.add(
          GanttAbsoluteEvent(
            startDate: activity.startDate,
            endDate: activity.endDate,
            displayName: activity.title,
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: const Color.fromARGB(255, 29, 156, 163),
            child: CustomPaint(
              painter: CurvePainter(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0, left: 10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Ink(
                          width: 32,
                          height: 32,
                          child: IconButton(
                            iconSize: 17,
                            color: Colors.white,
                            icon: const Icon(FontAwesomeIcons.angleLeft),
                            tooltip: 'Back',
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 15.0, top: 10.0),
                    child: Text(
                      "Diagrama de Gantt",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 12, left: 15),
                    child: Text(
                      "Este diagrama contiene los intervalos de tiempo de cada actividad que va a realizar, lo cual lo ayudara a organizar su tiempo y mantenerse mas productivo.",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 1.0, vertical: 30.0),
                    child: GanttChartView(
                      maxDuration: Duration(
                          days: eventDuration), //optional, set to null for infinite horizontal scroll
                      startDate: startDateActivity!.startDate, //required
                      dayWidth: 30, //column width for each day
                      eventHeight: 30, //row width for events
                      stickyAreaWidth: 200, //sticky area width
                      showStickyArea: true, //show sticky area or not
                      showDays: true, //show days or not
                      startOfTheWeek: WeekDay.sunday, //custom start of the week
                      weekEnds: const {
                        WeekDay.friday,
                        WeekDay.saturday
                      }, //custom weekends
                      events: events,
                    ),
                  ),
                ],
              ),
            )));
  }
}
