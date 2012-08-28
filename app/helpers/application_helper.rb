module ApplicationHelper

  def markdown(text)
    parser_options = {
      :autolink => true,
      :space_after_headers => true,
      :no_intra_emphasis => true,
    }
    renderer_options = {
      :hard_wrap => true #render line breaks
    }
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(renderer_options), parser_options)
    markdown.render(text).html_safe
  end

  def authenticated?
    if session[:logged_in]
      return true
    else
      return false
    end
  end

  # Detect if we are on the current page
  def is_current(page)
    if controller.controller_name == page
      'class=current'
    end
  end

  # Capitalize the first letter and let the others unchanged
  def capit(string)
    string.slice(0,1).capitalize + string.slice(1..-1)
  end

end
