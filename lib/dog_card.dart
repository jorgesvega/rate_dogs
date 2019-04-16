import 'package:flutter/material.dart';
import 'dog_model.dart';

/*
NOTES

Passing data to a Stateful Widget: https://stackoverflow.com/questions/50818770/passing-data-to-a-stateful-widget

*/

class DogCard extends StatefulWidget {
  final Dog dog;

  DogCard(this.dog);

  @override
  _DogCardState createState() => _DogCardState(dog);
}

class _DogCardState extends State<DogCard> {

  Dog dog;

  _DogCardState(this.dog);

  // @override
  // Widget build(BuildContext context) {
  //   return Text(widget.dog.name);
  // }

  String renderUrl; // A class property that represents the URL flutter will render from the Dog class.

  Widget get dogImage {
    return Container(
      width: 100.0,
      height: 100,
      /*
      Decoration is a property that lets you style the container. It expects a BoxDecoration.
      */
      decoration: BoxDecoration(
        /*
        Decoration have many possible properties. Using BoxShape with a background iage is the easiest way to make a circle cropped avatar style image.
        */
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          /*
          A NetworkImage widget is a widget that takes a URL to an image. ImageProviders are ideal when your image needs to be loaded or can change. Use the null check to avoid an error.
          */
          image: NetworkImage(renderUrl ?? ''),
        ),
      ),
    );
  }

  /*
  State classes run this method when the state is created. You shouldn't do async work in initState, so we'll defer it to another method.
  */
  void initState() {
    super.initState();
    renderDogPic();
  }

  /*
  IRL, we'd want the Dog class itself to get the image, but this is a simpler way to explain Flutter basics.
  */
  void renderDogPic() async {
    // This makes the service call
    await dog.getImageUrl();
    /*
    setState tells Flutter to rerender anything that's been changed. Cannot be async, so we use a variable that can be overwritten 
    */
    setState(() {
      renderUrl = dog.imageUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Start with a container so we can add layout and style properties.
    return Container(
      // Arbitrary number
      height: 115.0,
      child: Stack(
        children: <Widget>[
          // Position our dog image, so we can explicitly place it. We'll place it after we've made the card.
          Positioned(
            child: dogImage,
          )
        ],
      ),
    );
  }
}