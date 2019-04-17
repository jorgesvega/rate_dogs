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
        child: Center(
          child: DogList(initialDoggos),
        ),
      ),
    );
  }
}