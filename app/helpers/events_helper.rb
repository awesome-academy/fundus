module EventsHelper
  def render_with_hashtags content
    content.gsub(/#\w+/){|word| link_to word, "/tags/#{word.delete('#')}"}.html_safe
  end
end
