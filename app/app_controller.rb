class AppController < UIViewController
  def viewDidLoad
    self.init_views
  end

  def init_views
    view.backgroundColor = UIColor.whiteColor

    @header = UILabel.alloc.initWithFrame([[0, 0], [0, 0]])
    @header.textColor = UIColor.blackColor
    @header.font = UIFont.systemFontOfSize(30)
    @header.backgroundColor = UIColor.whiteColor

    @header.text = "The Octodex!"
    @header.sizeToFit
    @header.center = [160, 25]

    @title = UILabel.alloc.initWithFrame([[0, 0], [0, 0]])
    @title.textColor = UIColor.blackColor
    @title.font = UIFont.systemFontOfSize(30)
    @title.backgroundColor = UIColor.whiteColor

    @image = UIImage.imageNamed("octocats/heisencat.png")

    @image_view = UIImageView.alloc.initWithImage(@image)
    @image_view.contentMode = UIViewContentModeScaleAspectFit

    top = 30 + ((view.frame.size.height - view.frame.size.width) / 2.0)
    @image_view.frame = CGRectMake(0, top , view.frame.size.width-6, view.frame.size.width-6)

    show_title("The Heisencat")
    view.addSubview(@image_view)
    view.addSubview(@header)
    view.addSubview(@title)
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

  def motionEnded(motion, withEvent:event)
    puts "ZOMG GIMME MOAR"
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
