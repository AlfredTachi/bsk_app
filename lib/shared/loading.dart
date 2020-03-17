import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo[400],
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.indigo[900],
          size: 200.0,
        ),
      ),
    );
  }
}