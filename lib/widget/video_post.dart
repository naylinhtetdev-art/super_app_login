import 'package:flutter/material.dart';

class VideoPost extends StatelessWidget {
  const VideoPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/opst-img-1.png',
            width: double.infinity,
            height: 210,
            fit: BoxFit.cover,
          ),

          Container(
            width: 55,
            height: 55,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.play_arrow, color: Colors.black, size: 32),
          ),
        ],
      ),
    );
  }
}
