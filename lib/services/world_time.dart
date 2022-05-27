import 'package:flutter/material.dart';

//import the http package to use it
import 'package:http/http.dart';

//this will allow us to convert JSON string into something we can work with
import 'dart:convert';

import 'package:intl/intl.dart';

class WorldTime {
  /*we declare location property, it is the actual location that we show on the UI*/
  String location = ""; //location name for the UI
  String time_loc = ""; //time of that location
  String flag = ""; //URL to our flag icon
  String loc_url = ""; //Continent and name of the location

  bool isDayTime = true; /*if true then is day otherwise it is night*/

  /*constructor, we are expecting to receive all of these different values when we create a new instance of this real time class*/
  WorldTime(
      {required this.location, required this.flag, required this.loc_url});

  /*this is telling dart that the function is temporarily going to return what is the future, its a placeholder value unitl a function is complete, it wraps void type and conveys that at some point I am going to return void but only when the asynchronous function is fully complete*/
  Future<void> getTime() async {
    try {
      /*make the request*/
      Response response = await get(
          Uri.parse("https://worldtimeapi.org/api/timezone/$loc_url"));
      Map time = jsonDecode(response.body);
      //print(time);

      /*get properties from data */
      String date_time = time["datetime"];
      String offset = time["utc_offset"];
      /*so that we only get the offset*/
      int int_offset = 0;

      if (offset[0] == '+')
        int_offset = int.parse(offset.substring(1, 3));
      else if (offset[0] == '-')
        int_offset = -int.parse(offset.substring(1, 3));

      /* print(date_time);
    print(offset); */

      /*create datetime object*/
      DateTime yo =
          DateTime.parse(date_time); /*this will give us a datetime object*/
      //print(offset);

      //print(yo);
      /*add the offset to the datetime object as an integer*/
      yo = yo.add(Duration(hours: int_offset));
      //print(yo);

      isDayTime = (yo.hour > 6 && yo.hour < 20) ? true : false;

      //set the time property
      //time_loc = yo.toString();
      time_loc = DateFormat.jm().format(yo);
    } catch (e) {
      print("caught error=$e");
      time_loc = "couldn't get time data";
    }
  }
}
