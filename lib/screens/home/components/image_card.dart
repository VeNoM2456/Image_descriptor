import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ImageFromURL extends StatefulWidget {
  const ImageFromURL({
    Key? key,
    required this.title,
    this.color = const Color(0xFF7553F6),
    required this.imageUrl,
    required this.datetime,
  }) : super(key: key);


  final String title;
  final Color color;
  final String imageUrl;
  final String datetime;

  @override
  State<ImageFromURL> createState() => _ImageFromURLState();
}

class _ImageFromURLState extends State<ImageFromURL> {
  final FlutterTts flutterTts = FlutterTts();
  speak(String text) async {
    flutterTts.setLanguage("en-Us");
    await flutterTts.setVolume(1.0);
    await flutterTts.setSpeechRate(0.35);
    await flutterTts.setPitch(0.8);
    await flutterTts.setVoice({"name": "Karen", "locale": "en-AU"});
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.color,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.network(
              widget.imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Text(
                    'Error loading image',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      widget.datetime,
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                    TextButton(onPressed:()=>{speak(widget.title)}, child: Icon(CupertinoIcons.speaker_2_fill))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
