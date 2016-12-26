class UserMailer < Devise::Mailer
 def headers_for(action)
    headers = {
      :subject       => translate(devise_mapping, action),
      :from          => mailer_sender(devise_mapping),
      :to            => resource.email,
      :cc            => "stevenkolstad@gmail.com",
      :template_path => template_paths
    }
  end
end
