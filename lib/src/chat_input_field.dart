import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'extensions/keys.dart';

/// Configuration for the chat input field appearance
@immutable
final class ChatInputFieldConfig {
  const ChatInputFieldConfig({
    this.backgroundColor,
    this.textColor,
    this.hintColor,
    this.sendButtonColor,
    this.sendButtonIconColor,
    this.borderRadius = 24.0,
    this.elevation = 4.0,
    this.hintText = 'Write your message...',
    this.minHeight = 56.0,
    this.maxHeight = 120.0,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 12,
    ),
  });

  /// Background color of the input field container
  /// Defaults to theme's surfaceContainerHighest
  final Color? backgroundColor;

  /// Color of the input text
  /// Defaults to theme's onSurface
  final Color? textColor;

  /// Color of the hint text
  /// Defaults to theme's onSurfaceVariant
  final Color? hintColor;

  /// Color of the send button
  /// Defaults to theme's primary
  final Color? sendButtonColor;

  /// Color of the send button icon
  /// Defaults to theme's onPrimary
  final Color? sendButtonIconColor;

  /// Border radius of the input field
  final double borderRadius;

  /// Elevation/shadow of the input container
  final double elevation;

  /// Placeholder text
  final String hintText;

  /// Minimum height of the input field
  final double minHeight;

  /// Maximum height when multiline
  final double maxHeight;

  /// Padding inside the text field
  final EdgeInsets contentPadding;
}

/// A modern, Material 3 compatible chat input field with dark mode support
@immutable
final class MessageInputField extends StatefulWidget {
  const MessageInputField({
    required this.sendButtonTapped,
    this.config = const ChatInputFieldConfig(),
    this.onAttachmentTapped,
    this.showAttachmentButton = false,
    this.enabled = true,
    super.key,
  });

  /// Callback when send button is tapped
  final Function(String) sendButtonTapped;

  /// Optional callback for attachment button
  final VoidCallback? onAttachmentTapped;

  /// Whether to show the attachment button
  final bool showAttachmentButton;

  /// Configuration for appearance customization
  final ChatInputFieldConfig config;

  /// Whether the input field is enabled
  final bool enabled;

  @override
  State<MessageInputField> createState() => _MessageInputFieldState();
}

final class _MessageInputFieldState extends State<MessageInputField>
    with SingleTickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  late AnimationController _sendButtonController;
  late Animation<double> _sendButtonScale;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _textController.addListener(_onTextChanged);
    _sendButtonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _sendButtonScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _sendButtonController,
        curve: Curves.easeOutBack,
      ),
    );
  }

  @override
  void dispose() {
    _textController.removeListener(_onTextChanged);
    _textController.dispose();
    _focusNode.dispose();
    _sendButtonController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = _textController.text.trim().isNotEmpty;
    if (hasText != _hasText) {
      setState(() => _hasText = hasText);
      if (hasText) {
        _sendButtonController.forward();
      } else {
        _sendButtonController.reverse();
      }
    }
  }

  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    HapticFeedback.lightImpact();
    widget.sendButtonTapped(text);
    _textController.clear();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final config = widget.config;

    // Resolve colors with theme defaults
    final backgroundColor =
        config.backgroundColor ?? colorScheme.surfaceContainerHighest;
    final textColor = config.textColor ?? colorScheme.onSurface;
    final hintColor = config.hintColor ?? colorScheme.onSurfaceVariant;
    final sendButtonColor = config.sendButtonColor ?? colorScheme.primary;
    final sendButtonIconColor =
        config.sendButtonIconColor ?? colorScheme.onPrimary;

    return Semantics(
      container: true,
      label: 'Message input area',
      child: Material(
        color: backgroundColor,
        elevation: config.elevation,
        shadowColor: colorScheme.shadow.withValues(alpha: .3),
        child: SafeArea(
          top: false,
          child: Container(
            constraints: BoxConstraints(
              minHeight: config.minHeight,
              maxHeight: config.maxHeight,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Attachment button (optional)
                if (widget.showAttachmentButton) ...[
                  _IconButton(
                    icon: Icons.add_circle_outline,
                    color: hintColor,
                    onTap: widget.enabled ? widget.onAttachmentTapped : null,
                    semanticLabel: 'Add attachment',
                  ),
                  const SizedBox(width: 4),
                ],

                // Text input field
                Expanded(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(config.borderRadius),
                      border: Border.all(
                        color: _focusNode.hasFocus
                            ? colorScheme.primary.withValues(alpha: .5)
                            : colorScheme.outlineVariant.withValues(alpha: .5),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Semantics(
                            textField: true,
                            label: 'Type your message',
                            child: TextField(
                              key: ChatKeys.messageTextField.key,
                              controller: _textController,
                              focusNode: _focusNode,
                              enabled: widget.enabled,
                              textCapitalization: TextCapitalization.sentences,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.newline,
                              maxLines: null,
                              minLines: 1,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: textColor,
                              ),
                              decoration: InputDecoration(
                                hintText: config.hintText,
                                hintStyle: TextStyle(
                                  fontSize: 16.0,
                                  color: hintColor,
                                ),
                                border: InputBorder.none,
                                contentPadding: config.contentPadding,
                                isDense: true,
                              ),
                              onSubmitted: (_) => _sendMessage(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                // Send button with animation
                AnimatedBuilder(
                  animation: _sendButtonScale,
                  builder: (context, child) {
                    final scaleValue = _sendButtonScale.value.clamp(0.0, 1.0);
                    return Transform.scale(
                      scale: 0.8 + (scaleValue * 0.2),
                      child: Opacity(
                        opacity: 0.5 + (scaleValue * 0.5),
                        child: child,
                      ),
                    );
                  },
                  child: Semantics(
                    button: true,
                    label: 'Send message',
                    enabled: _hasText && widget.enabled,
                    child: GestureDetector(
                      key: ChatKeys.messageSendButton.key,
                      onTap: _hasText && widget.enabled ? _sendMessage : null,
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _hasText
                              ? sendButtonColor
                              : sendButtonColor.withValues(alpha: .5),
                          boxShadow: _hasText
                              ? [
                                  BoxShadow(
                                    color:
                                        sendButtonColor.withValues(alpha: .3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : null,
                        ),
                        child: Icon(
                          Icons.send_rounded,
                          color: sendButtonIconColor,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({
    required this.icon,
    required this.color,
    this.onTap,
    this.size = 24,
    this.semanticLabel,
  });

  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
  final double size;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(icon, color: color, size: size),
        ),
      ),
    );
  }
}
