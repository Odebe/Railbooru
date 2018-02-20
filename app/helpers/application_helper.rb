module ApplicationHelper

  def second_nav_bar_for(controller_name)
    synonyms = {
      "sessions" => "users",
      "passwords" => "users",
      "registrations" => "users"
    }
    new_name = synonyms.has_key?(controller_name) ? synonyms[controller_name] : controller_name
    return "#{new_name}/nav_bar"
  end
  
  def active_link_for(controller, button_name)
    
  end

end
