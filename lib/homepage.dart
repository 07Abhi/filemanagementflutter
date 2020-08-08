import 'package:flutter/material.dart';
import 'dataclass.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ReadAndWrite randw = ReadAndWrite();
  final textController = TextEditingController();
  String data;
  // Future<Directory> _directoryPath;
  @override
  void initState() {
    super.initState();
    randw.readData().then((value) {
      setState(() {
        data = value;
      });
    });
  }

  Future getData() async {
    setState(() {
      data = textController.text;
      textController.text = '';
    });
    return randw.writeData(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Read/Write'),
        backgroundColor: Colors.pink,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$data?? nothing to show right now'),
          TextFormField(
            controller: textController,
            decoration: InputDecoration(
              labelText: 'Data',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2.0, color: Colors.pink),
              ),
            ),
          ),
          RaisedButton(
            onPressed: () {},
            child: Text('Enter'),
          ),
        ],
      ),
    );
  }
}
