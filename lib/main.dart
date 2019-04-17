import 'package:flutter/material.dart';
import 'dog_model.dart';
import 'dog_card.dart';
import 'dog_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    /*
    MaterialApp is the base widget for a Flutter Application. Gives us access to routing, context and meta info functionality.
    */

    return MaterialApp(
      title: 'We rate dogs',
      theme: ThemeData(brightness: Brightness.dark),
      home: MyHomePage(title: 'We rate dogs'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Dog> initialDoggos = []
  ..add(Dog('Ruby', 'Portland, OR, USA', 'Ruby is a very good girl. Yes: Fetch, loungin\'. No: Dogs who get on forniture'))
  ..add(Dog('Rex', 'Seattle, WA, USA', 'Best in Show 1999'))
  ..add(Dog('Rod Stewart', 'Prague, CZ', 'Star good boy on international snooze team.'))
  ..add(Dog('Herbert', 'Dallas, TX, USA', 'A Very Good Boy'))
  ..add(Dog('Buddy', 'North Pole, Earth', 'Self proclaimed human lover.'));

  @override
  Widget build(BuildContext context) {
    /*∫
    Scaffold is the base for a page. It gives an AppBar for the top, Space for the main body, bottom navigation and more.
    */

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        decoration: BoxDecoration(
          // BoxDecoration takes a gradient
          gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment.topRight,
            end: Alignment.topLeft,
            // And one stop for each color. Stops should increase from 0 to 1.
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              Colors.indigo[800],
              Colors.indigo[700],
              Colors.indigo[600],
              Colors.indigo[400],
            ],
          ),
        ),
        child: Center(
          child: DogList(initialDoggos),
        ),
      ),
    );
  }
}