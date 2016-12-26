class CustomPublicExceptions < ActionDispatch::PublicExceptions

  def call(env)
    status      = env["PATH_INFO"][1..-1]

    if "404" == status
      # handle just 404 in our routes
      MountainLion::Application.routes.call env
    else
      super env
    end
  end
end
