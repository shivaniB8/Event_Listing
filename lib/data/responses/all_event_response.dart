import 'package:all_events_task/data/responses/event_details_response.dart';

class AllEvents {
  List<EventDetailsResponse> ? item;
  AllEvents({
    this.item,
  });

  AllEvents.fromJson(Map<String, dynamic> json)
      : item = List.from(json['item']).map((item)=>EventDetailsResponse.fromJson(item)).toList();
}

