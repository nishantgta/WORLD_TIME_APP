//initial loading screen when we first fire the app
import 'package:flutter/material.dart';

//
import 'package:time_app/services/world_time.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  /*asyn keyword tells that this is going to be a asynchronous function */
  /*by doing asynchronous,the control will not wait for the getData() to complete*/
  /*  void getData() async {
    //simulate network request for a username
    //await means wait until this is done, and then start the next line of code
    String name = await Future.delayed(Duration(seconds: 3), () {
      return "Navroop";
    }); //use the future object and we will see more about the future shortly
    /* delay->how many seconds we want this to be delayed for */
    /* the function when those 3 seconds are up */
    /* this is a non-blocking code, if you have code below this function executions, then it will run and after three seconds this code will run */

    String bio="";
    bio = await Future.delayed(Duration(seconds: 3), () {
      return "GODFATHER";
    });
    print("$name-$bio");
  } */

  /* void getData() async {
    //we will use the http package to make a network request to get data
    Response response =
        await get(Uri.parse('https://jsonplaceholder.typicode.com/todos/1'));
    //the response variable will store the data
    print(response
        .body); /*you will get a JSON string as an output and you need to convert it so that you can use it*/

    Map data = jsonDecode(response
        .body); /*  JSON string converted into usable data,this will be a map */
    print(data["title"]);
  } */

  void setupWorldTime() async {
    //this function is going to create a new instance of a real time class
    WorldTime example = WorldTime(
        location: "Berlin", flag: "germany", loc_url: "Europe/Berlin");
    await example.getTime();
    //push the time to the home page by using Navigation
    Navigator.pushReplacementNamed(context, "/home", arguments: {
      'location': example.location,
      'flag': example.flag,
      'time': example.time_loc,
      'isDayTime' : example.isDayTime
    });
    //arguments are used to transfer the data
  }

  @override /*we are overriding the init function inhereited from the State class*/
  void initState() {
    super.initState();
    setupWorldTime();
    //print("initState function ran");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitFadingFour(
        color: Colors.brown,
        size: 150.0,
      ),
      ),
    );
  }
}

/* when we run the app, first the loading screen comes, initState runs once, it calls setupWorldTime, which create a real time object and then gets the time properties */
/*getTime is an async function, the control will move on before the getTime even finishes*/
/*so a better option is to introduce await ahead of setupWorldTime,*/
/*you will get an error because you are not returning a specific type that we need */
/*we have to redirect the samay back to the home screen*/
/*pushNamed will keep the current page just below the page that we are going to*/
/*pushReplacementNamed will replace the new page with the current page*/
/*we also want data to be transferred from loading screen to home screen*/
/*we passed data in the form of a map*/
/*use any name after the SpinKit so as to display corresponding loading object*/
