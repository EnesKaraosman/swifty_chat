import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../chat.dart';
import '../extensions/theme_context.dart';
import '../models/carousel_item.dart';
import '../models/message.dart';
import '../protocols/has_avatar.dart';

@immutable
final class CarouselWidget extends StatelessWidget with HasAvatar {
  const CarouselWidget(this.chatMessage, {super.key});

  final Message chatMessage;

  List<CarouselItem> get items => message.messageKind.carouselItems;

  @override
  Message get message => chatMessage;

  @override
  Widget build(BuildContext context) => Semantics(
        label: 'Carousel with ${items.length} items',
        child: SizedBox(
          height: _carouselItemHeight(context),
          child: LayoutBuilder(
            builder: (context, constraints) => CarouselView.builder(
              itemExtent: constraints.maxWidth * 0.8,
              itemCount: items.length,
              itemSnapping: true,
              padding: EdgeInsets.zero,
              itemBuilder: (_, index) => _CarouselItem(
                item: items[index],
                index: index,
                total: items.length,
              ),
            ),
          ),
        ),
      );

  double _carouselItemHeight(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final height = ChatStateContainer.of(context)
        .messageCellSizeConfigurator
        .carouselCellMaxHeightConfiguration(screenHeight);
    return height;
  }
}

final class _CarouselItem extends StatelessWidget {
  const _CarouselItem({
    required this.item,
    required this.index,
    required this.total,
  });

  final CarouselItem item;
  final int index;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Carousel item ${index + 1} of $total: ${item.title}',
      child: Container(
        decoration: context.theme.carouselBoxDecoration,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (item.imageProvider != null)
              Flexible(
                child: LayoutBuilder(
                  builder: (context, constraints) => Image(
                    image: ResizeImage.resizeIfNeeded(
                      math.max(
                        1,
                        (constraints.maxWidth *
                                MediaQuery.devicePixelRatioOf(context))
                            .ceil(),
                      ),
                      null,
                      item.imageProvider!,
                    ),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Colors.grey[200],
                        child: Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.broken_image,
                              size: 48,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Failed to load image',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.all(context.theme.textMessagePadding),
              child: Text(
                item.title,
                style: context.theme.carouselTitleTextStyle,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(context.theme.textMessagePadding),
              child: Text(
                item.subtitle,
                style: context.theme.carouselSubtitleTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Wrap(
                children: item.buttons
                    .map(
                      (button) => Semantics(
                        button: true,
                        label: 'Carousel button: ${button.title}',
                        child: ElevatedButton(
                          onPressed: () => ChatStateContainer.of(context)
                              .onCarouselButtonItemPressed
                              ?.call(button),
                          style: context.theme.carouselButtonStyle,
                          child: Text(button.title),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
