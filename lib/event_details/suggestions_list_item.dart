import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../common/style.dart';

class UpdatesListingDashBoard extends StatefulWidget {
  const UpdatesListingDashBoard({
    Key? key,
  }) : super(key: key);

  @override
  State<UpdatesListingDashBoard> createState() =>
      UpdatesListingDashBoardState();
}

class UpdatesListingDashBoardState extends State<UpdatesListingDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 350,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(
                      left: 16,
                    ),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      if (index < 3) {
                        return const UpdatesPageListItem();
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class UpdatesPageListItem extends StatelessWidget {
  const UpdatesPageListItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, right: 10, bottom: 16),
          child: Container(
            width: 230,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              border: Border.all(color: Colors.grey),
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: FadeInImage.memoryNetwork(
                      height: 170,
                      width: double.infinity,
                      placeholder: kTransparentImage,
                      imageErrorBuilder: (_, __, ___) {
                        return Container(
                            color: Colors.grey.withOpacity(0.2),
                            height: 180,
                            width: double.infinity,
                            child: Image.network(
                              'https://static.vecteezy.com/system/resources/previews/008/390/796/original/abstract-background-purple-red-gradient-free-vector.jpg',
                              fit: BoxFit.cover,
                            ));
                      },
                      image:
                          'https://static.vecteezy.com/system/resources/previews/008/390/796/original/abstract-background-purple-red-gradient-free-vector.jpg',
                      fit: BoxFit.cover,
                    )),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Internation Music Bra...',
                        style: text_style_title3,
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
                      const Text(
                        'Rajputh Club',
                        style: text_style_title3,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
