module ApplicationHelper
  def full_title page_title = ""
    base_title = t ".rubyonrails"
    page_title.empty? ? base_title : page_title << " | " << base_title
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def gravatar_for user, options = {size: Settings.size_gravatar}
    gravatar_id = Digest::MD5::hexdigest user.email.downcase
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag gravatar_url, alt: user.name, class: "gravatar"
  end
end
