module ApplicationHelper
  def twitterized_type(type)
    case type
      when :alert
        "alert alert-warning"
      when :error
        "alert alert-danger"
      when :notice
        "alert alert-info"
      when :success
        "alert alert-success"
      else
        "alert alert-info"
    end
  end
end
