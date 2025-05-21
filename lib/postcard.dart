import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final String username;
  final String handle;
  final String time;
  final String content;
  final String avatarUrl;
  final int replies;
  final int retweets;
  final int likes;
  final String views;

  const PostCard({
    super.key,
    required this.username,
    required this.handle,
    required this.time,
    required this.content,
    required this.avatarUrl,
    required this.replies,
    required this.retweets,
    required this.likes,
    required this.views,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              CircleAvatar(
                backgroundImage: NetworkImage(avatarUrl),
                radius: 22,
              ),
              const SizedBox(width: 12),
              // Post content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Username, handle & time
                    Row(
                      children: [
                        Text(
                          username,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '@$handle · $time',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    // Content
                    Text(content),
                    const SizedBox(height: 12),
                    // Icons Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _iconText(Icons.mode_comment_outlined, replies.toString()),
                        _iconText(Icons.repeat, retweets.toString()),
                        _iconText(Icons.favorite_border, likes.toString()),
                        _iconText(Icons.bar_chart, views),
                        const Icon(Icons.share, size: 18, color: Colors.grey),
                        const Icon(Icons.bookmark_border, size: 18, color: Colors.grey),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1, color: Colors.grey),
      ],
    );
  }

  Widget _iconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}
