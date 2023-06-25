
import 'dart:ffi';

class Venue {
  String? street;
  String? city;
  String? state;
  String? country;
  num? latitude;
  num? longitude;
  String? fullAddress;

  Venue({
    this.street,
    this.city,
    this.state,
    this.country,
    this.latitude,
    this.longitude,
    this.fullAddress
});

  Venue.fromJson(Map<String, dynamic> json)
      : street = json['street'],
        city = json['city'],
        state = json['state'],
        country = json['country'],
        latitude = json['latitude'] ,
        longitude = json['longitude'] ,
        fullAddress = json['full_address'];
}

class Tickets{
  bool? hasTickets;
  String? ticketUrl;
  String? ticketCurrency;
  int? minTicketPrice;
  int? maxTicketPrice;

  Tickets({
    this.hasTickets,
    this.ticketUrl,
    this.ticketCurrency,
    this.minTicketPrice,
    this.maxTicketPrice,
});

  Tickets.fromJson(Map<String, dynamic> json)
      : hasTickets = json['has_tickets'],
        ticketUrl = json['ticket_url'],
        ticketCurrency = json['ticket_currency'],
        minTicketPrice = json['min_ticket_price'],
        maxTicketPrice = json['maxTicketPrice'];
}