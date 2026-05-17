import 'package:animate_do/animate_do.dart';
import 'package:comics/domain/entities/comic.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ComicsHorizontalList extends StatefulWidget {
  final String title;
  final List<Comic> comics;
  final VoidCallback? loadNextPage;

  const ComicsHorizontalList({
    super.key,
    required this.title,
    required this.comics,
    this.loadNextPage,
  });

  @override
  State<ComicsHorizontalList> createState() => _ComicsHorizontalListState();
}

class _ComicsHorizontalListState extends State<ComicsHorizontalList> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;

      if ( scrollController.position.pixels + 200 >=  scrollController.position.maxScrollExtent) {
        print('Cargar siguiente pagina');
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,

      children: [
        Padding(
          padding: EdgeInsets.all(16),

          child: Text(
            widget.title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),

        SizedBox(
          height: 200,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: widget.comics.length,
            itemBuilder: (BuildContext context, int index) {
              final comic = widget.comics[index];

              return Container(
                width: 140,
                margin: const EdgeInsets.symmetric(horizontal: 8),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Expanded(
                      child: ClipRRect(
                        child: Image.network(
                          comic.imageUrl,
                          fit: BoxFit.cover,

                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress != null) {
                              return Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade900,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              );
                            }

                            return GestureDetector(
                              onTap: () => context.push('/comics/${comic.id}'),
                              child: FadeIn(child: child),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
