class SearchService
  def self.search(search)
    posts = Post.where(created_at: 24.hours.ago..)
    if search != ""
      posts.where("text LIKE(?)", "%#{search}%").order("created_at DESC")
    else
      posts.all.order("created_at DESC")
    end
  end
end