import 'package:all_events_task/common/colors.dart';
import 'package:all_events_task/common/style.dart';
import 'package:all_events_task/data/api_services/dashboard_listing_api.dart';
import 'package:all_events_task/data/responses/event_details_response.dart';
import 'package:all_events_task/event_details/event_details_page.dart';
import 'package:all_events_task/search.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:flutter/material.dart';
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
  late int? index = 0;
  late bool isFilterApplied;
  List<EventDetailsResponse>? searchItem=[];

  Future<void> _sharePath(String path) async {
    await Share.share(path);
  }

  @override
  void initState() {
    _isLoading = true;
    isFilterApplied = false;
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
    eventList = await getAllEvents(index ?? 0);

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<EventDetailsResponse>? items = eventList?.item;
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
        title: const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
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
          Padding(
            padding: const EdgeInsets.only(
                top: 20.0, left: 20, right: 20, bottom: 10),
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
                        children: [
                          Icon(
                            Icons.category_outlined,
                            color: isFilterApplied ? Colors.blue : Colors.grey,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            'Categories',
                            style: text_style_title5.copyWith(
                              color:
                                  isFilterApplied ? Colors.blue : Colors.grey,
                            ),
                          )
                        ],
                      ),
                      onTap: () async {
                        isFilterApplied = true;
                        await showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            enableDrag: false,
                            isDismissible: false,
                            backgroundColor: Colors.transparent,
                            builder: (_) {
                              return Container(
                                padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom,
                                ),
                                child: FiltersBottomSheet(
                                  onApplied: (value) {
                                    setState(() {
                                      index = value;
                                      _isLoading = true;
                                      _getAllEvent();
                                    });
                                  },
                                ),
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
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: SearchProjectField(
              list: items?.map((e) => e.eventName ?? '').toList() ?? [],
              onProjectSelected: (project) async {
                setState(() {
                  searchItem = items
                      ?.where((element) => element.eventName == project)
                      .toList();
                });
              },
              onSelectionCleared: () {
                searchItem = eventList?.item;
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: Container(
              child: !_isLoading &&
                      (items?.isNotEmpty ?? false) &&
                  ( searchItem?.isEmpty??false)
                  ? ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(top: 20),
                      controller: _eventListScrollController,
                      itemCount: items!.length + 1,
                      itemBuilder: (context, index) {
                        if (index < (items.length)) {
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
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(
                                                height: 2,
                                              ),
                                              Text(
                                                items[index]
                                                        .startTimeDisplay ??
                                                    '',
                                                overflow: TextOverflow.ellipsis,
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
                                                overflow: TextOverflow.ellipsis,
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
                                                        _sharePath(items[index]
                                                                .shareUrl ??
                                                            '');
                                                      }
                                                    },
                                                    icon: const Icon(
                                                      Icons.ios_share_outlined,
                                                      color: Colors.blue,
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                  ),
                                                  _AddButton()
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
                                      event: items[index] ,
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
                  : searchItem?.length != null
                      ? ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.only(top: 20),
                          controller: _eventListScrollController,
                          itemCount: searchItem!.length,
                          itemBuilder: (context, index) {
                            if (index < (searchItem?.length ?? 0)) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 12.0, right: 12, top: 5, bottom: 5),
                                child: GestureDetector(
                                  child: Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
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
                                                      searchItem?[index]
                                                                  .thumbUrl ??
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
                                                  top: 10.0,
                                                  left: 10,
                                                  right: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    searchItem?[index].eventName ??
                                                        '',
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
                                                    searchItem?[index]
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
                                                    '${searchItem?[index].location}, ${searchItem?[index].venue?.city}',
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
                                                          if (searchItem?[index]
                                                                  .shareUrl
                                                                  ?.isNotEmpty ??
                                                              false) {
                                                            _sharePath(searchItem?[
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
                                                            const EdgeInsets
                                                                .all(0),
                                                      ),
                                                      _AddButton()
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
                                          event: searchItem?[index] ??
                                              EventDetailsResponse(),
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
                        ),
            ),
          )
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.star_border, color: Colors.blue),
        onPressed: () {});
  }
}

class FiltersBottomSheet extends StatefulWidget {
  final Function(int) onApplied;
  const FiltersBottomSheet({
    Key? key,
    required this.onApplied,
  }) : super(key: key);

  @override
  State<FiltersBottomSheet> createState() => _FiltersBottomSheetState();
}

class _FiltersBottomSheetState extends State<FiltersBottomSheet> {
  late int? tag = -1;
  List<String> tags = [];
  List<String> options = [
    'All Events',
    'Music',
    'Business',
    'Sports',
    'Workshops',
  ];

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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Entertainment',
                  style: text_style_title6,
                ),
                ChipsChoice.single(
                  value: tag,
                  onChanged: (val) {
                    setState(() {
                      tag = val;
                    });
                  },
                  choiceItems: C2Choice.listFrom(
                    source: options,
                    value: (i, v) => i,
                    label: (i, v) => v,
                  ),
                  choiceActiveStyle: const C2ChoiceStyle(
                      showCheckmark: false,
                      backgroundColor: Colors.blue,
                      color: Colors.white,
                      labelPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      labelStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      )),
                  runSpacing: 10,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  choiceStyle: const C2ChoiceStyle(
                      labelPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      color: Colors.grey,
                      backgroundColor: Colors.white,
                      borderColor: Colors.black38,
                      labelStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      )),
                  wrapped: true,
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Arts And Theater',
                  style: text_style_title6,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    Chip(
                      labelPadding: EdgeInsets.symmetric(horizontal: 5.0),
                      label: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
                        child: Text('Fine Arts', style: text_style_title13),
                      ),
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.grey),
                      padding: EdgeInsets.all(8.0),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Chip(
                      labelPadding: EdgeInsets.symmetric(horizontal: 5.0),
                      label: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
                        child: Text('Theatre', style: text_style_title13),
                      ),
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.grey),
                      padding: EdgeInsets.all(8.0),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Chip(
                      labelPadding: EdgeInsets.symmetric(horizontal: 5.0),
                      label: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
                        child: Text(
                          'Literary Art',
                          style: text_style_title13,
                        ),
                      ),
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.grey),
                      padding: EdgeInsets.all(8.0),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Chip(
                      labelPadding: EdgeInsets.symmetric(horizontal: 5.0),
                      label: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
                        child: Text('Cooking', style: text_style_title13),
                      ),
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.grey),
                      padding: EdgeInsets.all(8.0),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Chip(
                      labelPadding: EdgeInsets.symmetric(horizontal: 5.0),
                      label: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
                        child: Text('Photography', style: text_style_title13),
                      ),
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.grey),
                      padding: EdgeInsets.all(8.0),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Chip(
                      labelPadding: EdgeInsets.symmetric(horizontal: 5.0),
                      label: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
                        child: Text(
                          'Craft',
                          style: text_style_title13,
                        ),
                      ),
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.grey),
                      padding: EdgeInsets.all(8.0),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'More',
                  style: text_style_title6,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    Chip(
                      labelPadding: EdgeInsets.symmetric(horizontal: 5.0),
                      label: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
                        child: Text('Fine Arts', style: text_style_title13),
                      ),
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.grey),
                      padding: EdgeInsets.all(8.0),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Chip(
                      labelPadding: EdgeInsets.symmetric(horizontal: 5.0),
                      label: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
                        child: Text('Performance', style: text_style_title13),
                      ),
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.grey),
                      padding: EdgeInsets.all(8.0),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Chip(
                      labelPadding: EdgeInsets.symmetric(horizontal: 5.0),
                      label: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
                        child: Text(
                          'Dance',
                          style: text_style_title13,
                        ),
                      ),
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.grey),
                      padding: EdgeInsets.all(8.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Center(
                child: ElevatedButton(
              onPressed: () {
                widget.onApplied.call((tag) ?? 0);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
                child: Text(
                  'Apply Filter',
                  style: text_style_title4.copyWith(color: Colors.white),
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }
}
