import 'package:all_events_task/common/colors.dart';
import 'package:all_events_task/common/style.dart';
import 'package:all_events_task/dashboard/model/wishlist_changenotifier.dart';
import 'package:all_events_task/data/api_services/dashboard_listing_api.dart';
import 'package:all_events_task/data/responses/event_details_response.dart';
import 'package:all_events_task/event_details/event_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';

import '../data/responses/all_event_response.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late AllEvents? eventList = AllEvents();
  late bool _isLoading;
  late ScrollController _eventListScrollController;

  Future<void> _sharePath(String path) async {
    await Share.share(path);
  }

  @override
  void initState() {
    _isLoading = true;
    super.initState();
    _getAllEvent();
    _eventListScrollController = ScrollController();
  }

  @override
  void dispose() {
    _eventListScrollController.dispose();
    super.dispose();
  }

  void _getAllEvent() async {
    eventList = await getAllEvents();

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<EventDetailsResponse>? items = eventList?.item;
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu,color: Colors.black,),
        title: const Padding(
          padding: EdgeInsets.symmetric( vertical: 10),
          child: Text(
            'Events',
            style: text_style_title3,
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const FilterWidget(),
          Expanded(
            child: Container(
                child: !_isLoading && (items?.isNotEmpty ?? false)
                    ? ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(top: 20),
                        controller: _eventListScrollController,
                        itemCount: items!.length + 1,
                        itemBuilder: (context, index) {
                          if (index < items.length) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, right: 12, top: 5, bottom: 5),
                              child: GestureDetector(
                                child: Container(
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      color: Colors.white,
                                    ),
                                    height: 132,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: Image.network(
                                                        items[index].thumbUrl ??
                                                            '')
                                                    .image,
                                                fit: BoxFit.fitHeight,
                                              ),
                                              shape: BoxShape.rectangle,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(20)),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 6,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0, left: 10, right: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  items[index].eventName ?? '',
                                                  style: text_style_title3,
                                                  softWrap: true,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  items[index]
                                                          .startTimeDisplay ??
                                                      '',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: text_style_title8,
                                                ),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  '${items[index].location}, ${items[index].venue?.city}',
                                                  style: text_style_title8,
                                                  softWrap: true,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        if (items[index]
                                                                .shareUrl
                                                                ?.isNotEmpty ??
                                                            false) {
                                                          _sharePath(items[
                                                                      index]
                                                                  .shareUrl ??
                                                              '');
                                                        }
                                                      },
                                                      icon: const Icon(
                                                        Icons
                                                            .ios_share_outlined,
                                                        color: Colors.blue,
                                                      ),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
                                                    ),
                                                    _AddButton(
                                                      item: items[index],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => EventDetailsPage(
                                        event: items[index],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                          return Container();
                        },
                      )
                    : const Center(
                        child: Text('Loading'),
                      )),
          ),
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final EventDetailsResponse item;

  const _AddButton({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.star_border, color: Colors.blue),
      onPressed: () {
              var favoritepage = context.read<FavoritePageModel>();
              favoritepage.remove(item);
            }

    );
  }
}

class FilterWidget extends StatefulWidget {
  const FilterWidget({Key? key}) : super(key: key);

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 20.0, left: 20, right: 20, bottom: 10),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: const Color(0xFFffffff),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(1),
              blurRadius: 2.0, // soften the shadow
              spreadRadius: 2.0, //extend the shadow
              offset: const Offset(
                2.0, // Move to right 5  horizontally
                2.0, // Move to bottom 5 Vertically
              ),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
                child: Row(
                  children: const [
                    Icon(
                      Icons.category_outlined,
                      color: Colors.blue,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      'Categories',
                      style: text_style_title5,
                    )
                  ],
                ),
                onTap: () async {
                  await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      enableDrag: false,
                      isDismissible: false,
                      backgroundColor: Colors.transparent,
                      builder: (_) {
                        return Container(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: const FiltersBottomSheet(),
                        );
                      });
                }),
            GestureDetector(
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Date Time',
                    style: text_style_title5.copyWith(color: Colors.grey),
                  )
                ],
              ),
            ),
            GestureDetector(
              child: Row(
                children: [
                  const Icon(
                    Icons.unfold_more_outlined,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Sort',
                    style: text_style_title5.copyWith(color: Colors.grey),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FiltersBottomSheet extends StatelessWidget {
  const FiltersBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          // Header
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              const Text(
                'Categories',
                style: text_style_title3,
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),

          // Divider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              height: 1,
              thickness: 1.4,
              color: gray_color.withOpacity(0.2),
            ),
          ),

          // White space
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Entertainment',
                  style: text_style_title6,
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Chip(
                      labelPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                      label: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
                        child: Text(
                          'Music',
                          style: text_style_title13
                        ),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 4.0,
                      shadowColor: Colors.grey[60],
                      padding: const EdgeInsets.all(8.0),
                    ),
                    const SizedBox(width: 10,),
                    Chip(
                      labelPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                      label: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
                        child: Text(
                          'Concerts',
                          style:text_style_title13
                        ),
                      ),
                      backgroundColor: Colors.blue,
                      elevation: 4.0,
                      shadowColor: Colors.grey[60],
                      padding: const EdgeInsets.all(8.0),
                    ),
                    const SizedBox(width: 10,),
                    Chip(
                      labelPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                      label: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
                        child: Text(
                          'Parties & Nightlife',
                          style: text_style_title13,
                        ),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 4.0,
                      shadowColor: Colors.grey[60],
                      padding: const EdgeInsets.all(8.0),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Chip(
                      labelPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                      label: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
                        child: Text(
                            'Performances',
                            style: text_style_title13
                        ),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 4.0,
                      shadowColor: Colors.grey[60],
                      padding: const EdgeInsets.all(8.0),
                    ),
                    const SizedBox(width: 10,),
                    Chip(
                      labelPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                      label: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
                        child: Text(
                            'Comedy',
                            style:text_style_title13
                        ),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 4.0,
                      shadowColor: Colors.grey[60],
                      padding: const EdgeInsets.all(8.0),
                    ),
                    const SizedBox(width: 10,),
                    Chip(
                      labelPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                      label: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
                        child: Text(
                          'Dance',
                          style: text_style_title13,
                        ),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 4.0,
                      shadowColor: Colors.grey[60],
                      padding: const EdgeInsets.all(8.0),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                const SizedBox(height: 10,),
                const Text(
                  'Arts And Theater',
                  style: text_style_title6,
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Chip(
                      labelPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                      label: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
                        child: Text(
                            'Fine Arts',
                            style: text_style_title13
                        ),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 4.0,
                      shadowColor: Colors.grey[60],
                      padding: const EdgeInsets.all(8.0),
                    ),
                    const SizedBox(width: 10,),
                    Chip(
                      labelPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                      label: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
                        child: Text(
                            'Theatre',
                            style:text_style_title13
                        ),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 4.0,
                      shadowColor: Colors.grey[60],
                      padding: const EdgeInsets.all(8.0),
                    ),
                    const SizedBox(width: 10,),
                    Chip(
                      labelPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                      label: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
                        child: Text(
                          'Literary Art',
                          style: text_style_title13,
                        ),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 4.0,
                      shadowColor: Colors.grey[60],
                      padding: const EdgeInsets.all(8.0),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Chip(
                      labelPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                      label: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
                        child: Text(
                            'Cooking',
                            style: text_style_title13
                        ),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 4.0,
                      shadowColor: Colors.grey[60],
                      padding: const EdgeInsets.all(8.0),
                    ),
                    const SizedBox(width: 10,),
                    Chip(
                      labelPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                      label: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
                        child: Text(
                            'Photography',
                            style:text_style_title13
                        ),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 4.0,
                      shadowColor: Colors.grey[60],
                      padding: const EdgeInsets.all(8.0),
                    ),
                    const SizedBox(width: 10,),
                    Chip(
                      labelPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                      label: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
                        child: Text(
                          'Craft',
                          style: text_style_title13,
                        ),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 4.0,
                      shadowColor: Colors.grey[60],
                      padding: const EdgeInsets.all(8.0),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                const SizedBox(height: 10,),
                const Text(
                  'More',
                  style: text_style_title6,
                ),
                const SizedBox(height: 10,),
                Row(
                  children: [
                    Chip(
                      labelPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                      label: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
                        child: Text(
                            'Fine Arts',
                            style: text_style_title13
                        ),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 4.0,
                      shadowColor: Colors.grey[60],
                      padding: const EdgeInsets.all(8.0),
                    ),
                    const SizedBox(width: 10,),
                    Chip(
                      labelPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                      label: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
                        child: Text(
                            'Performance',
                            style:text_style_title13
                        ),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 4.0,
                      shadowColor: Colors.grey[60],
                      padding: const EdgeInsets.all(8.0),
                    ),
                    const SizedBox(width: 10,),
                    Chip(
                      labelPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                      label: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
                        child: Text(
                          'Dance',
                          style: text_style_title13,
                        ),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 4.0,
                      shadowColor: Colors.grey[60],
                      padding: const EdgeInsets.all(8.0),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Chip(
                      labelPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                      label: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
                        child: Text(
                            '3d Animation',
                            style: text_style_title13
                        ),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 4.0,
                      shadowColor: Colors.grey[60],
                      padding: const EdgeInsets.all(8.0),
                    ),
                    const SizedBox(width: 10,),
                    Chip(
                      labelPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                      label: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
                        child: Text(
                            'Fine Arts',
                            style:text_style_title13
                        ),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 4.0,
                      shadowColor: Colors.grey[60],
                      padding: const EdgeInsets.all(8.0),
                    ),
                    const SizedBox(width: 10,),
                    Chip(
                      labelPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                      label: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
                        child: Text(
                          'Arts',
                          style: text_style_title13,
                        ),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 4.0,
                      shadowColor: Colors.grey[60],
                      padding: const EdgeInsets.all(8.0),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
