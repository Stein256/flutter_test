import 'package:flutter/material.dart';

import './event_card.dart';
import './events_model.dart';

class EventList extends StatefulWidget {
  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  Future<Events> futureEvents;

  @override
  void initState() {
    super.initState();
    futureEvents = fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Events>(
      future: futureEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _buildEventList(snapshot.data);
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return CircularProgressIndicator();
      },
    );
  }

  Widget _buildEventList(Events events) {
    var children = List<Widget>();
    events.sections.forEach((section) {
      children.add(_buildSectionTitle(section.title));
      children.addAll(
          section.events.map((event) => EventCard(event: event)).toList());
    });
    return ListView(children: children);
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      margin: const EdgeInsets.only(top: 6.0, left: 4.0),
      child: Text(title,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14,
          )),
    );
  }
}
