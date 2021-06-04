abstract class QuickReplyItem {
  final String title;
  final String? payload;
  final String? url;

  const QuickReplyItem({required this.title, this.payload, this.url});
}