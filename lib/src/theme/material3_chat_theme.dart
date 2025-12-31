import 'package:flutter/material.dart';
import 'chat_theme.dart';

/// Material 3 compatible chat theme that integrates with Flutter's ColorScheme
/// and provides semantic color tokens.
///
/// This theme automatically adapts to light/dark mode based on the ColorScheme
/// and follows Material 3 design guidelines.
@immutable
final class Material3ChatTheme extends ChatTheme {
  /// Creates a Material 3 chat theme from a ColorScheme and optional TextTheme.
  ///
  /// If [textTheme] is not provided, it uses the default Material text theme.
  /// The theme automatically adapts based on [colorScheme.brightness].
  const Material3ChatTheme({
    required this.colorScheme,
    this.textTheme,
    this.messageBorderRadiusValue = 20.0,
    this.textMessagePaddingValue = 12.0,
    this.messageInsetValue = const EdgeInsets.symmetric(vertical: 8),
  }) : super();

  /// Factory constructor to create theme from BuildContext
  factory Material3ChatTheme.fromContext(
    BuildContext context, {
    double? messageBorderRadius,
    double? textMessagePadding,
    EdgeInsets? messageInset,
  }) {
    final theme = Theme.of(context);
    return Material3ChatTheme(
      colorScheme: theme.colorScheme,
      textTheme: theme.textTheme,
      messageBorderRadiusValue: messageBorderRadius ?? 20.0,
      textMessagePaddingValue: textMessagePadding ?? 12.0,
      messageInsetValue:
          messageInset ?? const EdgeInsets.symmetric(vertical: 8),
    );
  }

  /// The Material 3 color scheme used for semantic colors
  final ColorScheme colorScheme;

  /// The text theme for typography scale
  final TextTheme? textTheme;

  /// Border radius value for message containers
  final double messageBorderRadiusValue;

  /// Padding value for text messages
  final double textMessagePaddingValue;

  /// Inset value for messages
  final EdgeInsets messageInsetValue;

  @override
  Color get backgroundColor => colorScheme.surface;

  @override
  double get messageBorderRadius => messageBorderRadiusValue;

  @override
  double get textMessagePadding => textMessagePaddingValue;

  @override
  Color get primaryColor => colorScheme.primaryContainer;

  @override
  Color get secondaryColor => colorScheme.secondaryContainer;

  @override
  EdgeInsets get messageInset => messageInsetValue;

  // Typography using Material 3 text theme or fallback to sensible defaults
  TextStyle get _bodyMedium =>
      textTheme?.bodyMedium ??
      const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.5,
      );

  TextStyle get _bodySmall =>
      textTheme?.bodySmall ??
      const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.5,
      );

  TextStyle get _titleMedium =>
      textTheme?.titleMedium ??
      const TextStyle(
        fontSize: 19,
        fontWeight: FontWeight.bold,
      );

  TextStyle get _titleSmall =>
      textTheme?.titleSmall ??
      const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      );

  @override
  TextStyle get incomingMessageBodyTextStyle => _bodyMedium.copyWith(
        color: colorScheme.onSecondaryContainer,
      );

  @override
  TextStyle get outgoingMessageBodyTextStyle => _bodyMedium.copyWith(
        color: colorScheme.onPrimaryContainer,
      );

  @override
  TextStyle get incomingChatTextTime => _bodySmall.copyWith(
        color: colorScheme.onSecondaryContainer.withValues(alpha: .7),
        height: 0.3,
      );

  @override
  TextStyle get outgoingChatTextTime => _bodySmall.copyWith(
        color: colorScheme.onPrimaryContainer.withValues(alpha: .7),
        height: 0.3,
      );

  @override
  TextStyle get htmlWidgetTextTime => _bodySmall.copyWith(
        color: colorScheme.onSurface,
      );

  @override
  TextStyle get imageWidgetTextTime => _bodySmall.copyWith(
        color: colorScheme.onSurface,
      );

  @override
  TextStyle get carouselTitleTextStyle => _titleMedium.copyWith(
        color: colorScheme.onSurface,
      );

  @override
  TextStyle get carouselSubtitleTextStyle => _titleSmall.copyWith(
        color: colorScheme.onSurfaceVariant,
      );

  @override
  ButtonStyle get carouselButtonStyle => FilledButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      );

  @override
  BoxDecoration get carouselBoxDecoration => BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: colorScheme.surfaceContainerHighest,
      );

  @override
  BorderRadius get imageBorderRadius => BorderRadius.circular(16);

  @override
  ButtonStyle get quickReplyButtonStyle => FilledButton.styleFrom(
        backgroundColor: colorScheme.tertiaryContainer,
        foregroundColor: colorScheme.onTertiaryContainer,
      );

  @override
  Color get htmlTextColor => colorScheme.onSurface;

  @override
  String? get htmlTextFontFamily => textTheme?.bodyMedium?.fontFamily;

  /// Creates a copy of this theme with the given fields replaced with new values
  Material3ChatTheme copyWith({
    ColorScheme? colorScheme,
    TextTheme? textTheme,
    double? messageBorderRadius,
    double? textMessagePadding,
    EdgeInsets? messageInset,
  }) {
    return Material3ChatTheme(
      colorScheme: colorScheme ?? this.colorScheme,
      textTheme: textTheme ?? this.textTheme,
      messageBorderRadiusValue: messageBorderRadius ?? messageBorderRadiusValue,
      textMessagePaddingValue: textMessagePadding ?? textMessagePaddingValue,
      messageInsetValue: messageInset ?? messageInsetValue,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Material3ChatTheme &&
        other.colorScheme == colorScheme &&
        other.textTheme == textTheme &&
        other.messageBorderRadiusValue == messageBorderRadiusValue &&
        other.textMessagePaddingValue == textMessagePaddingValue &&
        other.messageInsetValue == messageInsetValue;
  }

  @override
  int get hashCode => Object.hash(
        colorScheme,
        textTheme,
        messageBorderRadiusValue,
        textMessagePaddingValue,
        messageInsetValue,
      );
}
