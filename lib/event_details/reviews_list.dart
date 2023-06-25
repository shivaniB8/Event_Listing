import 'package:all_events_task/common/colors.dart';
import 'package:all_events_task/common/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewsList extends StatelessWidget {
  const ReviewsList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16.0,
          bottom: 24.0,
        ),
        child: SizedBox(
          height: 140,
          child: ListView.builder(
            itemBuilder: (BuildContext context, index) {
              return Container(
                width: 220,
                margin: const EdgeInsets.only(right: 14.0),
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                 color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 18.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50.0,
                        decoration: const BoxDecoration(
                          color: toggle_text_color,
                          shape: BoxShape.circle,
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: Image.network('https://media-cldnry.s-nbcnews.com/image/upload/rockcms/2022-04/220421-elon-musk-al-1017-a6eece.jpg', height: 50, width: 50,).image,
                            ),
                            const SizedBox(width: 10,),
                            Column(
                              children:  [
                                const Text('Elon Musk ', style: text_style_para2,),
                                RatingBarIndicator(
                                  rating: 4.5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                  itemCount: 5,
                                  itemSize: 10.0,
                                  direction: Axis.horizontal,
                                ),
                                const Text('1 Month ago',style: text_style_para2),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                       'DJ was fantastic, and music was absolutely bang. Thanks for a great night.',
                        style: text_style_title5.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            'Review For :',
                            style: text_style_para2.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Text(
                            'SBR Youniverse',
                            style: text_style_para3,
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              );
            },
            itemCount: 3,
            shrinkWrap: true,
            padding: const EdgeInsets.all(4),
            scrollDirection: Axis.horizontal,
          ),
        ),
      ),
    );
  }
}