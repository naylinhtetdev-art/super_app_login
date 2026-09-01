import 'package:flutter/material.dart';

class PostImageGrid extends StatelessWidget {
  final List<String> images;

  const PostImageGrid({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    // 1 Image
    if (images.length == 1) {
      return Image.asset(
        images[0],
        width: double.infinity,
        height: 230,
        fit: BoxFit.cover,
      );
    }

    // 2 Images
    if (images.length == 2) {
      return SizedBox(
        height: 220,

        child: Row(
          children: [
            Expanded(
              child: Image.asset(
                images[0],
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 2),

            Expanded(
              child: Image.asset(
                images[1],
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      );
    }

    // 3 or more
    return SizedBox(
      height: 260,

      child: Row(
        children: [
          Expanded(
            flex: 2,

            child: Image.asset(
              images[0],
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 2),

          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(
                    images[1],
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(height: 2),

                Expanded(
                  child: Image.asset(
                    images[2],
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
