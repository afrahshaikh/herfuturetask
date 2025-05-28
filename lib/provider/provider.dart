import 'dart:collection';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.light);

//provider to manage input from user
final wordProvider = StateProvider<String>((ref) => '');

//to check if the word is palindrome
final isPalindromeProvider = Provider<bool>((ref) {
  final word = ref.watch(wordProvider).toLowerCase();
  final cleaned = word.replaceAll(RegExp(r'\W+'), '');
  return cleaned == cleaned.split('').reversed.join('');
});

final count = StateNotifierProvider<CountNotifier, List<int>>((
  ref,
) {
  return CountNotifier();
});


class CountNotifier extends StateNotifier<List<int>> {
  CountNotifier() : super([]);

  void addcount (){
  state = [...state , 0];
  log(state.toString());
  }

}
//provider to manage history
final historyProvider = StateNotifierProvider<HistoryNotifier, List<String>>((
  ref,
) {
  return HistoryNotifier();
});

class HistoryNotifier extends StateNotifier<List<String>> {
  HistoryNotifier() : super([]);
  int count = 0;
  final Map<String, int> _wordCount = {};

  // Add word to the state and keep count
  void addWord(String word) {
    word = word.trim();
    if (word.isEmpty) return;

    _wordCount[word] = (_wordCount[word] ?? 0) + 1;
    log('"$word" called ${_wordCount[word]}.');

   
    if (state.contains(word)) {
      state = state.where((w) => w != word).toList();
    }
    state = [...state, word];
  }

  int getCount(String word) => _wordCount[word] ?? 0;

  Map<String, int> get allCounts => Map.unmodifiable(_wordCount);


//delete search history 
  void clearState() {
    state = [];
  }
}
