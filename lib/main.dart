import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Agility Quick Feet'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum EXERCISE_TYPE {
  FOOTBALL_RUN_SIDE,
  FOOTBALL_RUN_DOWN,
}

class _MyHomePageState extends State<MyHomePage> {
  var INSTRUCTION_SET = ["Up", "Down", "Left", "Right"];
  var EXERCISE_MODES = ['Vertical', 'Sideways', 'INSANE'];
  String _beginInstruction = 'Select Mode From the Dropdown and Tap Button to Proceed';
  String _exerciseMode = 'Vertical';
  int _roundCounter = 0;
  var rng = new Random();

  // Lets consider HEAD as ZERO. (TBH Irrelevant, so ignore)
  final int COIN_HEAD = 0;

  int _getRandomNum(int _range) {
    return rng.nextInt(_range);
  }

  int _getRandomNumRange(int _min, int _max) {
    return rng.nextInt(_max - _min) + _min;
  }

  String _getExerciseInstruction(int _count) {
    switch (_exerciseMode) {
      case 'INSANE':
        int _coinFlip = _getRandomNum(2);
        if (_coinFlip == COIN_HEAD) {
          return _getInstructionVertical(_count);
        } else {
          return _getInstructionSideways(_count);
        }
        break;
      case 'Sideways':
        return _getInstructionSideways(_count);
      case 'Vertical':
        return _getInstructionVertical(_count);
    }
  }

  /*
  caller should ensure that count should never be zero
   */
  String _getInstructionVertical(int _count) {
    if (_count > 0) {
      return 'Jump Up $_count times';
    } else if (_count < 0) {
      return 'Jump Down ${_count.abs()} times';
    } else {
      throw new ArgumentError('There cannot be ZERO moves in an exercise');
    }
  }

  /*
    caller should ensure that count should never be zero
   */
  String _getInstructionSideways(int _count) {
    if (_count > 0) {
      return 'Turn Right $_count times';
    } else if (_count < 0) {
      return 'Turn Left ${_count.abs()} times';
    } else {
      throw new ArgumentError('There cannot be ZERO moves in an exercise');
    }
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _roundCounter = _getRandomNumRange(-10, 10);
      //Our +ve category is [0,9], So increment everything by 1
      _roundCounter = _roundCounter < 0 ? _roundCounter : _roundCounter + 1;
      _beginInstruction = _getExerciseInstruction(_roundCounter);
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: _exerciseMode,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 32,
              elevation: 16,
              style: TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
              onChanged: (String newValue) {
                setState(() {
                  _exerciseMode = newValue;
                });
              },
              items:
                  EXERCISE_MODES.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text(
              '$_beginInstruction',
            ),
            SizedBox(height: 20),
            Text(
              '${_roundCounter.abs()}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.directions_run),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
