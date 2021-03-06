import 'package:demo_app/model/event_data_source.dart';
import 'package:demo_app/provider/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Tasks extends StatefulWidget {
  final CalendarController _controller;

  const Tasks(this._controller, {Key? key}) : super(key: key);

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EventProvider>(context);
    final selectedEvents = provider.eventsOfSelectedDate;

    // If no events currently, shows text 'No Events found!'
    if (selectedEvents.isEmpty) {
      return const Center(
        child: Text(
          'No Events found!',
          style: TextStyle(color: Colors.black),
        ),
      );
    }

    return SfCalendar(
      controller: widget._controller,
      view: CalendarView.timelineDay,
      // Shows all events on selected date by default
      dataSource: EventDataSource(provider.eventsOfSelectedDate),
      initialDisplayDate: provider.selectedDate,
      appointmentBuilder: appointmentBuilder,
      headerHeight: 0,
      todayHighlightColor: Colors.black,
      selectionDecoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      onTap: (details) {
        if (details.appointments == null) return;
      },
    );
  }

  Widget appointmentBuilder(
    BuildContext context,
    CalendarAppointmentDetails details,
  ) {
    final event = details.appointments.first;

    return Container(
      width: details.bounds.width,
      height: details.bounds.height,
      decoration: BoxDecoration(
        color: Color(event.backgroundColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        event.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
