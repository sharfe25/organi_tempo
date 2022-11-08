import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:organi_tempo/components/curve_painter.dart';
import 'package:organi_tempo/home_view.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: const Color.fromARGB(255, 29, 156, 163),
            child: CustomPaint(
                painter: CurvePainter(),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/timetable.png',
                        height: 160,
                        width: 160,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 40.0),
                        child: Text(
                          "Bienvenido!",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 12),
                        child: Text(
                          "Comencemos a organizar tu tiempo",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0.0, vertical: 40.0),
                        child: CupertinoButton(
                          color: const Color.fromARGB(255, 240, 151, 91),
                          borderRadius: BorderRadius.circular(20.0),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeView(),
                                    fullscreenDialog: true));
                          },
                          child: const Text('Vamos!',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ))));
  }
}


