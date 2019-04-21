import 'package:flutter/material.dart';
import 'dog_model.dart';

class AddDogFormPage extends StatefulWidget {
  @override
  _AddDogFormPageState createState() => _AddDogFormPageState();
}

class _AddDogFormPageState extends State<AddDogFormPage> {
  // One TextEditingController for each form input:
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  // You'll need the context in order for the Navigator to work
  void submitPup(BuildContext context) {
    // First make sure there is some information in the form
    // A dog needs a name, but may be location independent,
    // so we'll only abandon the save if there's no name
    // TODO: Replace with a builder
    if (nameController.text.isEmpty) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('Pup need names!'),
          /*
          In the build method on this page, the RaisedButton is wrapped in a Builder. 
          A builder creates a new scaffold under the hood. It's a new page, a new BuildContext, etc.
          This new scaffold is necessary to show Snackbars (aka toasts on the web) because they are an element that is on another page, waiting to be called like any page would be.
          The better way to do this would be to make a whole new stateless widget that's just a RaisedButton that shows a Snackbar on pressed.
          */
        )
      );
    } else {
      // Create a new dog with the information from the form
      var newDog = Dog(nameController.text, locationController.text,
          descriptionController.text);
      // Pop the page off the route stack and pass the new dog back
      // to wherever this page was created
      Navigator.of(context).pop(newDog);
    }
  }

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
                      // Tell your textfield which controller it owns
                      controller: nameController,
                      // Every single time the text changes in a TextField, this onChanged callback is called
                      // and it passes in the value.
                      //
                      // Set the text of your controller to the next value
                      onChanged: (v) => nameController.text = v,
                      decoration: InputDecoration(labelText: 'Name the Pup')),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextField(
                    controller: locationController,
                    onChanged: (v) => locationController.text = v,
                    decoration: InputDecoration(
                      labelText: "Pup's location",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: TextField(
                    controller: descriptionController,
                    onChanged: (v) => descriptionController.text = v,
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
                        onPressed: () => submitPup(context),
                        color: Colors.indigoAccent,
                        child: Text('Submit Pup'),
                      );
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
