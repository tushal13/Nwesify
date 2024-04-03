class NewsModal {
  Source source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  DateTime? publishedAt;
  String? content;

  NewsModal({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory NewsModal.fromMap(Map<String, dynamic> news) => NewsModal(
        source: Source.fromMap(news["source"]),
        author: news["author"],
        title: news["title"],
        description: news["description"],
        url: news["url"],
        urlToImage: news["urlToImage"],
        publishedAt: DateTime.parse(news["publishedAt"]),
        content: news["content"],
      );
}

class Source {
  dynamic id;
  String name;

  Source({
    required this.id,
    required this.name,
  });

  factory Source.fromMap(Map<String, dynamic> source) => Source(
        id: source["id"],
        name: source["name"],
      );
}
