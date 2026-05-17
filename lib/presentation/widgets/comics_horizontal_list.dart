import 'package:animate_do/animate_do.dart';
import 'package:comics/domain/entities/comic.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ComicsHorizontalList extends StatelessWidget {
  final String title;
  final List<Comic> comics;

  const ComicsHorizontalList({
    super.key,
    required this.title,
    required this.comics,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,

      children: [
        Padding(
          padding: EdgeInsets.all(16),

          child: Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),

        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: comics.length,
            itemBuilder: (BuildContext context, int index) {
              final comic = comics[index];

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
