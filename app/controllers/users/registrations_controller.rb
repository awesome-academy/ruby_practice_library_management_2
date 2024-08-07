class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      if resource.persisted?
        handle_success resource
      else
        handle_failure resource
      end
      return
    end
  end

  private

  def handle_success resource
    set_flash_message!(:notice, :signed_up)
    respond_with resource, location: after_sign_up_path_for(resource)
  end

  def handle_failure resource
    respond_with resource
  end
end
