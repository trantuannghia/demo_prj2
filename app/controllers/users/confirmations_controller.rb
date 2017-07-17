class Users::ConfirmationsController < Devise::ConfirmationsController

  protected

  def after_confirmation_path_for resource_name, resource
    super resource_name, resource
  end
end
