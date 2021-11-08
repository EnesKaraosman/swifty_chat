# swifty_chat

### Theming

Visit `ChatTheme` [abstract class file](lib/src/theme/chat_theme.dart). 

* `Color primaryColor`: Used as a background of outgoing messages
* `Color secondaryColor`: Used as a background of incoming messages
* `EdgeInsets messageInset` Can be used to have padding between messages
* `Color backgroundColor`: Used as a background color of a chat widget

#### Text Message Widget
* `double textMessagePadding`
* `TextStyle incomingMessageBodyTextStyle`
* `TextStyle outgoingMessageBodyTextStyle`

#### Carousel Message Widget
* `BoxDecoration carouselBoxDecoration`
* `TextStyle carouselTitleTextStyle`
* `TextStyle carouselSubtitleTextStyle`
* `ButtonStyle carouselButtonStyle`

#### Image Message Widget
* `BorderRadius imageBorderRadius`

#### Quick Reply Message Widget
* `ButtonStyle quickReplyButtonStyle`

#### HTML Message Widget
* `Color htmlTextColor`: Color on p, h1, h2, h3, h4, h5 elements.
* `String? htmlTextFontFamily`: FontFamily on p, h1, h2, h3, h4, h5 elements.