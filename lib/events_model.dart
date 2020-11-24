import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Events> fetchEvents() async {
  final response = await http
      .get('https://camp1.dev19.splinestudio.com/api/parents/234/feed');

  if (response.statusCode == 200) {
    return Events.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load events');
  }
}

class Events {
  final List<Section> sections;

  Events({this.sections});

  factory Events.fromJson(Map<String, dynamic> json) {
    return Events(
      sections: json['sections']
          .map<Section>((section) => Section.fromJson(section))
          .toList(),
    );
  }
}

class Section {
  final String title;
  final List<Event> events;

  Section({this.title, this.events});

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      title: json['title'],
      events:
          json['events'].map<Event>((event) => Event.fromJson(event)).toList(),
    );
  }
}

class Event {
  // common fields
  final String id;
  final String icon;
  final String time;
  final String title;
  final Button button;
  final List<Person> children;
  // may be null
  final Person curator;
  final String duration;
  final List<String> media;
  final NextEvent nextEvent;
  final EventStatus status;
  final String subtitle;

  Event({
    this.id,
    this.icon,
    this.time,
    this.title,
    this.button,
    this.children,
    this.curator,
    this.duration,
    this.media,
    this.nextEvent,
    this.status,
    this.subtitle,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    List<String> media;
    if (json['media'] != null && !json['media'].isEmpty) {
      media = json['media']
          .map<String>((id) =>
              'https://camp1.dev19.splinestudio.com/api/media/$id/thumb')
          .toList();
    }

    return Event(
      id: json['id'],
      icon: json['icon'],
      time: json['time'],
      title: json['title'],
      button: Button.fromJson(json['button']),
      children: json['children']
          .map<Person>((person) => Person.fromJson(person))
          .toList(),
      curator:
          json['curator'] != null ? Person.fromJson(json['curator']) : null,
      duration: json['duration'] != null ? json['duration'] : null,
      media: media != null ? media : null,
      nextEvent: json['next_event'] != null
          ? NextEvent.fromJson(json['next_event'])
          : null,
      status:
          json['status'] != null ? EventStatus.fromJson(json['status']) : null,
      // typo in api
      subtitle: json['subtiutle'] != null ? json['subtiutle'] : null,
    );
  }
}

class Button {
  final String page;
  final String title;

  Button({this.page, this.title});

  factory Button.fromJson(Map<String, dynamic> json) {
    return Button(
      page: json['page'],
      title: json['title'],
    );
  }
}

class Person {
  final String id;
  final String name;
  final String status;
  final String avatar;

  Person({this.id, this.name, this.status, this.avatar});

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
        id: json['id'],
        name: json['name'],
        status: json['status'] != null ? json['status'] : null,
        avatar:
            'https://camp1.dev19.splinestudio.com/api/children/${json['id']}/avatar/small');
  }
}

class EventStatus {
  final int step;
  final String title;

  EventStatus({this.step, this.title});

  factory EventStatus.fromJson(Map<String, dynamic> json) {
    return EventStatus(
      step: json['step'],
      title: json['title'],
    );
  }
}

class NextEvent {
  final String id;
  final String duration;
  final String title;

  NextEvent({this.id, this.duration, this.title});

  factory NextEvent.fromJson(Map<String, dynamic> json) {
    return NextEvent(
      id: json['id'],
      duration: json['duration'],
      title: json['title'],
    );
  }
}
