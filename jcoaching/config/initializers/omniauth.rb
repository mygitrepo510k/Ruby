Rails.application.config.middleware.use OmniAuth::Builder do
  provider :paypal, "AQgU_xCMkA-Oa7C__ydEmbjfuZd-KfEmXcidmHYFJ6USaigidU56Pyk3nVjT", "EHrlehA6rQh6uohsojsCOaK7qEkops14UY7SsR7nyrWzXz0NiYLfBqfBtvI5", sandbox: false, scope: "openid"
end