const htmlData = """
<p id='top'><a href='#bottom'>Scroll to bottom</a></p>
      <h1>Header 1</h1>
      <h2>Header 2</h2>
      <h3>Header 3</h3>
      <h4>Header 4</h4>
      <h5>Header 5</h5>
      <h6>Header 6</h6>
      <h3>Ruby Support:</h3>
      <h3>Support for maxLines:</h3>
      <h5>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec vestibulum sapien feugiat lorem tempor, id porta orci elementum. Fusce sed justo id arcu egestas congue. Fusce tincidunt lacus ipsum, in imperdiet felis ultricies eu. In ullamcorper risus felis, ac maximus dui bibendum vel. Integer ligula tortor, facilisis eu mauris ut, ultrices hendrerit ex. Donec scelerisque massa consequat, eleifend mauris eu, mollis dui. Donec placerat augue tortor, et tincidunt quam tempus non. Quisque sagittis enim nisi, eu condimentum lacus egestas ac. Nam facilisis luctus ipsum, at aliquam urna fermentum a. Quisque tortor dui, faucibus in ante eget, pellentesque mattis nibh. In augue dolor, euismod vitae eleifend nec, tempus vel urna. Donec vitae augue accumsan ligula fringilla ultrices et vel ex.</h5>
      <h3>Support for <code>sub</code>/<code>sup</code></h3>
      Solve for <var>x<sub>n</sub></var>: log<sub>2</sub>(<var>x</var><sup>2</sup>+<var>n</var>) = 9<sup>3</sup>
      <p>One of the most <span>common</span> equations in all of physics is <br /><var>E</var>=<var>m</var><var>c</var><sup>2</sup>.</p>
      <h3>Inline Styles:</h3>
      <p>The should be <span style='background-color: red; color: rgb(0, 97, 0);'>GREEN style='color: rgb(0, 97, 0);</span></p>
      <h3>Table support (with custom styling!):</h3>
      <p>
      <q>Famous quote...</q>
      </p>
      <h3>Custom Element Support (inline: <bird></bird> and as block):</h3>
      <flutter></flutter>
      <flutter horizontal></flutter>
      <p>
        Linking to <a href='https://github.com'>websites</a> has never been easier.
      </p>
      <h3>Image support:</h3>
      <h3>Network png</h3>
      <img alt='Google' src='https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png' />
      <h3>Network svg</h3>
      <img src='https://dev.w3.org/SVG/tools/svgweb/samples/svg-files/android.svg' />
      <p id='bottom'><a href='#top'>Scroll to top</a></p>
""";