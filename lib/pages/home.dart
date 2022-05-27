import 'package:flutter/material.dart';
//create a stateful widget, as we need to update data

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    /*this is where we receive the actual data*/
    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map; /*these will be the arguments that we receive */
    /*why not use setState, coz this is the first time the build function runs, */
    print(data);

    String background = (data["isDayTime"]) ? "Day.webp" : "Night.jpg";
    Color bgColor =
        (data["isDayTime"]) ? Colors.blue : Color.fromARGB(255, 41, 55, 135);
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/$background"),
              fit: BoxFit.cover /*will cover the entire screen*/,
            ) /*this will help us allow a background image */,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextButton.icon(
                  onPressed: () async {
                    /*after pressing, we need to push to another route */
                    /*we are going to the location page from here, or we are pushing a router into the stack in this step*/
                    /*in location page, you will choose a location and come back to the home page by returning the data which gets stored in the result variable*/
                    dynamic result = await Navigator.pushNamed(context,
                        '/location'); /*only doing this will make the homescreen sit underneath*/
                    /*we will supply a named route*/
                    setState(() {
                      data = {
                        'location':result["location"],
                        'time':result['time'],
                        'isDayTime':result['isDayTime'],
                        'flag':result['flag'],
                      };
                    });/*the setState will cause the build to rerun again, and then again our data will be overwritten with the data provided in the beginning of the function*/
                  } /*this function will tell where we will navigate once this button is pressed */,
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.grey[300],
                  ),
                  label: Text("Edit Location"),
                ),
                SizedBox(height: 20),
                //little icon of flag and the text widget which will output the location
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      data["location"],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                    //SizedBox(width:20),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  data["time"],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 66,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//safe area brings the text in the area where it is visible
