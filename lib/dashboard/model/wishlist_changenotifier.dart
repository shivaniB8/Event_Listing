import 'package:all_events_task/data/responses/event_details_response.dart';
import 'package:flutter/foundation.dart';

class FavoritePageModel extends ChangeNotifier {
  /// The private field backing [favoritelist].
  late EventDetailsResponse _favoritelist;

  /// Internal, private state of the favorite page. Stores the ids of each item.
  final List<String> _itemIds = [];

  /// The current favorite list. Used to construct items from numeric ids.
  EventDetailsResponse get favoritelist => _favoritelist;



  set favoritelist(EventDetailsResponse newList) {
    _favoritelist = newList;
    // Notify listeners, in case the new favorite list provides information
    // different from the previous one. For example, availability of an item
    // might have changed.
    notifyListeners();
  }



  /// Adds [item] to favorite page. This is the only way to modify the favorite page from outside.
  void add(EventDetailsResponse item) {
    _itemIds.add(item.eventId??'');
    // This line tells [Model] that it should rebuild the widgets that
    // depend on it.
    notifyListeners();
  }

  void remove(EventDetailsResponse item) {
    _itemIds.remove(item.eventId??'');
    // Don't forget to tell dependent widgets to rebuild _every time_
    // you change the model.
    notifyListeners();
  }
}
