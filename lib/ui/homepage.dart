import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herfuturetask/provider/provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final word = ref.watch(wordProvider);
    final isPalindrome = ref.watch(isPalindromeProvider);
    final history = ref.watch(historyProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Palindrome Checker')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Enter a word',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => ref.read(wordProvider.notifier).state = value,
              onSubmitted: (value) {
                ref.read(historyProvider.notifier).addWord(value);
              },
            ),
            const SizedBox(height: 20),
            Text(
              word.isEmpty
                  ? 'Enter a word to check'
                  : isPalindrome
                      ? '✅ "$word" is a palindrome!'
                      : '❌ "$word" is not a palindrome.',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
             TextButton(onPressed: (){
                 ref.read(historyProvider.notifier).clearState();
            }, child: Text("Clear Search History")),
            const Text(
              'Search History:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: history.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    title: Text(history[index]),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
