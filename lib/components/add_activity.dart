import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:organi_tempo/components/date_picker.dart';
import 'package:organi_tempo/models/Activity.dart';

class AddAcitivity extends StatefulWidget {
  final void Function(Activity) addNewActivity;
  final List<Activity> activities;
  const AddAcitivity(
      {Key? key, required this.addNewActivity, required this.activities})
      : super(key: key);

  @override
  _AddAcitivity createState() => _AddAcitivity();
}

class _AddAcitivity extends State<AddAcitivity> {
  final TextStyle textStyle =
      const TextStyle(color: Colors.white, fontSize: 14.0);
  final OutlineInputBorder whiteBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(20.0),
    borderSide: const BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
  );
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool dateAlert = false;
  @override
  void initState() {
    super.initState();
  }

  void addNewActivity() {
    if (startDate.isBefore(endDate)) {
      dateAlert = false;
      Activity activity = Activity(
          id: widget.activities.length + 1,
          title: titleController.text,
          description: descriptionController.text,
          startDate: startDate,
          endDate: endDate);
      widget.addNewActivity(activity);
      _formKey.currentState?.reset();
      Navigator.pop(context);
    } else {
      setState(() {
        dateAlert = true;
      });
    }
  }

  void _showDateDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              // The Bottom margin is provided to align the popup above the system navigation bar.
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              // Provide a background color for the popup.
              color: CupertinoColors.systemBackground.resolveFrom(context),
              // Use a SafeArea widget to avoid system overlaps.
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }

  Widget startDateBuild() {
    return GestureDetector(
        onTap: () {
          return _showDateDialog(
            CupertinoDatePicker(
              backgroundColor: Colors.white,
              initialDateTime: startDate,
              mode: CupertinoDatePickerMode.date,
              use24hFormat: true,
              // This is called when the user changes the date.
              onDateTimeChanged: (DateTime newDate) {
                setState(() => startDate = newDate);
              },
            ),
          );
        },
        child: DatePickerItem(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(bottom: 10, top: 10, right: 5),
              child: Text(
                'Inicio:',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 10),
              child: Text(
                '${startDate.month}-${startDate.day}-${startDate.year}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ));
  }

  Widget endDateBuild() {
    return GestureDetector(
        onTap: () {
          return _showDateDialog(
            CupertinoDatePicker(
              backgroundColor: Colors.white,
              initialDateTime: endDate,
              mode: CupertinoDatePickerMode.date,
              use24hFormat: true,
              // This is called when the user changes the date.
              onDateTimeChanged: (DateTime newDate) {
                setState(() => endDate = newDate);
              },
            ),
          );
        },
        child: DatePickerItem(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(bottom: 10, top: 10, right: 5),
              child: Text(
                'Final: ',
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 10),
              child: Text(
                '${endDate.month}-${endDate.day}-${endDate.year}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ));
  }

  Widget buildTitle() {
    return TextFormField(
      controller: titleController,
      decoration: InputDecoration(
        border: whiteBorder,
        focusedBorder: whiteBorder,
        enabledBorder: whiteBorder,
        isDense: true,
        filled: true,
        labelText: "Titulo",
        labelStyle: const TextStyle(color: Colors.white),
        fillColor: const Color.fromARGB(0, 255, 255, 255),
        errorBorder: whiteBorder,
        errorStyle:
            const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      cursorColor: const Color.fromARGB(255, 255, 255, 255),
      textCapitalization: TextCapitalization.none,
      style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
      enableSuggestions: false,
      autocorrect: false,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Este campo es requerido';
        }
        return null;
      },
    );
  }

  Widget buildDescription() {
    return TextFormField(
      maxLines: 5,
      controller: descriptionController,
      decoration: InputDecoration(
        border: whiteBorder,
        focusedBorder: whiteBorder,
        enabledBorder: whiteBorder,
        isDense: true,
        filled: true,
        labelText: "Descripción",
        labelStyle: const TextStyle(color: Colors.white),
        fillColor: const Color.fromARGB(0, 255, 255, 255),
        errorBorder: whiteBorder,
        errorStyle:
            const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      cursorColor: const Color.fromARGB(255, 255, 255, 255),
      textCapitalization: TextCapitalization.none,
      style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
      enableSuggestions: false,
      autocorrect: false,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Este campo es requerido';
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DraggableScrollableSheet(
        initialChildSize: 0.6,
        builder: (BuildContext context, ScrollController scrollController) {
          return Material(
              color: Color.fromARGB(197, 95, 95, 95),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(30)),
              child: SingleChildScrollView(
                  child: Column(children: [
                const Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: Text(
                    "Agregar una actividad",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Form(
                    key: _formKey,
                    child: Column(children: [
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 5),
                          child: Visibility(
                            visible: dateAlert,
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Color.fromARGB(255, 199, 30, 30),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              elevation: 0,
                              color: Color.fromARGB(0, 23, 112, 117),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 20, right: 20, bottom: 10),
                                child: Row(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Icon(
                                      FontAwesomeIcons.circleExclamation,
                                      color: Color.fromARGB(255, 199, 30, 30),
                                    ),
                                  ),
                                  TextFormField(
                                    enabled: false,
                                    maxLines: 3,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    filled: true,
                                    labelText: "La fecha de finalizacion de la actividad debe ser posterior a la de inicio.",
                                    labelStyle:textStyle,
                                    fillColor: const Color.fromARGB(0, 255, 255, 255),
                                  ),
                                  )
                                ]),
                              ),
                            ),
                          )),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 15, left: 20, right: 20),
                        child: buildTitle(),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 20, right: 20),
                        child: buildDescription(),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: startDateBuild()),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: endDateBuild())
                          ],
                        ),
                      ),
                    ])),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 30),
                  child: CupertinoButton(
                    color: const Color.fromARGB(255, 29, 156, 163),
                    borderRadius: BorderRadius.circular(20.0),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        addNewActivity();
                      }
                    },
                    child: const Text('Crear',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ])));
        },
      ),
    );
  }
}
