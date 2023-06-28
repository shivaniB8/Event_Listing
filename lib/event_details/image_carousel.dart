import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ImageCarousel extends StatefulWidget {
  final List<String> imageList;
  const ImageCarousel({Key? key, required this.imageList}) : super(key: key);

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int _currentBannerAssetIndex = 0;
  final _carouselController = CarouselController();

  bool _isMultiBannerAssets() {
    return (widget.imageList.length) > 1;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          CarouselSlider.builder(
            carouselController: _carouselController,
            itemCount: widget.imageList.length,
            itemBuilder: (_, index, __) {
              if (index < widget.imageList.length) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            imageErrorBuilder: (_, __, ___) {
                              return Image(
                                image: Image.asset(
                                  'assets/images/loading.gif',
                                ).image,
                              );
                            },
                            image: widget.imageList[index],
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            },
            options: CarouselOptions(
              autoPlayAnimationDuration: const Duration(seconds: 2),
              autoPlay: _isMultiBannerAssets() ? true : false,
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollPhysics: _isMultiBannerAssets()
                  ? null
                  : const NeverScrollableScrollPhysics(),
              viewportFraction: 1,
              onPageChanged: (index, _) {
                setState(() {
                  _currentBannerAssetIndex = index;
                });
              },
            ),
          ),
          Visibility(
            visible: _isMultiBannerAssets(),
            child: Positioned(
              top: 130,
              left: 0,
              right: 0,
              child: Row(
                  key: const Key('dotsIndicator'),
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.imageList.asMap().entries.map(
                    (entry) {
                      return GestureDetector(
                        onTap: () =>
                            _carouselController.animateToPage(entry.key),
                        child: Container(
                          width: 8.0,
                          height: 8.0,
                          margin: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 4.0,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue.withOpacity(
                              _currentBannerAssetIndex == entry.key ? 0.9 : 0.4,
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList()),
            ),
          ),
        ],
      ),
    );
  }
}
