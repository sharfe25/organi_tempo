import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:organi_tempo/components/add_activity.dart';
import 'package:organi_tempo/components/curve_painter.dart';
import 'package:organi_tempo/components/date_picker.dart';
import 'package:organi_tempo/gantt_view.dart';
import 'package:organi_tempo/models/Activity.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  List<Activity> activities = [];

  void _showDialogAddActivity() {
    showModalBottomSheet(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
        context: context,
        useRootNavigator: true,
        isScrollControlled: true,
        builder: (context) {
          return AddAcitivity(
            addNewActivity: addNewAcitivity,
            activities: activities,
          );
        });
  }

  void addNewAcitivity(Activity activity) {
    setState(() {
      activities.add(activity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 29, 156, 163),
      body: SizedBox.expand(
          child: CustomPaint(
        painter: CurvePainter(),
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 20, top: 60),
                child: Row(
                  children: [
                    Align(
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
                    const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "Lista de actividades",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                )),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: activities.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10, left: 15, right: 15),
                        child: Card(
                          shape: const RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.transparent,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          elevation: 0,
                          color: const Color.fromARGB(255, 23, 112, 117),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 15),
                                      child: Text(
                                        activities[index].title,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 15),
                                      child: Ink(
                                          width: 32,
                                          height: 32,
                                          child: IconButton(
                                            iconSize: 17,
                                            color: Colors.white,
                                            icon: const Icon(
                                                FontAwesomeIcons.xmark),
                                            tooltip: 'Delete',
                                            onPressed: () {
                                              setState(() {
                                                activities
                                                    .remove(activities[index]);
                                              });
                                            },
                                          ))),
                                ],
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 5, left: 15, right: 15),
                                  child: Text(
                                    activities[index].description,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  )),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 5),
                                      child: DatePickerItem(
                                        children: <Widget>[
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 10, top: 10, right: 5),
                                            child: Text(
                                              'Inicio:',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10, top: 10),
                                            child: Text(
                                              '${activities[index].startDate.month}-${activities[index].startDate.day}-${activities[index].startDate.year}',
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 5),
                                      child: DatePickerItem(
                                        children: <Widget>[
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                bottom: 10, top: 10, right: 5),
                                            child: Text(
                                              'Final: ',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10, top: 10),
                                            child: Text(
                                              '${activities[index].endDate.month}-${activities[index].endDate.day}-${activities[index].endDate.year}',
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ))
                                ],
                              )
                            ],
                          ),
                        ));
                  }),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 0.0, vertical: 40.0),
              child: CupertinoButton(
                color: const Color.fromARGB(255, 159, 86, 38),
                borderRadius: BorderRadius.circular(20.0),
                onPressed: () {
                  if (activities.length > 0) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GanttView(
                                  activities: activities,
                                ),
                            fullscreenDialog: true));
                  } else {
                    final snackBar = SnackBar(
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20))),
                      content: const Text(
                          'Por favor agregue algunas atividades para poder seguir.'),
                      action: SnackBarAction(
                        label: 'Close',
                        onPressed: () {
                          ScaffoldMessenger.of(context).clearSnackBars();
                        },
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: const Text('Continuar',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 80)
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialogAddActivity();
        },
        backgroundColor: const Color.fromARGB(255, 23, 112, 117),
        child: const Icon(
          FontAwesomeIcons.filePen,
          size: 22,
        ),
      ),
    );
  }
}
