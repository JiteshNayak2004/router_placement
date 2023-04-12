import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:permission_handler/permission_handler.dart';

class Signal extends StatefulWidget {
  const Signal({super.key});

  @override
  State<Signal> createState() => _SignalState();
}

class _SignalState extends State<Signal> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  ConnectivityResult _result = ConnectivityResult.none;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on Exception catch (e) {
      print(e.toString());
      result = ConnectivityResult.none;
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _result = result;
    });
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    setState(() {
      _result = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text('${-100 + _result.index * 2} dBm',
        style: TextStyle(color: Colors.white));
  }
}