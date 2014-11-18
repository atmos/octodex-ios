class Feed
  def initialize
    o=Octocat.new
    o.title = "The Original"
    o.image_url = "http://octodex.github.com/images/original.jpg"
    @octocats = [o]
    self.update
  end

  def octocats
    @octocats
  end

  def random_octocat
    octocats[rand(octocats.size)]
  end

  def update
    feed_parser = BW::RSSParser.new("https://feeds.feedburner.com/Octocats")
    feed_parser.delegate = self
    feed_parser.parse do |item|
      octocat = Octocat.new
      octocat.title     = item.title
      octocat.image_url = item.link

      octocats << octocat
    end
  end

  # Delegate methods
  def when_parser_initializes
    #p "The parser is ready!"
  end

  def when_parser_parses
    @octocats = []
  end

  def when_parser_is_done
    p 'Should disable loading page?'
  end
end
