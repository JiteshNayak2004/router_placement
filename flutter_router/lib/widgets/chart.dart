import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import './ip_address.dart';
import './signal_strength.dart';
import 'dart:async';

class Chart extends StatelessWidget {
  // const Chart({super.key});

  final int counter;

  Chart(this.counter);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
        ),
        Container(
          child: Card(
            elevation: 6,
            // margin: EdgeInsets.all(30),
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            color: Color.fromARGB(73, 0, 0, 0),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text(
                        // '00:00:00',
                        counter.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Duration'.toUpperCase(),
                        style:
                            // TextStyle(color: Color.fromARGB(255, 82, 82, 82)),
                            TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Column(
                    children: [
                      // Text(
                      //   '0 dBm',
                      //   style: TextStyle(color: Colors.white),
                      // ),
                      Signal(),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Signal Strength'.toUpperCase(),
                        style:
                            // TextStyle(color: Color.fromARGB(255, 82, 82, 82)),
                            TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Column(
                    children: [
                      // Text(
                      //   '00:00:00 ',
                      //   style: TextStyle(color: Colors.white),
                      // ),
                      IP(),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'IP ADDRESS'.toUpperCase(),
                        style:
                            // TextStyle(color: Color.fromARGB(255, 82, 82, 82)),
                            TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}