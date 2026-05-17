import 'package:carousel_slider/carousel_slider.dart';
import 'package:comics/config/utils/html_utils.dart';
import 'package:comics/presentation/providers/comics/comic_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AppHome extends ConsumerStatefulWidget {
  const AppHome({super.key});

  @override
  ConsumerState<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends ConsumerState<AppHome> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final comicsAsync = ref.watch(searchComicsProvider("ultimate spiderman"));

    return comicsAsync.when(
      data: (comics) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.65,

          child: Stack(
            alignment: Alignment.bottomCenter,

            children: [
              CarouselSlider.builder(
                itemCount: comics.length,
                itemBuilder: (context, index, realIndex) {
                  final comic = comics[index];

                  return Stack(
                    fit: StackFit.expand,

                    children: [
                      Hero(
                        tag: comic.id,
                        child: Image.network(comic.imageUrl, fit: BoxFit.cover),
                      ),

                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.9),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 40,
                        left: 20,
                        right: 20,

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              comic.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 34,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            SizedBox(height: 10),

                            Text(
                              parseHtml(comic.description),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },

                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.65,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 1,

                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
              ),

              Positioned(
                bottom: 30,

                child: AnimatedSmoothIndicator(
                  activeIndex: currentIndex,
                  count: comics.length,

                  effect: ExpandingDotsEffect(
                    dotHeight: 8,
                    dotWidth: 8,
                    activeDotColor: Colors.white,
                    dotColor: Colors.white38,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      error: (_, __) => Text('Error'),
      loading: () => SizedBox(),
    );
  }
}
