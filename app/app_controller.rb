class AppController < UIViewController
  def viewDidLoad
    self.init_views
    self.feed
  end

  def init_views
    view.backgroundColor = UIColor.whiteColor

    @header = UILabel.alloc.initWithFrame([[0, 0], [0, 0]])
    @header.textColor = UIColor.blackColor
    @header.font = UIFont.systemFontOfSize(30)
    @header.backgroundColor = UIColor.whiteColor

    @header.text = "The Octodex!"
    @header.sizeToFit
    @header.center = [160, 40]

    @title = UILabel.alloc.initWithFrame([[0, 0], [0, 0]])
    @title.textColor = UIColor.blackColor
    @title.font = UIFont.systemFontOfSize(30)
    @title.backgroundColor = UIColor.whiteColor

    @image_view = UIImageView.alloc.initWithImage(@image)
    @image_view.contentMode = UIViewContentModeScaleAspectFit

    top = 20 + ((view.frame.size.height - view.frame.size.width) / 2.0)
    @image_view.frame = CGRectMake(0, top, view.frame.size.width, view.frame.size.width-6)

    view.addSubview(@image_view)
    view.addSubview(@header)
    view.addSubview(@title)

    previousGesture = UISwipeGestureRecognizer.alloc.initWithTarget(self, action:'swipePreviousGesture:')
    previousGesture.direction = UISwipeGestureRecognizerDirectionLeft
    view.addGestureRecognizer(previousGesture)
    nextGesture = UISwipeGestureRecognizer.alloc.initWithTarget(self, action:'swipeNextGesture:')
    nextGesture.direction = UISwipeGestureRecognizerDirectionRight
    view.addGestureRecognizer(nextGesture)
    display_cat(octocats.first)
  end

  def show_title(text)
    @title.text = text
    @title.sizeToFit
    @title.center = [160, view.frame.size.height - 40]
  end

  def wantsFullScreenLayout
    true
  end

  def canBecomeFirstResponder
    true
  end

  def feed
    @feed ||= Feed.new
  end

  def octocats
    feed.octocats
  end

  def octocat
    @octocat
  end

  def display_cat(cat)
    self.image_url = cat.image_url
    show_title(cat.title)
    @octocat = cat
  end

  def random
    display_cat(feed.random_octocat)
  end

  def motionEnded(motion, withEvent:event)
    random
  end

  def swipeNextGesture(gesture)
    idx = octocats.index(octocat)

    if idx == nil
      random
    elsif idx == octocats.size - 1
      display_cat(octocats.first)
    else
      display_cat(octocats[idx + 1])
    end
  end

  def swipePreviousGesture(gesture)
    idx = octocats.index(octocat)

    if idx == nil
      random
    elsif idx == 0
      display_cat(octocats.last)
    else
      display_cat(octocats[idx - 1])
    end
  end

  def image_url=(url)
    image = UIImage.imageWithData(NSData.alloc.initWithContentsOfURL(NSURL.URLWithString(url)))
    @image_view.image = image
  end

  # Enable rotation
  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    # On the iPhone, don't rotate to upside-down portrait orientation
    if UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPad
      if interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown
        return false
      end
    end
    true
  end
end
