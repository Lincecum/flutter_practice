import 'package:flutter/cupertino.dart';

class ios_style_screen extends StatefulWidget {
  const ios_style_screen({Key? key}) : super(key: key);

  @override
  State<ios_style_screen> createState() => _ios_style_screenState();
}

class _ios_style_screenState extends State<ios_style_screen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('cupertiono app'),
        ),
        child: Center(
          child: Text('cupertiono app'),
        ),
      ),
    );
  }
}
