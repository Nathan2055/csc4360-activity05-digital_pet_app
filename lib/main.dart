import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: DigitalPetApp()));
}

class DigitalPetApp extends StatefulWidget {
  @override
  _DigitalPetAppState createState() => _DigitalPetAppState();
}

class _DigitalPetAppState extends State<DigitalPetApp> {
  //String petName = "Your Pet";
  String petName = '';
  int happinessLevel = 50;
  int hungerLevel = 50;

  // Needed for text field
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  // end needed for text field

  void _playWithPet() {
    setState(() {
      happinessLevel += 10;
      _updateHunger();
    });
  }

  void _feedPet() {
    setState(() {
      hungerLevel -= 10;
      _updateHappiness();
    });
  }

  void _updateHappiness() {
    if (hungerLevel < 30) {
      happinessLevel -= 20;
    } else {
      happinessLevel += 10;
    }
  }

  void _updateHunger() {
    setState(() {
      hungerLevel += 5;
      if (hungerLevel > 100) {
        hungerLevel = 100;
        happinessLevel -= 20;
      }
    });
  }

  // Display colored icon based on inputted happiness value
  Image getMoodIcon(int value) {
    double iconWidth = 200.0; // update icon width globally here

    if (value > 70) {
      return Image.asset('images/dog-icon-green.png', width: iconWidth);
    } else if (value >= 50) {
      return Image.asset('images/dog-icon-yellow.png', width: iconWidth);
    } else if (value >= 1) {
      return Image.asset('images/dog-icon-red.png', width: iconWidth);
    } else {
      return Image.asset('images/dog-icon-black.png', width: iconWidth);
    }
  }

  // Display colored icon based on inputted happiness value
  Text getMoodText(int value) {
    if (value > 70) {
      return Text('Happy', style: TextStyle(fontSize: 15.0));
    } else if (value >= 50) {
      return Text('Neutral', style: TextStyle(fontSize: 15.0));
    } else if (value >= 1) {
      return Text('Unhappy', style: TextStyle(fontSize: 15.0));
    } else {
      return Text('Neutral', style: TextStyle(fontSize: 15.0));
    }
  }

  // Dynamically display query for pet name
  Column getInterface() {
    if (petName == '') {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter a search term',
            ),
            onSubmitted: (String value) async {
              await showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Thanks!'),
                    content: Text(
                      'You typed "$value", which has length ${value.characters.length}.',
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            },
          ),

          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter a search term',
            ),
          ),

          getMoodIcon(happinessLevel),
          SizedBox(height: 16.0),
          getMoodText(happinessLevel),
          SizedBox(height: 16.0),
          Text('Name: $petName', style: TextStyle(fontSize: 20.0)),
          SizedBox(height: 16.0),
          Text(
            'Happiness Level: $happinessLevel',
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(height: 16.0),
          Text('Hunger Level: $hungerLevel', style: TextStyle(fontSize: 20.0)),
          SizedBox(height: 32.0),
          ElevatedButton(
            onPressed: _playWithPet,
            child: Text('Play with Your Pet'),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(onPressed: _feedPet, child: Text('Feed Your Pet')),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          getMoodIcon(happinessLevel),
          SizedBox(height: 16.0),
          getMoodText(happinessLevel),
          SizedBox(height: 16.0),
          Text('Name: $petName', style: TextStyle(fontSize: 20.0)),
          SizedBox(height: 16.0),
          Text(
            'Happiness Level: $happinessLevel',
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(height: 16.0),
          Text('Hunger Level: $hungerLevel', style: TextStyle(fontSize: 20.0)),
          SizedBox(height: 32.0),
          ElevatedButton(
            onPressed: _playWithPet,
            child: Text('Play with Your Pet'),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(onPressed: _feedPet, child: Text('Feed Your Pet')),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Digital Pet')),
      body: Center(child: getInterface()),
    );
  }
}
