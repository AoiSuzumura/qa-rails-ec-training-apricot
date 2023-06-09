module ApplicationHelper
  def full_title(title = "")
    default_title = "Myapp"
    if title.blank?
      default_title
    else
      "#{title}"
    end
  end
end
