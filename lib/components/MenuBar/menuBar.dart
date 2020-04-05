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
      margin: EdgeInsets.only(top: 21.0),
      decoration: parentDecorationStyle,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Material(
              borderRadius: BorderRadius.circular(5.0),
              color: ingredientsItem?const Color(0xffE64C3C):const Color(0xfffafafb),
              child: InkWell(onTap: (){_setItem(true);},
              child: Container(
                height: 40.0,
              width: MediaQuery.of(context).size.width*0.38,
              decoration: ingredientsItem?pressedDecorationStyle:unpressedDecorationStyle,
              child: Center(child: Text('Ingredients', style: ingredientsItem?pressedTextStyle:unpressedTextStyle)),)
            )
            ),
                         Spacer(),
            Material(
              borderRadius: BorderRadius.circular(5.0),
              color: !ingredientsItem?const Color(0xffE64C3C):const Color(0xfffafafb),
              child: InkWell(onTap: (){_setItem(false);},
              child: Container(
                height: 40.0,
              width: MediaQuery.of(context).size.width*0.38,
              decoration: !ingredientsItem?pressedDecorationStyle:unpressedDecorationStyle,
              child: Center(child: Text('Recipe', style: !ingredientsItem?pressedTextStyle:unpressedTextStyle)),)
            )
            ),
                                     Spacer(),
          ],
        ),
      
    );
  }
}
