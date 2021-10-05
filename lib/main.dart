import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Color(0xff008AD5), //Colors.blue[600],
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      home: MyHomePage(),
      routes: <String, WidgetBuilder> {
        '/secondpage' : (context) => SecondPage()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;  
  static const List<Widget> _widgetOptions = <Widget>[  
    Text('Home Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),  
    Text('Search Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),  
    Text('Profile Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),  
  ];  
  
  void _onItemTapped(int index) {  
    setState(() {  
      _selectedIndex = index;  
    });  
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
            ),
        title: Text('Profile'),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {
              Navigator.of(context).pushNamed('/secondpage');
            },
            ),
        ],
      ),
      body: Center(  
        child: _widgetOptions.elementAt(_selectedIndex),  
      ),  
      bottomNavigationBar: BottomNavigationBar(  
        items: const <BottomNavigationBarItem>[  
          BottomNavigationBarItem(  
            icon: Icon(Icons.search),  
            title: Text('Search'),  
            backgroundColor: Colors.green  
          ),  
          BottomNavigationBarItem(  
            icon: Icon(Icons.home),  
            title: Text('Home'),  
            backgroundColor: Colors.yellow  
          ),  
          BottomNavigationBarItem(  
            icon: Icon(Icons.person),  
            title: Text('Profile'),  
            backgroundColor: Colors.blue,  
          ),  
        ],  
        currentIndex: _selectedIndex,  
        selectedItemColor: Colors.black,  
        iconSize: 30,  
        onTap: _onItemTapped,
      ),  
    );
  }
}

 class SecondPage extends StatelessWidget {
   @override
   Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal'),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
            ),
        ],
      ),
        body: SfCalendar(
        view: CalendarView.month,
      showNavigationArrow: true,
      selectionDecoration: BoxDecoration(
        color: Colors.transparent,
            border: Border.all(color: Colors.red, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            shape: BoxShape.rectangle,
      ),
      monthViewSettings: MonthViewSettings(showAgenda: true),
      firstDayOfWeek: 1,
      //initialDisplayDate: DateTime(2021, 03, 01, 08, 30),
      //initialSelectedDate: DateTime(2021, 03, 01, 08, 30),
      dataSource: ScheduleDataSource(getAppointments()),
      ),
    );
  }
 }

 
List<Appointment> getAppointments() {
  List<Appointment> meetings = <Appointment>[];
  final DateTime today = DateTime.now();
  final DateTime startTime =
      DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));

  meetings.add(Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: 'Class',
      color: Colors.yellow[900],
      recurrenceRule: 'FREQ=DAILY;COUNT=10',
      isAllDay: false));

  return meetings;
}

class ScheduleDataSource extends CalendarDataSource {
  ScheduleDataSource(List<Appointment> source) {
    appointments = source;
  }
}