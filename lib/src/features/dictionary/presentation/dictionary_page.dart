import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:linguabridge/src/features/language/data/language_repository.dart';

class DictionaryPage extends ConsumerWidget {
  const DictionaryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languagesAsync = ref.watch(watchLanguagesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Language Dictionary')),
      body: languagesAsync.when(
        data: (languages) {
          if (languages.isEmpty) {
            return const Center(child: Text('No languages registered yet.'));
          }
          return ListView.builder(
            itemCount: languages.length,
            itemBuilder: (context, index) {
              final language = languages[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(language.name[0].toUpperCase()),
                  ),
                  title: Text(language.name),
                  subtitle: Text('${language.tribe ?? 'Unknown Tribe'} • ${language.location}'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    context.push('/dictionary/${Uri.encodeComponent(language.name)}');
                  },
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
