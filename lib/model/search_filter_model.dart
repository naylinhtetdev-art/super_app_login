import 'package:flutter/material.dart';

class SearchFilterModel {
  final IconData icon;
  final String label;

  SearchFilterModel({required this.icon, required this.label});
}

class TrendingModel {
  final String rank;
  final String tag;
  final String posts;

  TrendingModel({required this.rank, required this.tag, required this.posts});

  // API (JSON) မှ Data များကို Object အဖြစ် ပြောင်းလဲရန်
  factory TrendingModel.fromJson(Map<String, dynamic> json) {
    return TrendingModel(
      rank: json['rank'] ?? '',
      tag: json['tag'] ?? '',
      posts: json['posts'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'rank': rank, 'tag': tag, 'posts': posts};
  }
}

class RecommendedUserModel {
  final String id;
  final String name;
  final String avatarUrl;

  RecommendedUserModel({
    required this.id,
    required this.name,
    required this.avatarUrl,
  });

  // API (JSON) မှ Data များကို Object အဖြစ် ပြောင်းလဲရန်
  factory RecommendedUserModel.fromJson(Map<String, dynamic> json) {
    return RecommendedUserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      avatarUrl: json['avatarUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'avatarUrl': avatarUrl};
  }
}

class SuggestedUserModel {
  final String id;
  final String name;
  final String avatarUrl;
  final String members;

  SuggestedUserModel({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.members,
  });

  // API (JSON) မှ Data များကို Object အဖြစ် ပြောင်းလဲရန်
  factory SuggestedUserModel.fromJson(Map<String, dynamic> json) {
    return SuggestedUserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      avatarUrl: json['avatarUrl'] ?? '',
      members: json['members'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'avatarUrl': avatarUrl, 'members': members};
  }
}
