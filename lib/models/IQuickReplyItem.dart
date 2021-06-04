abstract class IQuickReplyItem {
  final String title;
  final String? payload;
  final String? url;

  const IQuickReplyItem({required this.title, this.payload, this.url});
}