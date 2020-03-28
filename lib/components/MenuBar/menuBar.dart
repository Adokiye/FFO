import 'package:flutter/material.dart';
import 'styles.dart';
class MenuBar extends StatefulWidget {
    final Function() recipe;
  final Function() ingredients;
  MenuBar({
    @required this.recipe,
    @required this.ingredients,
  });
  @override
  _MenuBarState createState() {
    return _MenuBarState();
  }
}

class _MenuBarState extends State<MenuBar> {
  bool ingredientsItem = false;
  _setItem(value) {
  if(value){
  widget.ingredients();
  }else{
   widget.recipe();
  }
  setState(() {
    ingredientsItem = value;
  });
}
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 51.0,
      decoration: parentDecorationStyle,
      child: Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Material(
              child: InkWell(onTap: _setItem(true),
              child: Container(
              width: MediaQuery.of(context).size.width*0.38,
              decoration: ingredientsItem?pressedDecorationStyle:unpressedDecorationStyle,
              child: Center(child: Text('Ingredients', style: ingredientsItem?pressedTextStyle:unpressedTextStyle)),)
            )
            ),
                         Spacer(),
            Material(
              child: InkWell(onTap: _setItem(false),
              child: Container(
              width: MediaQuery.of(context).size.width*0.38,
              decoration: !ingredientsItem?pressedDecorationStyle:unpressedDecorationStyle,
              child: Center(child: Text('Recipe', style: !ingredientsItem?pressedTextStyle:unpressedTextStyle)),)
            )
            ),
                                     Spacer(),
          ],
        ),
      ),
    );
  }
}
