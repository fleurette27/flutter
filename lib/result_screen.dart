// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:translator/translator.dart';

class ResultScreen extends StatelessWidget {
  final String text;

  const ResultScreen({super.key, required this.text});

  Future<void> _translateText(BuildContext context) async {
    final translator = GoogleTranslator();

    try {
      // Traduire le texte
      Translation translation = await translator.translate(text, to: 'fr');

      // Afficher le texte traduit dans une Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(translation.text),
        ),
      );
    // ignore: empty_catches
    } catch (e) {
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Result'),
          actions: [
            IconButton(
              icon: const Icon(Icons.copy_all_sharp),
              onPressed: () {
                Clipboard.setData(ClipboardData(text: text));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Texte copié dans le presse-papiers'),
                  ),
                );
              },
            ),
              IconButton(
              icon: const Icon(Icons.g_translate_sharp),
              onPressed: () {
                _translateText(context);
              },
            ),
            IconButton(
              icon: const Icon(Icons.share_sharp),
              onPressed: () {
                Share.share(text);
              },
            ),
          
          ],
        ),
        body: Container(
          padding: const EdgeInsets.all(30.0),
          child: Text(text),
        ),
      );
}
