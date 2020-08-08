import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dataclass.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ReadAndWrite randw = ReadAndWrite();
  final textController = TextEditingController();
  String data;
  Future<Directory> _directoryPath;
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

  Future _getDirectoryPath() {
    setState(() {
      _directoryPath = getApplicationDocumentsDirectory();
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Read/Write'),
        backgroundColor: Colors.pink,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(data ?? 'nothing to show right now'),
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
            onPressed: () {
              getData();
              SystemChannels.textInput.invokeMethod('TextInput.hide');
            },
            child: Text('Enter'),
          ),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            onPressed: () => _getDirectoryPath(),
            child: Text('Get Directory Path'),
          ),
          FutureBuilder(
            future: _directoryPath,
            builder: (context, snapshot) {
              var text = Text('');
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  text = Text('Error:- ${snapshot.error}');
                } else if (snapshot.hasData) {
                  text = Text('Path:- ${snapshot.data}');
                } else {
                  text = Text('');
                }
              }
              return Container(
                child: text,
              );
            },
          ),
        ],
      ),
    );
  }
}
