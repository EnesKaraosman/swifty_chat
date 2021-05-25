abstract class IQuickReplyItem {
  String title;
  String? payload;
  String? url;

  IQuickReplyItem({required this.title, this.payload, this.url});
}