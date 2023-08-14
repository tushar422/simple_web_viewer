import 'package:flutter/material.dart';
import 'package:simple_web_viewer/screen/web.dart';
import 'package:simple_web_viewer/widget/search_btn.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final urlController =
        TextEditingController(text: 'https://github.com/tushar422');
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    const bgHeight = 300.0;

    // print('$height x $width, bottom: $bottom');

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: height / 2 - bgHeight / 2,
            left: 10,
            right: 10,
            child: Container(
              height: bgHeight,
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                gradient: const LinearGradient(
                  begin: Alignment(0.00, -1.00),
                  end: Alignment(0, 1),
                  colors: [
                    Color.fromARGB(255, 250, 157, 16),
                    Color.fromARGB(255, 255, 91, 1),
                  ],
                ),
              ),
              child: Center(
                child: TextField(
                  controller: urlController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                    prefixIcon: const Icon(Icons.search),
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    labelText: 'URL',
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: height / 3 - 30 - bottom,
            left: width / 2 - 50,
            child: SearchButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return WebviewScreen(
                        url: urlController.text.trim(),
                      );
                    },
                    settings: const RouteSettings(name: '/webpage'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
