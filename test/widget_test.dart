// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:super_app/model/post_model.dart';
import 'package:super_app/view/post_card.dart';

void main() {
  testWidgets('PostCard action buttons render without missing asset errors', (
    WidgetTester tester,
  ) async {
    final post = PostModel(
      id: '1',
      userName: 'Nay',
      avatar: 'assets/images/profile-image.png',
      text: 'Hello world',
      hashtags: '#flutter',
      images: const ['assets/images/opst-img-1.png'],
      likes: 12,
      comments: 3,
      share: 8,
      timeAgo: '2h',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: PostCard(post: post)),
      ),
    );

    expect(find.byType(PostCard), findsOneWidget);
    expect(find.text('12'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
    expect(find.text('8'), findsOneWidget);
  });
}
