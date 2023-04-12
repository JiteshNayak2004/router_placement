import 'package:flutter/material.dart';
import './widgets/chart.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Router Placement',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        // accentColor: Color.fromARGB(255, 68, 236, 255)
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showCard = false;
  String conn = 'Connect';

  Timer? _timer;
  int _counter = 0;
  bool _isActive = false;

  void _toggleTimer() {
    setState(() {
      _isActive = !_isActive;
    });

    if (_isActive) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _counter++;
        });
      });
    } else {
      _timer?.cancel();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Router Placement'),
      ),
      body: LayoutBuilder(builder: (context, constraint) {
        return SingleChildScrollView(
            child: Stack(children: [
          Container(
            child: Container(
              child: Image.asset(
                'assets/images/bg.png',
                fit: BoxFit.cover,
                width: 1000,
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: constraint.maxHeight * 0.4,
              ),
              Container(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 50,
                      child: Padding(
                        padding: EdgeInsets.all(3),
                        child: TextButton(
                            onPressed: () {
                              _toggleTimer();
                              setState(() {
                                _showCard = !_showCard;
                                if (conn == 'Connect') {
                                  conn = 'Stop';
                                  _counter = 0;
                                } else {
                                  conn = 'Connect';
                                  _counter = 0;
                                }
                              });
                            },
                            child: Text(
                              conn,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 33, 58, 243),
                                  fontSize: 20),
                            )),
                      ))),
              if (_showCard) Chart(_counter)
            ],
          )
        ]));
      }),
    );
  }
}