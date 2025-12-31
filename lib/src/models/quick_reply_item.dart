/// Represents a quick reply option
abstract class QuickReplyItem {
  const QuickReplyItem({
    required this.title,
    this.payload,
    this.url,
  });

  /// Display text of the quick reply button
  final String title;

  /// Optional payload data for the quick reply action
  final String? payload;

  /// Optional URL to open when quick reply is tapped
  final String? url;
}
