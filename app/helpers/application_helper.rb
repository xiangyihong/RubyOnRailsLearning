module ApplicationHelper
  
  def full_title(title)
    base_title = 'Ruby on Rails Learning'
    if title
      "#{title} | #{base_title}"
    else
      base_title
    end
  end
      
end
