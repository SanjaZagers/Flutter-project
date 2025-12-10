import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:beginners_course/models/rssfeed.dart';
import 'package:beginners_course/models/newscard.dart';

class RssFeedPage extends StatefulWidget {
  const RssFeedPage({super.key});

  @override
  _RssFeedPageState createState() => _RssFeedPageState();
}

class _RssFeedPageState extends State<RssFeedPage> {
  // Example static articles (replace with real RSS fetching later)
  final List<RssItem> articles = [
    RssItem(
      title: "Flutter 3.13 Released!",
      description:
          "<img src='https://via.placeholder.com/150'> Flutter news details...",
      link: "https://flutter.dev",
    ),
    RssItem(
      title: "Good News Article 2",
      description:
          "<img src='https://via.placeholder.com/150'> More details...",
      link: "https://example.com/article2",
    ),
  ];

  Future<void> _openArticle(String url) async {
    if (url.isNotEmpty && await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Good News')),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final item = articles[index];
          return CustomNewsCard(
            title: item.title ?? 'Untitled',
            imageUrl: FeedParser.getImageUrl(
              item,
              fallbackImageUrl: 'https://via.placeholder.com/150',
            ),
            onTap: () => _openArticle(item.link ?? ''),
          );
        },
      ),
    );
  }
}
