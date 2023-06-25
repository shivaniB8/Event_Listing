import 'dart:ffi';

import 'package:all_events_task/data/responses/venue_response.dart';

class EventDetailsResponse {
  String? eventId;
  String? eventName;
  String? eventNameRaw;
  String? ownerId;
  String? thumbUrl;
  String? thumbUrlLarge;
  int? startTime;
  String? startTimeDisplay;
  int? endTime;
  String? endTimeDisplay;
  String? location;
  Venue? venue;
  String? label;
  int? featured;
  String? eventUrl;
  String? shareUrl;
  String? bannerUrl;
  List<dynamic>? categories;
  List<dynamic>? tags;
  Tickets? tickets;
  List<dynamic>? customParams;

  EventDetailsResponse({
      this.eventId,
      this.eventName,
      this.eventNameRaw,
      this.ownerId,
      this.thumbUrl,
      this.thumbUrlLarge,
      this.startTime,
      this.startTimeDisplay,
      this.endTime,
      this.endTimeDisplay,
      this.location,
      this.venue,
      this.label,
      this.featured,
      this.eventUrl,
      this.shareUrl,
      this.bannerUrl,
      this.categories,
      this.tags,
      this.tickets,
      this.customParams,
  });

  EventDetailsResponse.fromJson(Map<String, dynamic> json)
      : eventId = json['event_id'],
        eventName = json['eventname'],
        eventNameRaw = json['eventname_raw'],
        ownerId = json['owner_id'],
        thumbUrl = json['thumb_url'],
        thumbUrlLarge = json['thumb_url_large'],
        startTime = json['start_time'],
        startTimeDisplay = json['start_time_display'],
        endTime = json['end_time'],
        endTimeDisplay = json['end_time_display'],
        location = json['location'],
        venue = Venue.fromJson(json['venue']),
        label = json['label'],
        featured = json['featured'],
        eventUrl = json['event_url'],
        shareUrl = json['share_url'],
        bannerUrl = json['banner_url'],
        categories = json['categories'],
        tags = json['tags'],
        tickets = Tickets.fromJson(json['tickets']),
        customParams = json['custom_params'];
}

