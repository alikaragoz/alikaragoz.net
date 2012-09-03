atom_feed :language => 'en-US' do |feed|
  feed.title("Photography by Ali Karagoz")
  feed.updated(@posts.first.created_at)

  @posts.each do |post|
    feed.entry(post) do |entry|
      entry.title(post.title)
      entry.content(atomed_post(post.body, 750), :type => "html")
      entry.author { |author| author.name("Ali Karagoz") }
    end
  end
end