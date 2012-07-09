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
    return if @connection
    request = NSURLRequest.requestWithURL(NSURL.URLWithString("http://feeds.feedburner.com/Octocats"))
    @connection = NSURLConnection.alloc.initWithRequest(request, delegate:self)
  end

  # NSURLRequestDelegate methods.
  def connection(connection, didReceiveResponse:response)
    @data = NSMutableData.alloc.init
  end

  def connection(connection, didReceiveData:data)
    @data.appendData(data)
  end

  def connectionDidFinishLoading(connection)
    parser = NSXMLParser.alloc.initWithData(@data)

    @data = nil
    @connection = nil

    @parseError = nil

    parser.delegate = self
    parser.parse

    if @parserError
      puts "parse error"
    else
      puts "parsed successfully"
    end
  end

  def connection(connection, didFailWithError:error)
    @connection = nil
    @data = nil
  end

  def new_octocat
    @new_octocat ||= Octocat.new
  end

  # NSXMLParserDelegate methods.
  def parser(parser, didStartElement:elementName, namespaceURI:namespaceURI, qualifiedName:qualifiedName, attributes:attributes)
    if image_src = attributes['src']
      new_octocat.image_url = image_src unless image_src =~ /gravatar/
    end
  end

  def parser(parser, foundCharacters:string)
    @text += string if @text
  end

  def parser(parser, didEndElement:elementName, namespaceURI:namespaceURI, qualifiedName:qName)
    case elementName
    when "entry"
      @octocats << new_octocat
      @new_octocat = nil
      @text = nil
    when "title"
      new_octocat.title = @text
    when "div", "content", "p", "a", "img", "div", "updated", "strong", "link", "id", "feed"
      # NOOOP
      @text = nil
    else
      puts "Unknown value for #{elementName}"
      @text = nil
    end
  end

  def parser(parser, parseErrorOccurred:error)
    @parseError = error
  end
end
