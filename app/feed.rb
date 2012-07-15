class Feed
  def initialize
    @octocats = [ ]
    self.update
  end

  def octocats
    @octocats
  end

  def random_octocat
    octocats[rand(octocats.size)]
  end

  def update
    feed_parser = BW::RSSParser.new("http://octodex.herokuapp.com/feed.xml")
    feed_parser.delegate = self
    feed_parser.parse do |item|
      octocat = Octocat.new
      octocat.title     = item.title
      octocat.image_url = item.link

      octocats << octocat
    end
  end

  # Delegate method
  def when_parser_initializes
    p "The parser is ready!"
  end

  def when_parser_parses
    p "The parser started parsing the document"
  end

  def when_parser_is_done
    p "The feed is entirely parsed, congratulations!"
  end
end
