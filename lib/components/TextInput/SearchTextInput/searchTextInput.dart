import 'package:flutter/material.dart';
import 'styles.dart';
class SearchTextInput extends StatefulWidget { 
  TextEditingController textController;
  SearchTextInput({@required textController});
  @override
  SearchTextInputState createState() {
   return new SearchTextInputState();
  }
}
class SearchTextInputState extends State<SearchTextInput> { 
  @override
  Widget build(BuildContext context) {
    return new Material(
        elevation: 3.0,
        shadowColor: Color.fromRGBO(0, 0, 0, 0.14),
        child: Container(
          width:  MediaQuery.of(context).size.width * 0.85,
          height: 51.0,
          child: TextField(
            controller: widget.textController,
            style: enteredTextStyle1,
          decoration: inputDecoration1,
          keyboardType: TextInputType.text,
        )));
  }
}
