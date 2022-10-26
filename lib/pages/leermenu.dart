import 'package:flutter/material.dart';

class MyCard extends StatefulWidget {
   const MyCard({super.key});
  @override
  _State createState() => _State();
}

class _State extends State<MyCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffeeeeee),
      appBar: AppBar(
        title: Text('Card'),
      ),
      body: Center(
        child: Card(
          color: Colors.white,
          elevation: 10.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Try not to become a man of success , but rather try to become a man of value.',
                  style: TextStyle(fontSize: 15.0),
                ),
                SizedBox(height: 10.0),
                Text(
                  '-Albert Einstein',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}