import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:linguabridge/src/features/translation/data/translation_repository.dart';
import 'package:linguabridge/src/features/translation/domain/translation_item.dart';

class LanguageDetailPage extends ConsumerWidget {
  final String languageName;

  const LanguageDetailPage({super.key, required this.languageName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Decode if needed, though GoRouter passes it directly usually.
    final name = Uri.decodeComponent(languageName);
    final translationsAsync = ref.watch(watchTranslationsByLanguageProvider(name));

    return Scaffold(
      appBar: AppBar(title: Text('$name Dictionary')),
      body: translationsAsync.when(
        data: (translations) {
          if (translations.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: Text('No words contributed for this language yet!'),
              ),
            );
          }
          return ListView.builder(
            itemCount: translations.length,
            itemBuilder: (context, index) {
              final item = translations[index];
              return _DictionaryWordCard(item: item);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

class _DictionaryWordCard extends StatefulWidget {
  final TranslationItem item;
  const _DictionaryWordCard({required this.item});

  @override
  State<_DictionaryWordCard> createState() => _DictionaryWordCardState();
}

class _DictionaryWordCardState extends State<_DictionaryWordCard> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _togglePlay() async {
    if (widget.item.audioUrl == null) return;
    
    if (_isPlaying) {
      await _audioPlayer.stop();
      setState(() => _isPlaying = false);
    } else {
      await _audioPlayer.play(UrlSource(widget.item.audioUrl!));
      setState(() => _isPlaying = true);
      _audioPlayer.onPlayerComplete.listen((_) {
        if (mounted) setState(() => _isPlaying = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
            title: Text(
              item.sourceText,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            trailing: item.audioUrl != null
                ? IconButton(
                    icon: Icon(_isPlaying ? Icons.stop_circle : Icons.play_circle_fill),
                    color: Theme.of(context).colorScheme.primary,
                    iconSize: 40,
                    onPressed: _togglePlay,
                  )
                : null,
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (item.phoneticSpelling != null && item.phoneticSpelling!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                    child: Text('Pronunciation: ${item.phoneticSpelling}'),
                  ),
                Text('Meaning: ${item.translatedText}', style: const TextStyle(fontSize: 16)),
                if (item.contextSentenceOriginal != null && item.contextSentenceOriginal!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('Context (Original): "${item.contextSentenceOriginal}"', style: const TextStyle(fontStyle: FontStyle.italic)),
                  ),
                if (item.contextSentenceTranslated != null && item.contextSentenceTranslated!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text('Context (Translated): "${item.contextSentenceTranslated}"', style: const TextStyle(fontStyle: FontStyle.italic)),
                  ),
              ],
            ),
            isThreeLine: true,
          ),
        ],
      ),
    );
  }
}
