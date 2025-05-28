import 'package:flutter_riverpod/flutter_riverpod.dart';

//provider to manage input from user
final wordProvider = StateProvider<String>((ref) => '');

//to check if the word is palindrome
final isPalindromeProvider = Provider<bool>((ref) {
  final word = ref.watch(wordProvider).toLowerCase();
  final cleaned = word.replaceAll(RegExp(r'\W+'), '');
  return cleaned == cleaned.split('').reversed.join('');
});

//provider to manage history
final historyProvider = StateNotifierProvider<HistoryNotifier, List<String>>((ref) {
  return HistoryNotifier();
});

class HistoryNotifier extends StateNotifier<List<String>> {
  HistoryNotifier() : super([]);

//add word to the state
  void addWord(String word) {
    if (word.trim().isEmpty) return;
    if (!state.contains(word)) {
      state = [...state, word];
    }
  }

//delete search history
  void clearState(){
    state = [];
  }
}
