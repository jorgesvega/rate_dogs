import 'package:flutter/material.dart';

class AddDogFormPage extends StatefulWidget {
  @override
  _AddDogFormPageState createState() => _AddDogFormPageState();
}

class _AddDogFormPageState extends State<AddDogFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new dog'),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        color: Colors.black87,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 32.0,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                // Text FIeld is the basic input widget for Flutter
                // It comes built in with a ton of great UI and functionality
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Name the Pup'
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Pup's location",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'All about the pup',
                  ),
                ),
              ),
              // A piece of the app that you'll add in the next section "needs"
              // to know it's context, and the easiest way to pass a context is to
              // use a builder method. Wrap this button in a Builder as a sort of 'hack'.
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Builder(
                  builder: (context) {
                    // The basic Material Design action button
                    return RaisedButton(
                      // If onPressed is null, the button is disabled
                      onPressed: () => print('PRESSED'), // temporary goto callback
                      color: Colors.indigoAccent,
                      child: Text('Submit Pup'),
                    );
                  },
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}