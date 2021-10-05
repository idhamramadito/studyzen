import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

 class JadwalPage extends StatelessWidget {
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
            border: Border.all(color: Colors.blueGrey, width: 2),
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
      subject: 'Jaringan Telekomunikasi',
      color: Colors.blue[700],
      recurrenceRule: 'FREQ=WEEKLY;BYDAY=MO,TH,FR;INTERVAL=1;COUNT=100',
      isAllDay: false));

  return meetings;
}

class ScheduleDataSource extends CalendarDataSource {
  ScheduleDataSource(List<Appointment> source) {
    appointments = source;
  }
}
 