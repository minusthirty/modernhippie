module ApplicationHelper
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.simple_fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, '#{association}', '#{escape_javascript(fields)}')")
  end
  
  
  def pinterest_url_for(post)
    url = "http://pinterest.com/pin/create/button/"
    url << "?url=#{post_url(post)}"
    url << "&media=#{post.cover_image.url(:large)}"
    url << "&description=#{post.summary}"
    url
  end
  
  def facebook_url_for(post)
    "https://www.facebook.com/sharer/sharer.php?u=#{CGI.escape(post_url(post))}"
  end
  
  def twitter_url_for(post)
    url = "https://twitter.com/intent/tweet"
    url = "?source=webclient"
    url << "&text=#{post.title} #{CGI.escape(post_url(post))} ##{post.category.name}"
    url
  end
end
