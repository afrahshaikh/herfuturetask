import 'package:flutter/material.dart';
import 'package:herfuturetask/components/herfuturelogo.dart';
import 'package:herfuturetask/provider/provider.dart';
import 'package:herfuturetask/ui/homepage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}


class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
     final themeMode = ref.watch(themeModeProvider);
    return  MaterialApp(
        theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      home: Scaffold(
        appBar: AppBar(
             actions: [
          Row(
            children: [
              const Icon(Icons.light_mode,size: 20,),
              Switch(
                padding: EdgeInsets.all(5),
                activeColor: Color.fromARGB(255, 229, 129, 163),
                value: themeMode == ThemeMode.dark,
                onChanged: (val) {
                  ref.read(themeModeProvider.notifier).state =
                      val ? ThemeMode.dark : ThemeMode.light;
                },
              ),
              const Icon(Icons.dark_mode, size: 20,),
            ],
          ),
         ],
          title: logoherFuture(),),

        body: Center(
          child: HomePage(),
        ),
      ),
    );
  }
}
