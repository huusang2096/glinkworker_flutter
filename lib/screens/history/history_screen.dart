import 'package:flutter/material.dart';


class HistoryScreen extends StatelessWidget {

  static provider(){
    return HistoryScreen();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SizedBox.expand(
          child: Center(
            child:Text('HistoryScreen')
          ),
        ),
      ),
    );
  }
}
