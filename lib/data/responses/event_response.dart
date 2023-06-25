class Event {
  String? category;
  String? data;
  Event({
    this.category,
    this.data,
  });

  Event.fromJson(Map<String, dynamic> json)
      : category = json['category'],
        data = json['data'];
}

