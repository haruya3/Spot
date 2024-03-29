# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/heartcombo/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
    def facebook
      callback_from :facebook
    end

    def line
      logger.debug request.env['omniauth.auth']
      callback_from :line
    end
  
    private
    def callback_from(provider)
      provider = provider.to_s
  
      @user = User.find_for_oauth(request.env['omniauth.auth'])
      if @user.persisted?
        flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
        sign_in_and_redirect @user, event: :authentication
        #sign_in(:user, @user)
      else
        #不具合がFacebookとの間にあった場合。だって、persistedがfalseになることは基本ない。保存もされるし、削除もされていないことが圧倒的。
        session["devise.#{provider}_data"] = request.env['omniauth.auth']
        redirect_to new_user_registration_url
      end

      def failure
        redirect_to root_path
      end
    end
  

end
