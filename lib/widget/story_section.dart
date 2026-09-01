import 'package:flutter/material.dart';

class StorySection extends StatelessWidget {
  const StorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final users = [
      ['Add Story', 'assets/images/story-plus-filled.png'],
      ['My Story', 'assets/images/user-ellipse-2.png'],
      ['Mya', 'assets/images/user-ellipse-1.png'],
      ['Su Su', 'assets/images/user-ellipse-2.png'],
      ['Htet', 'assets/images/user-ellipse-1.png'],
      ['Aung', 'assets/images/user-ellipse-2.png'],
      ['Naing', 'assets/images/user-ellipse-1.png'],
      ['Zin', 'assets/images/user-ellipse-2.png'],
    ];

    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: users.length,
        itemBuilder: (context, index) {
          return Container(
            width: 65,
            margin: const EdgeInsets.only(right: 12),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: users[index][0] == 'Add Story'
                      ? BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[800],
                        )
                      : const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [Colors.pink, Colors.orange, Colors.purple],
                          ),
                        ),
                  child: CircleAvatar(
                    radius: 27,
                    backgroundImage: AssetImage(users[index][1]),
                    backgroundColor: Colors.grey[800],
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  users[index][0],
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 11),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
