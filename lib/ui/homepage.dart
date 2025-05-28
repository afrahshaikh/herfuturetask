import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:herfuturetask/components/commontext.dart';
import 'package:herfuturetask/provider/provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final word = ref.watch(wordProvider);
    final isPalindrome = ref.watch(isPalindromeProvider);
    final history = ref.watch(historyProvider);
  final themeMode = ref.watch(themeModeProvider);
    return Scaffold(
      appBar: AppBar(
      
        title: CommonText(
          text: 'Palindrome Checker',
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Enter a word',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onChanged:
                  (value) => ref.read(wordProvider.notifier).state = value,
              onSubmitted: (value) {
                ref.read(historyProvider.notifier).addWord(value);
              },
            ),
            const SizedBox(height: 20),
            CommonText(
              text:
                  word.isEmpty
                      ? 'Enter a word to check'
                      : isPalindrome
                      ? '✅ "$word" is a palindrome!'
                      : '❌ "$word" is not a palindrome.',
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                  ElevatedButton(
              onPressed: () {
                ref
                    .read(historyProvider.notifier)
                    .addWord(ref.read(wordProvider.notifier).state);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                backgroundColor: Color.fromARGB(
                  255,
                  229,
                  129,
                  163,
                ), // Button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
              ),
              child: const Text(
                'Submit',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
                ElevatedButton(
                  onPressed: () {
                   ref.read(historyProvider.notifier).clearState();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    backgroundColor: Color.fromARGB(255, 38, 49, 59), // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                    ),
                  ),
                  child: const Text(
                    'Clear History',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
               const SizedBox(height: 10),
            CommonText(text: 'Search History:'),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: history.length,
                itemBuilder: (_, index) {
                   final word = history[index];
      final cleaned = word.toLowerCase().replaceAll(RegExp(r'\W+'), '');
      final isPal = cleaned == cleaned.split('').reversed.join('');
                  return ListTile(
                    leading: CommonText(text: (index+1).toString(),color:isPal ? Color.fromARGB(
                  255,
                  229,
                  129,
                  163,
                ): Colors.black ),
                    title: CommonText(text: history[index],color:isPal ? Color.fromARGB(
                  255,
                  229,
                  129,
                  163,
                ): Colors.black )
                   ,);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
