import 'package:flutter/material.dart';
//we will keep updating the location, hence it will be a stateful widget

import 'package:time_app/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  int counter = 0;

  /*this fires once when we first load up the widget of the state object*/

  List<WorldTime> locations = [
    WorldTime(loc_url: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(loc_url: 'Europe/Athens', location: 'Athens', flag: 'greece.png'),
    WorldTime(loc_url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(
        loc_url: 'Africa/Nairobi', location: 'Nairobi', flag: 'kenya.png'),
    WorldTime(loc_url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(
        loc_url: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(
        loc_url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(
        loc_url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
  ];

  /*this index will represent whichever index of the class we want to get*/
  void updateTime(index) async {
    //a local variable to store the instance of whatever real time instance we want to use
    WorldTime inst = locations[index];
    await inst.getTime();
    /*we want to pop out the change location screen, since the home screen is sitting right underneath*/
    Navigator.pop(context, {
      'location': inst.location,
      'flag': inst.flag,
      'time': inst.time_loc,
      'isDayTime' : inst.isDayTime
    });
  }

  @override
  Widget build(
      BuildContext
          context) /*this fires everytime we need to build up the widget tree*/ {
    print("build function ran");
    return Scaffold(
        backgroundColor: Colors.amber,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "CHOOSE LOCATION",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          backgroundColor: Color.fromARGB(255, 215, 8, 77),
          centerTitle: true,
          elevation: 5,
        ),
        body: /* ElevatedButton(
        onPressed: () {
          /* setState() {
            counter += 1;
          }; */
          setState(() {
            counter += 1;
          });
          print("nishant is successful $counter");
        },
        child: Text("Counter value is $counter"),
      ), */
            ListView.builder(
          itemCount: locations.length /*no of items in the list*/,
          itemBuilder: (context, index) {
            /*this will use an item builder function for every single item inside this list*/
            /*it will return a widget template for each item in the list*/
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
              child: Card(
                child: ListTile(
                  onTap: () {
                    updateTime(index);
                  } /*this will fire when we click on this tile*/,
                  title: Text(
                    "${locations[index].location}",
                  ),
                  leading: CircleAvatar(
                    backgroundImage:
                        AssetImage("assets/${locations[index].flag}"),
                  ),
                ),
              ),
            );
          },
        ));
  }
}

//initState function will be used to get data from a third party API
//asynchronous code is something that starts now and ends in future
//assynchronous code should not be non-blocking
//output a template for each item in the list, to do this we will use a ListView builder
//it will return a widget template for each item in the list 

