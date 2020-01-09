import 'package:brandz_garage/CategoryItemView.dart';
import 'package:brandz_garage/Constants.dart';
import 'package:brandz_garage/EventDetailScreen.dart';
import 'package:brandz_garage/EventsListItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final categories = Constants.categories;
  final events = Constants.events;

  String dropdownValue = "Paris";

  var _currentIndex = 1;
  var _selectedCategory = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: true,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              color: Colors.transparent,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        underline: Container(),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: <String>['Paris', 'London', 'Mumbai']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
//                        color: Colors.white10,
                      gradient: RadialGradient(
                        colors: <Color>[
                          Color(0xff010101),
                          Color(0xff101010),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.search,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
//                        color: Colors.white10,
                      gradient: RadialGradient(
                        colors: <Color>[
                          Color(0xff010101),
                          Color(0xff101010),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.tune,
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                  child: Column(children: [
                Container(height: 150, child: _categoriesListView),
                Container(
                  margin: EdgeInsets.all(12),
                  child: Text(
                    'Popular Events',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                    height: MediaQuery.of(context).size.width,
                    child: _eventsListView)
              ])),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0x10ffffff),
        currentIndex: _currentIndex,
        elevation: 4,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white30,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet),
              title: Text("Accounts")),
          BottomNavigationBarItem(
              icon: Icon(Icons.event), title: Text("Events")),
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), title: Text("Dashboard")),
        ],
      ),
    );
  }

  get _dropDownItem => Container(
      padding: EdgeInsets.all(10),
      child: Text(
        'Paris',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ));

  get _categoriesListView => ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: categories.length,
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        itemBuilder: (context, index) {
          var b = _selectedCategory == categories[index]['title'];
          print('selected is $_selectedCategory');
          print('this is ${categories[index]['title']} $b');
          return CategoryItemView(
              categories[index], b, () => _onCategoryItemSelected(index));
        },
      );

  _onCategoryItemSelected(int index) {
    setState(() {
      print("here..... $index");
      _selectedCategory = categories[index]['title'];
    });
  }

  get _eventsListView => ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: events.length,
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        itemBuilder: (context, index) {
          return EventsListItem(events[index], ()=>_onEventSelected(index));
        },
      );

  _onEventSelected(int index) {
    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => EventDetailScreen(events[index])));
  }
}
