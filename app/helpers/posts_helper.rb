module PostsHelper
  # Method that lists the tags of a post
  def post_tags_html post
    tags = post.tags.order 'name'
    links = []
    
    tags.each do |tag|
      links << link_to(tag.name, tag, :class => 'tag')
    end
    ("In "+links.to_sentence).html_safe
  end
  
  # Method that gets the tumbnail of the first image of a post
  def get_thumbnail post
    
    # First we need to get the image having the thumb mark
    thumb = nil
    
    # We look for image having a title ![title](/assets/etc...)
    images = post.body.scan(/!\[(.*?)\]\(.*/)
    images.each { |mark|
      if mark[0] != ''
        thumb = mark[0]
        break
      end
    }
  
    # If there is a mark one of the photos we choose this one (the first one)
    # For instance:
    # ![mark](/photos/photo-1.jpg) <- This one will be chosed for thumbnail
    # ![](/photos/photo-1.jpg)

    if thumb == nil
      string = post.body
      
    # Else we pick the first image
    else
      string = post.body.match(/\!\[#{thumb}\]\(.*[^\/]+.jpg\)/)
    end
    
    first_image = string.to_s.match(/([^\/]+\.jpg)/)
    thumbnail = first_image.to_s.sub(/^.*\\|\..*$/, "_thumbnail.jpg")
      
    # We return the needed string
    "/thumbnails/#{thumbnail}"

  end

  def post_published_time post
    post.created_at.strftime('%B %e, %Y')
  end

  def image_number post
    string = post.body
    images = string.to_s.scan(/([^\/]+\.jpg)/)
    images.count
  end

  def edit_link post
    (" " + link_to('(Edit)', edit_post_path(post))).html_safe if authenticated?
  end
  
  # Displaying the atom images in a different size
  def atomed_post(text, width)
    markdown(text).gsub( "<img", "<img width=\"#{width}\"")
  end
end
