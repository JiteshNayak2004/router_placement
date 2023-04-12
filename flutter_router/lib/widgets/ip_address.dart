import 'dart:async';
import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class IP extends StatefulWidget {
  const IP({Key? key}) : super(key: key);

  @override
  _IPState createState() => _IPState();
}

class _IPState extends State<IP> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  ConnectivityResult _result = ConnectivityResult.none;
  late String _ipAddress = '';

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    getIpAddress();
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

  Future<void> getIpAddress() async {
    final networkInfo = NetworkInfo();
    final ipAddress = await networkInfo.getWifiIP();
    setState(() {
      _ipAddress = ipAddress!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '$_ipAddress',
      style: TextStyle(color: Colors.white),
    );
  }
}