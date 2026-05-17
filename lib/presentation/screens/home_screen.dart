import 'package:comics/presentation/screens/app_home.dart';
import 'package:comics/presentation/widgets/comics_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  static const name = "home-screen";

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: AppHome()),

                  SliverToBoxAdapter(child: ComicsSection(name: "Marvel")),

                  SliverToBoxAdapter(child: ComicsSection(name: "DC Comics")),

                  SliverToBoxAdapter(
                    child: ComicsSection(name: "Image Comics"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
