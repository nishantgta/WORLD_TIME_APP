import 'package:flutter/material.dart';
import 'package:time_app/pages/choose_location.dart';
import 'package:time_app/pages/home.dart';
import 'package:time_app/pages/loading.dart';

void main() {
  runApp(MaterialApp(
    /* home will be shown on the home screen */
    /*for testing purpose, we need first screen to be home, but by default the screen is Loading screen, so we use initialRoute to change the default opening screen */
    initialRoute: "/", 
    routes: {
      '/': ((context) => Loading()),
      '/home': ((context) => Home()),
      '/location':((context) => ChooseLocation()),
    },
  ));
}

/*in this app we will have three screens */
//a home screen which shows the time
//loading screen
//user can update the location and choose different place
//keys in routes will be actual routes themselves,
/* values to the routes are the function, these function takes the context object as an argument */
/*context object keeps the track of where in the widget tree we are*/
/*routes are pushed and popped in a way similar to the stack, */
//flutter packages can be use to implement complex functionalities
