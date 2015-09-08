class SessionsController < Devise::SessionsController
  respond_to :html,:json
  
  layout "form"
  
  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)


    respond_to do |format|
      format.html {
       redirect_to :root
      }
      
      format.json {
        render :json => {
          :user => current_user,
          :status => :ok,
          :authentication_token => current_user.authentication_token
        }
      }
    end
   end

   # DELETE /resource/sign_out
   def destroy

    respond_to do |format|
       format.html {
          if current_user
             current_user.update authentication_token: nil
             signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
             redirect_to :root, :notice => "Successfully signed out"
           else
             redirect_to :back, :notice => "Couldn't sign out"
           end
        }
      format.json {
        if current_user
          current_user.update authentication_token: nil
          signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
          render :json => {}.to_json, :status => :ok
        else
          render :json => {}.to_json, :status => :unprocessable_entity
        end


      }
    end
   end
  
  
  
end