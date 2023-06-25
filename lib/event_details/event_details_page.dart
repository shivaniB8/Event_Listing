import 'dart:ui';

import 'package:all_events_task/common/style.dart';
import 'package:all_events_task/data/responses/event_details_response.dart';
import 'package:all_events_task/event_details/image_carousel.dart';
import 'package:all_events_task/event_details/reviews_list.dart';
import 'package:all_events_task/event_details/suggestions_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailsPage extends StatelessWidget {
  final EventDetailsResponse event;
  const EventDetailsPage({
    Key? key,
    required this.event,
  }) : super(key: key);

  Future<void> _sharePath(String path) async {
    await Share.share(path);
  }

  Future<void> openMap(
    double latitude,
    double longitude, {
    String? label,
  }) async {
    String googleUrl = 'http://maps.google.com/maps?q=$latitude,$longitude';
    if (label?.isNotEmpty == false) {
      // Removing & symbol from label as it is conflicting with & used to separate query elements in URL
      final encodedLabel = Uri.encodeFull(label!.replaceAll('&', ''));
      googleUrl += '($encodedLabel)';
    }
    await launch(googleUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          event.eventName ?? '',
          style: text_style_title6,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
          color: Colors.blue,
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (event.shareUrl?.isNotEmpty ?? false) {
                _sharePath(event.shareUrl ?? '');
              }
            },
            icon: const Icon(
              Icons.ios_share_outlined,
              color: Colors.blue,
            ),
            padding: const EdgeInsets.all(0),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  event.bannerUrl ?? '',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: 300,
                              child: Text(
                                event.eventName ?? '',
                                style: text_style_title7,
                              )),
                          const Icon(
                            Icons.star_border,
                            color: Colors.blue,
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            for (int i = 0; i < 3; i++)
                              Align(
                                widthFactor: 0.5,
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                      radius: 13,
                                      backgroundImage: Image.network(
                                              'https://cdn2.allevents.in/thumbs/thumb5b903cb6755e8.png')
                                          .image),
                                ),
                              ),
                            const SizedBox(
                              width: 15,
                            ),
                            const Text(
                              '+ 20 Going',
                              style: text_style_title10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.9),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset:
                            const Offset(0, 6), // changes position of shadow
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.calendar_today,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Date & Time ',
                            style: text_style_title6,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        event.startTimeDisplay ?? '',
                        style: text_style_title8,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Venue',
                            style: text_style_title6,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        event.venue?.fullAddress ?? '',
                        maxLines: 4,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          Text(
                            'View Map',
                            style: text_style_title6,
                          ),
                          Icon(
                            Icons.arrow_drop_up,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                      ShaderMask(
                        shaderCallback: (rect) {
                          return const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.black, Colors.transparent],
                          ).createShader(
                              Rect.fromLTRB(0, 0, rect.width, rect.height));
                        },
                        blendMode: BlendMode.dstIn,
                        child: Container(
                          height: 170,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: Image.network(
                                      'https://static1.anpoimages.com/wordpress/wp-content/uploads/2022/07/googleMapsTricksHero.jpg')
                                  .image,
                              fit: BoxFit.fitWidth,
                            ),
                            shape: BoxShape.rectangle,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 500,
                        height: 50,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0))),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Book Now',
                            style: text_style_title14,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'This is perfect for a DJ with neon vibe. \n Nightlife and the party scene, making them a great for a DJ.\n The use of bright colors and design that stands out and captures attention.',
                        style: text_style_para2,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.photo,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Event Photos',
                            style: text_style_title6,
                          ),
                        ],
                      ),
                      const ImageCarousel(
                        imageList: [
                          'https://images.pexels.com/photos/1546168/pexels-photo-1546168.jpeg',
                          'https://images.pexels.com/photos/7658380/pexels-photo-7658380.jpeg',
                          "https://media.istockphoto.com/id/495923096/photo/various-spices-on-grunge-background.jpg?s=1024x1024&w=is&k=20&c=CMjUyhSNYITEgIvaNR2cSvtfdZ2oocFVw_MNMZIGC3w=",
                          'https://images.pexels.com/photos/5439381/pexels-photo-5439381.jpeg',
                        ],
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.add_box_outlined,
                            color: Colors.grey,
                          ),
                          Text(
                            'Host Reviews By Attendees',
                            style: text_style_title6,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: Image.network(
                              'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fHww&w=1000&q=80',
                              height: 80,
                              width: 80,
                            ).image,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'SBR Youniverse ',
                                style: text_style_para2,
                              ),
                              RatingBarIndicator(
                                rating: 4.5,
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                itemCount: 5,
                                itemSize: 20.0,
                                direction: Axis.horizontal,
                              ),
                              const Text('2 Reviews', style: text_style_para2),
                            ],
                          ),
                          const Spacer(),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.blue),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(50.0))),
                            ),
                            onPressed: () {},
                            child: Text(
                              'Follow',
                              style: text_style_title14.copyWith(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      const ReviewsList(),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Suggestions For You',
                        style: text_style_title6,
                      ),
                      const UpdatesListingDashBoard(),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
