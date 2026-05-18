import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linguabridge/src/features/auth/data/auth_repository.dart';

class LeaderboardScreen extends ConsumerWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaderboardAsync = ref.watch(watchLeaderboardProvider);
    final authState = ref.watch(authStateChangesProvider);
    final activeUid = authState.value?.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Global Leaderboard'),
        centerTitle: true,
      ),
      body: leaderboardAsync.when(
        data: (users) {
          if (users.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Text('No users found on the leaderboard.'),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              final isMe = user.uid == activeUid;
              final rank = index + 1;

              Widget rankBadge;
              if (rank == 1) {
                rankBadge = const CircleAvatar(
                  backgroundColor: Colors.amber, 
                  child: Text('1', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                );
              } else if (rank == 2) {
                rankBadge = const CircleAvatar(
                  backgroundColor: Color(0xFFC0C0C0), 
                  child: Text('2', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                );
              } else if (rank == 3) {
                rankBadge = const CircleAvatar(
                  backgroundColor: Color(0xFFCD7F32), 
                  child: Text('3', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                );
              } else {
                rankBadge = CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest, 
                  child: Text('$rank', style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant))
                );
              }

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                color: isMe ? Theme.of(context).colorScheme.primaryContainer : null,
                elevation: isMe ? 4 : 1,
                child: ListTile(
                  leading: rankBadge,
                  title: Text(
                    user.displayName ?? user.email,
                    style: TextStyle(
                      fontWeight: isMe ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  subtitle: isMe ? const Text('You', style: TextStyle(fontStyle: FontStyle.italic)) : null,
                  trailing: Text(
                    '${user.totalPoints} pts',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isMe ? Theme.of(context).colorScheme.onPrimaryContainer : Colors.green,
                    ),
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
