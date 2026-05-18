import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:linguabridge/src/features/auth/data/auth_repository.dart';
import 'package:linguabridge/src/features/translation/data/translation_repository.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentTranslationsAsync = ref.watch(watchTranslationsProvider);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            title: const Text('LinguaBridge Dashboard'),
            centerTitle: true,
            floating: true,
            pinned: true,
            actions: [
              PopupMenuButton<String>(
                icon: const Icon(Icons.account_circle, size: 32),
                onSelected: (value) async {
                  if (value == 'logout') {
                    await ref.read(authRepositoryProvider).signOut();
                  } else if (value == 'delete') {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Delete Account?'),
                        content: const Text('This action is permanent and destroys all your synced connection data. Proceed?'),
                        actions: [
                          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true), 
                            child: const Text('Obliterate', style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );
                    if (confirm == true) {
                      try {
                        await ref.read(authRepositoryProvider).deleteAccount();
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Firebase Security Error: $e (Tip: Try logging out and back in to refresh token, then delete)')));
                        }
                      }
                    }
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'logout',
                    child: ListTile(
                      leading: Icon(Icons.exit_to_app),
                      title: Text('Log Out'),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  const PopupMenuDivider(),
                  const PopupMenuItem<String>(
                    value: 'delete',
                    child: ListTile(
                      leading: Icon(Icons.delete_forever, color: Colors.red),
                      title: Text('Delete Account', style: TextStyle(color: Colors.red)),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Your Points / Leaderboard',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Consumer(
                    builder: (context, ref, child) {
                      final authState = ref.watch(authStateChangesProvider);
                      final uid = authState.value?.uid;
                      
                      if (uid == null) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      final appUserAsync = ref.watch(watchAppUserProvider(uid));

                      return appUserAsync.when(
                        data: (appUser) {
                          final personalPoints = appUser?.totalPoints ?? 0;
                          return Card(
                            color: Theme.of(context).colorScheme.primaryContainer,
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              onTap: () => context.go('/leaderboard'),
                              child: Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.emoji_events, size: 48, color: Colors.orange),
                                        IconButton(
                                          icon: const Icon(Icons.info_outline),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: const Text('Local Points Distribution'),
                                                content: const Text(
                                                  '+5 - Word\n+10 - Word + Image/Audio\n+30 - Word + Image + Audio\n\nPoints are global and synced securely to your Auth Profile.',
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () => Navigator.of(context).pop(),
                                                    child: const Text('Got it!'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Your Contribution Points',
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    Text(
                                      '$personalPoints',
                                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text('Tap anywhere on this card to view Leaderboard.', style: TextStyle(fontSize: 12)),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        loading: () => const Center(child: CircularProgressIndicator()),
                        error: (e, st) {
                          // Fallback to 0 pts card — doc may not exist yet for this session
                          return Card(
                            color: Theme.of(context).colorScheme.primaryContainer,
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              onTap: () => context.go('/leaderboard'),
                              child: const Padding(
                                padding: EdgeInsets.all(24.0),
                                child: Column(
                                  children: [
                                    Icon(Icons.emoji_events, size: 48, color: Colors.orange),
                                    SizedBox(height: 8),
                                    Text('Your Contribution Points'),
                                    Text('0', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
                                    SizedBox(height: 8),
                                    Text('Tap to view Leaderboard', style: TextStyle(fontSize: 12)),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Recent Community Feed',
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
                      child: Text('No contributions yet. Be the first!'),
                    ),
                  ),
                );
              }
              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final item = translations[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
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
                                child: const Center(child: Icon(Icons.broken_image)),
                              ),
                            ),
                          ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                              child: Text(
                                item.sourceLanguage.isNotEmpty ? item.sourceLanguage.substring(0, 1).toUpperCase() : '?',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                                ),
                              ),
                            ),
                            title: Text(
                              item.sourceText,
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Text(item.translatedText, style: const TextStyle(fontSize: 16)),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${item.sourceLanguage} → ${item.targetLanguage}',
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                    Text(
                                      '+${item.pointsEarned} pts',
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
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
          const SliverPadding(padding: EdgeInsets.only(bottom: 80)),
        ],
      ),
    );
  }
}
