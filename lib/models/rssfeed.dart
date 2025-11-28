import 'package:beginners_course/pages/rssfeed_page.dart';

class FeedParser {
  static String getImageUrl(
    RssItem item, {
    String fallbackImageUrl = 'https://via.placeholder.com/150',
  }) {
    if (item.description != null &&
        item.description!.contains('img') &&
        item.description!.contains('src=')) {
      final regex = RegExp(r'src="([^"]+)"');
      final match = regex.firstMatch(item.description!);
      if (match != null) {
        return match.group(1)!;
      }
    }
    return fallbackImageUrl;
  }
}

class RssItem {
  final String? title;
  final String? description;
  final String? pubDate;
  final String? link;

  RssItem({
    this.title,
    this.description,
    this.pubDate,
    this.link,
  });
}
