import 'package:flutter/material.dart';

import './events_model.dart';
import './my_icons.dart';

class EventCard extends StatelessWidget {
  final Event event;
  EventCard({this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ListTile(
                leading: _buildAvatars(event.children),
                trailing: Text(event.time),
              ),
              if (MyIcons.containsKey(event.icon)) MyIcons[event.icon],
              Text(event.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  )),
              if (event.duration != null)
                Text(event.duration,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    )),
              if (event.subtitle != null && event.subtitle != '')
                Text(event.subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    )),
              if (event.media != null)
                Wrap(
                  spacing: 4,
                  alignment: WrapAlignment.center,
                  children: event.media
                      .map((link) => CircleAvatar(
                            backgroundImage: NetworkImage(link),
                          ))
                      .toList(),
                ),
              if (event.nextEvent != null) ...[
                Divider(),
                Text('NEXT EVENT',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: Colors.grey,
                    )),
                Text(event.nextEvent.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    )),
                Text(event.nextEvent.duration,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    )),
              ],
              if (event.button.title != '')
                Card(
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(32, 11, 32, 11),
                    child: Text('${event.button.title} → ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Colors.white,
                        )),
                  ),
                )
            ],
          ),
        ));
  }

  Widget _buildAvatars(List<Person> people) {
    var size = 32.0;
    var avatars = people.asMap().entries.map((e) {
      var index = e.key;
      var person = e.value;
      var offset = index * (0.8 * size);

      return Positioned(
          left: offset,
          width: size,
          height: size,
          child: CircleAvatar(
            backgroundImage: NetworkImage(person.avatar),
          ));
    });

    return SizedBox(
        width: 100,
        height: size,
        child: Stack(
          children: avatars.toList(),
        ));
  }
}
