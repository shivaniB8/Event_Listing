import 'dart:convert';
import 'package:all_events_task/data/responses/all_event_response.dart';
import 'package:all_events_task/data/responses/event_response.dart';
import 'package:http/http.dart' as http;

Future<List<Event>> getEvents() async {
  const url='https://allevents.s3.amazonaws.com/tests/categories.json';
  final uri= Uri.parse(url);
  final response = await http.get(uri);
  final body = response.body;
  final json = jsonDecode(body);
return json.map<Event>((user) => Event.fromJson(user)).toList();
}

Future<AllEvents> getAllEvents(int index)async{
  List<Event> eventList = await getEvents();
  print(eventList[index].category);
  final uri= Uri.parse(eventList[index].data??'https://allevents.s3.amazonaws.com/tests/all.json');
  final response = await http.get(uri);
  final body = response.body;
  final json = Map<String, dynamic>.from(jsonDecode(body));
  return AllEvents.fromJson(json);
}