import 'package:flutter/material.dart' hide ReorderableListView;
import 'package:reorderables/reorderables.dart';

import './reorderable_list.dart';

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
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: ExpandableList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class ExpandableList extends StatefulWidget {
  @override
  _ExpandableListState createState() => _ExpandableListState();
}

class _ExpandableListState extends State<ExpandableList> {
  void handleDrag(
    Key key,
  ) {}

  final heightList = [200, 100, 100];

  List<Expandable> get expandableList => heightList
      .map(
        (e) => Expandable(
          key: UniqueKey(),
          height: e.toDouble(),
        ),
      )
      .toList();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // heightList
    //     .map(
    //       (e) => Expandable(
    //         key: UniqueKey(),
    //         height: e.toDouble(),
    //       ),
    //     )
    //     .toList();
  }

  @override
  Widget build(BuildContext context) {
    void _onReorder(List list, int oldIndex, int newIndex) {
      final Widget item = list.removeAt(oldIndex);
      list.insert(newIndex, item);
    }

    return Container(
      width: double.infinity,
      child: ReorderableColumn(
        children: expandableList,
        draggingWidgetOpacity: 0.0,
        onReorder: (oldIndex, newIndex) {
          setState(() {
            _onReorder(heightList, oldIndex, newIndex);
          });
        },
        buildDraggableFeedback: (context, constraints, child) => Container(
          child: child,
        ),
      ),
    );
  }
}

class Expandable extends StatelessWidget {
  final double height;
  final Function handleDrag;
  final double scaleValue = 1.0;

  const Expandable({
    Key key,
    this.height,
    this.handleDrag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTapDown: (){(){}}
                    onTap: () {
                      setState(() {
                        scaleValue = 1.5;
                      });
                    },
                    child:Transform.scale(
      scale: scaleValue,
     child: Container(
      margin: EdgeInsets.all(10),
      width: 200,
      child: Column(children: [
        SizedBox(
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: Colors.blue,
            ),
            height: height,
            child: Column(
              children: <Widget>[
                Text("$height"),
              ],
            ),
          ),
        ),
        Container(
          height: 20,
          child: GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                color: Colors.red,
              ),
              alignment: Alignment.center,
            ),
            onVerticalDragUpdate: (details) {
              handleDrag(this.key, details.delta.dy.round());
            },
          ),
        )
      ]),
    );
     ) ) }
}
