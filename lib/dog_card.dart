import 'package:flutter/material.dart';
import 'dog_model.dart';
import 'dog_detail_page.dart';
import 'package:flutter/scheduler.dart';

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

  String
      renderUrl; // A class property that represents the URL flutter will render from the Dog class.

  Widget get dogImage {
    // Wrap the dogAvatar widget in a Hero widget
    var dogAvatar = Hero(
      // Give your hero a tag
      // Flutter looks for two widgets on two different pages
      // and if the have the same tag it animates between them
      tag: dog,
      child: Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(renderUrl ?? ''),
          ),
        ),
      ),
    );

    // Placeholder is a static container the same size as the dog image
    var placeholder = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
          colors: [Colors.black54, Colors.black, Colors.blueGrey[600]],
        ),
      ),
      alignment: Alignment.center,
      child: Text('DOGGO', textAlign: TextAlign.center),
    );

    // This is an animated widget built into Flutter
    return AnimatedCrossFade(
      // You pass it the starting widget and the ending widget
      firstChild: placeholder,
      secondChild: dogAvatar,
      // Then you pass it a ternary that should be based on your state
      //
      // If renderUrl is null tell the widget to use the placeholder,
      // otherwise use the dogAvatar
      crossFadeState: renderUrl == null
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      // Finally, pass in the amount of time the fade should take
      duration: Duration(milliseconds: 1000),
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
    timeDilation = 1.5;
    // Start with a container so we can add layout and style properties.
    // InkWell is a special material widget that makes its children tapable and adds Material Design ink ripple when tapped
    return InkWell(
      // onTap is a callback that will be triggered when tapped
      onTap: showDogDetailPage,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
          // Arbitrary number
          height: 115.0,
          child: Stack(
            children: <Widget>[
              // Position our dog image, so we can explicitly place it. We'll place it after we've made the card.
              Positioned(
                left: 50.0,
                child: dogCard,
              ),
              Positioned(top: 7.5, child: dogImage),
            ],
          ),
        ),
      ),
    );
  }

  // This is the builder method that creates a new page
  showDogDetailPage() {
    // Navigator.of(context) accesses the current app¡s navigator
    // Navigators can 'push' new routes onto the stack
    // as well as pop routes off the stack
    // Easiest way and pass that page some state from the current page
    Navigator.of(context).push(MaterialPageRoute(
        // builder method always take context
        builder: (context) {
      return DogDetailPage(dog);
    }));

    /*
    Flutter automatically adds a leading button to an AppBar, which pops a route off. 
    You can override it in the AppBar widget if you ever need to.
    */
  }

  Widget get dogCard {
    return Container(
      width: 290.0,
      height: 115.0,
      child: Card(
        color: Colors.black87,
        // Wrap children in a Padding widget in order to give padding
        child: Padding(
          // The class that controls padding is called 'EdgeInsets'
          // The EdgeInsets.only constructor is used to set padding explicitly to each side of the child
          padding: const EdgeInsets.only(
            top: 8.0,
            bottom: 8.0,
            left: 64.0,
          ),
          // Column is another layout widget (like stack) that
          // takes a list of widgets as children, and lays the
          // widget out from top to bottom.
          child: Column(
            // These alignment properties function exactly like CSS flexbox properties
            // The main axis of a colum is the vertical axis,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(widget.dog.name,
                  // Themes are set in the MaterialApp widget at the root of your app.
                  // The have default values
                  // Useful for having consistent, app-wide styling that's easily changed
                  style: Theme.of(context).textTheme.subhead),
              Row(
                children: <Widget>[
                  Icon(Icons.star),
                  Text(': ${widget.dog.rating} / 10')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
