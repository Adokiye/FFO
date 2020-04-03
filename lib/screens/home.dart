import 'package:flutter/material.dart';

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

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(80.0), // here the desired height
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: AppBar(
                automaticallyImplyLeading: false,
                title: AppBarComponent(),
                elevation: 25.0,
                backgroundColor: const Color(0xff00ADEF),
                centerTitle: true,
              ),
            )),
        body: Container(
          color: Colors.white,
          child: SafeArea(
              child: SingleChildScrollView(
            child: Center(
              child: Container(
            //    height: MediaQuery.of(context).size.height,
                child: Column(
            //    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                                       margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.009),
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/schedule');
                          },
                          child: Container(
                              child: new Image.asset(
                            'assets/images/laundryIcon.png',
                            height: MediaQuery.of(context).size.height * (0.10),
                            width: MediaQuery.of(context).size.width * (0.50),
                            fit: BoxFit.contain,
                          )),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/homecleaning');
                          },
                          child: Container(
                            width: 140,
                            child: new Image.asset(
                              'assets/images/houseCleaningIcon.png',
                              height:
                                  MediaQuery.of(context).size.height * (0.10),
                              width: MediaQuery.of(context).size.width * (0.40),
                              fit: BoxFit.contain,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                   margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.009),
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/enterfooddetails');
                              },
                              child: new Image.asset(
                                'assets/images/foodDeliveryIcon.png',
                                height:
                                    MediaQuery.of(context).size.height * (0.10),
                                width:
                                    MediaQuery.of(context).size.width * (0.40),
                                fit: BoxFit.contain,
                              )),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/homeSalon');
                            },
                            child: Container(
                              width: 140,
                              child: new Image.asset(
                                'assets/images/homeSalonIcon.png',
                                height:
                                    MediaQuery.of(context).size.height * (0.10),
                                width:
                                    MediaQuery.of(context).size.width * (0.40),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ],
                      )),
                  Container(
                     margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.009),
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/scheduledispatch');
                            },
                            child: new Image.asset(
                              'assets/images/dispatchServicesIcon.png',
                              height:
                                  MediaQuery.of(context).size.height * (0.10),
                              width: MediaQuery.of(context).size.width * (0.45),
                              fit: BoxFit.contain,
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/postconstruction');
                              },
                              child: Container(
                                width: 140,
                                child: new Image.asset(
                                  'assets/images/postConstructionIcon.png',
                                  height: MediaQuery.of(context).size.height *
                                      (0.10),
                                  width: MediaQuery.of(context).size.width *
                                      (0.40),
                                  fit: BoxFit.contain,
                                ),
                              )),
                        ],
                      )),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.95,
                               margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.02),
                              child:                             Text('Top Deals',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    )),
                            ),

                          
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9.0),
                        image: DecorationImage(
                          image: AssetImage('assets/images/topDeals.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.02),
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: 89.0,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TypewriterAnimatedTextKit(
                                onTap: () {
                                  print("15% off Fill it bag");
                                },
                                totalRepeatCount: 100,
                                text: [
                                  "   15% off Fill it bag",
                                  "   Get it today!",
                                ],
                                displayFullTextOnTap: true,
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 4.0,
                                      color: Color.fromRGBO(0, 0, 0, 0.25),
                                      offset: Offset(0, 4.0),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.start,
                                alignment: AlignmentDirectional
                                    .topStart // or Alignment.topLeft
                                )
                          ])),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9.0),
                        image: DecorationImage(
                          image: AssetImage('assets/images/topDeals.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: 89.0,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TypewriterAnimatedTextKit(
                                onTap: () {
                                  print("15% off Fill it bag");
                                },
                                totalRepeatCount: 100,
                                text: [
                                  "   15% off Fill it bag",
                                  "   Get it today!",
                                ],
                                displayFullTextOnTap: true,
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 4.0,
                                      color: Color.fromRGBO(0, 0, 0, 0.25),
                                      offset: Offset(0, 4.0),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.start,
                                alignment: AlignmentDirectional
                                    .topStart // or Alignment.topLeft
                                )
                          ])),
                                            Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9.0),
                        image: DecorationImage(
                          image: AssetImage('assets/images/topDeals.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: 89.0,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TypewriterAnimatedTextKit(
                                onTap: () {
                                  print("15% off Fill it bag");
                                },
                                totalRepeatCount: 100,
                                text: [
                                  "   15% off Fill it bag",
                                  "   Get it today!",
                                ],
                                displayFullTextOnTap: true,
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 4.0,
                                      color: Color.fromRGBO(0, 0, 0, 0.25),
                                      offset: Offset(0, 4.0),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.start,
                                alignment: AlignmentDirectional
                                    .topStart // or Alignment.topLeft
                                )
                          ])),
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9.0),
                        image: DecorationImage(
                          image: AssetImage('assets/images/topDeals.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: 89.0,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TypewriterAnimatedTextKit(
                                onTap: () {
                                  print("15% off Fill it bag");
                                },
                                totalRepeatCount: 100,
                                text: [
                                  "   15% off Fill it bag",
                                  "   Get it today!",
                                ],
                                displayFullTextOnTap: true,
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 4.0,
                                      color: Color.fromRGBO(0, 0, 0, 0.25),
                                      offset: Offset(0, 4.0),
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.start,
                                alignment: AlignmentDirectional
                                    .topStart // or Alignment.topLeft
                                )
                            //  Text('   15% off Fill it bag',
                            //     style: TextStyle(
                            //       color: Colors.white,
                            //       fontSize: 20,
                            //     ))
                          ]))
                ],
              ),
            ),
           ) )),
        ));

    // Here we take the value from the MyHomePage object that was created by
    // the App.build method, and use it to set our appbar title.
  }
}
