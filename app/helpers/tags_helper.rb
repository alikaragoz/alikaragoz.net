module TagsHelper
  
  # Get the number of images in the named category (id)
	def image_count tag
    if authenticated?
      tag.posts.count.to_s
    else
      tag.posts.where(:status => :true).count.to_s
    end
	end
  
  # Generated something like that : <li><a href="/tags/all">All</a><span>299</span></li>
	def category_li name
		@tag = Tag.where(:name => name).first
    if @tag
      ('<li><a href="/tags/' + @tag.slug + '">' + @tag.name + '</a><span>' + image_count(@tag) + '</span></li>').html_safe
    end
	end
  
end