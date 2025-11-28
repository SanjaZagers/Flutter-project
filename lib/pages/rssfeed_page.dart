import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'rssfeed.dart';
import 'custom_news_card.dart';

class CustomArticleDisplay extends StatelessWidget {
  final RssItem item;

  const CustomArticleDisplay({super.key, required this.item});

  Future<void> _openArticle() async {
    final url = item.link;
    if (url != null && await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.title ?? 'Article')),
      body: CustomNewsCard(
        title: item.title ?? 'Untitled',
        imageUrl: FeedParser.getImageUrl(
          item,
          fallbackImageUrl: 'https://via.placeholder.com/150',
        ),
        onTap: _openArticle,
      ),
    );
  }
}
