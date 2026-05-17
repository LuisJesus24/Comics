import 'package:comics/presentation/providers/comics/comic_provider.dart';
import 'package:comics/presentation/widgets/comics_horizontal_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComicsSection extends ConsumerWidget {
  final String name;

  const ComicsSection({super.key, required this.name});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final comicsAsync = ref.watch(searchComicsProvider(name));

    return comicsAsync.when(
      data: (comics) {
        return ComicsHorizontalList(title: name, comics: comics);
      },
      error: (_, e) => Text('Error $e'),
      loading: () => const SizedBox(),
    );
  }
}
