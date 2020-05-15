import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swiftbee/Baskets%20and%20Checkouts/Checkout%20Menu.dart';
import 'package:swiftbee/Items/Add%20Item%20Screen.dart';
import 'package:swiftbee/Providers/Data.dart';
import 'package:swiftbee/Constants/Constants.dart';


class BasketMenu extends StatefulWidget {

  final int listIndex;
  final String itemName;
  final double price;
  final GridTile gridOutline;
  final int numberOfItems;

  const BasketMenu({Key key, this.listIndex, this.itemName, this.price, this.gridOutline, this.numberOfItems})
      : super(key: key);
  @override
  _BasketMenuState createState() => _BasketMenuState();
}

class _BasketMenuState extends State<BasketMenu> {
  Widget childWidget = Container();
  @override
  Widget build(BuildContext context) {

    if (Provider.of<Data>(context).cartItemsList.length > 0){
      setState(() {
        childWidget = Column(

          children: <Widget>[
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Order', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                  ),
                  Text('Edit Basket', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25.0,
            ),

            Expanded(
              child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 30.0, child: divider);
                  },
                  reverse: false,
                  itemCount: Provider.of<Data>(context).cartItemsList.length,
                  itemBuilder: (context, index) {

                    String namePath = Provider.of<Data>(context).cartItemsList[index]['name'];
                    double pricePath = Provider.of<Data>(context).cartItemsList[index]['price'];
                    GridTile imgPath = Provider.of<Data>(context).cartItemsList[index]['gridTile'];
                    int quantityPath = Provider.of<Data>(context).cartItemsList[index]['quantity'];


                    return FlatButton(
                      onPressed: (){

                        showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {

                              return AddItemScreen(
                                listIndex: index,
                                itemName: namePath,
                                price: pricePath,
                                gridOutline: imgPath,
                                numberOfItems: quantityPath,
                              );

                            }
                        );

                      },

                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Container(
                                child: GridTile(child: imgPath,)
                            ),
                          ),
                          SizedBox(
                            width: 40.0,
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              child: Text('${Provider.of<Data>(context).cartItemsList[index]['name']}',
                                style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w500),),
                            ),
                          ),
                          SizedBox(
                            width: 40.0,
                          ),
                          Expanded(
                            flex: 0,
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text('x$quantityPath',
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.blue[800]),),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: Text('£$pricePath', style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.w500),),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),

            SizedBox(height: 30.0,),

            Padding(
              padding: const EdgeInsets.only(bottom: 10.0, left: 20.0, right: 20.0,),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('TOTAL', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                  Text('£', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500, color: Colors.grey),
                  ),
                ],
              ),
            ),

          ],
        );

      });
      } else {
      setState(() {
        childWidget = Center(child: Text('no items in basket', style: TextStyle(color: Colors.black),));

      });
    }




    return Scaffold(
      appBar: AppBar(

        brightness: Brightness.light,

        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
            },
        ),

        backgroundColor: Colors.white,
        title: Text('Basket', style: TextStyle(fontWeight: FontWeight.bold),),
        elevation: 1.0,
        centerTitle: true,
        textTheme: TextTheme(title: TextStyle(color: Colors.black, fontSize: 20.0),),

      ),

      body: SafeArea(

        child: childWidget

      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 20.0, top: 10.0),
        child: ButtonTheme(
          height: 50.0,
          child: FlatButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){return CheckoutMenu();}));
            },
            child: Text('Checkout',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Valera',
              ),
            ),
            color: Colors.blue[800],
          ),
        ),
      ),

    );
  }
}