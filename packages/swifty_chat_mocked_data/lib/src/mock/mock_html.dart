const htmlDataMockLinkPayload = 'https://github.com/EnesKaraosman';
const htmlDataMockLinkTitle = 'websites';
final htmlData = """
<p id='top'><a href='#bottom'>Scroll to bottom</a></p>
      <h1>Header 1</h1>
      <h3>Header 3</h3>
      <h5>Header 5</h5>
      <p>The should be <span style='background-color: red; color: rgb(0, 97, 0);'>GREEN style='color: rgb(0, 97, 0);</span></p>
      <p>
        Linking to <a href='$htmlDataMockLinkPayload'>$htmlDataMockLinkTitle</a> has never been easier.
      </p>
      <h3>Image support:</h3>
      <h3>Network png</h3>
      
      <p id='bottom'><a href='#top'>Scroll to top</a></p>
""";