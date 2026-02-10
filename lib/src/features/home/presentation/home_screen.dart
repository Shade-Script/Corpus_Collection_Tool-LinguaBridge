import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:linguabridge/src/features/translation/data/translation_repository.dart';
import 'package:linguabridge/src/features/translation/domain/translation_item.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentTranslationsAsync = ref.watch(watchTranslationsProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text('LinguaBridge'),
            centerTitle: true,
            floating: true,
            pinned: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Welcome Contributor!',
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: _FeatureCard(
                          icon: Icons.translate,
                          title: 'Translate',
                          color: Theme.of(context).colorScheme.primaryContainer,
                          onTap: () => context.go('/translation'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _FeatureCard(
                          icon: Icons.camera_alt,
                          title: 'Capture',
                          color: Theme.of(
                            context,
                          ).colorScheme.secondaryContainer,
                          onTap: () => context.go('/image_capture'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Recent Contributions',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          recentTranslationsAsync.when(
            data: (translations) {
              if (translations.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Text('No contributions yet. Start now!'),
                    ),
                  ),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final item = translations[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 4.0,
                    ),
                    child: Card(
                      elevation: 2,
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (item.imageUrl != null)
                            Image.network(
                              item.imageUrl!,
                              height: 150,
                              fit: BoxFit.cover,
                              errorBuilder: (ctx, err, stack) => Container(
                                height: 150,
                                color: Colors.grey[200],
                                child: const Center(
                                  child: Icon(Icons.broken_image),
                                ),
                              ),
                            ),
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.tertiaryContainer,
                              child: Text(
                                item.sourceLanguage
                                    .substring(0, 1)
                                    .toUpperCase(),
                                style: TextStyle(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onTertiaryContainer,
                                ),
                              ),
                            ),
                            title: Text(
                              item.sourceText,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text(
                                  item.translatedText,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${item.sourceLanguage} → ${item.targetLanguage}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                            isThreeLine: true,
                          ),
                        ],
                      ),
                    ),
                  );
                }, childCount: translations.length),
              );
            },
            loading: () => const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (err, stack) => SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(child: Text('Error loading data: $err')),
              ),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.only(bottom: 80),
          ), // Bottom spacing
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40),
              const SizedBox(height: 12),
              Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
