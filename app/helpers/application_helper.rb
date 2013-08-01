module ApplicationHelper

  def hull_config
    ret = { 
      orgUrl: Hull.org_url, 
      appId: Hull.app_id, 
      debug: Rails.env.development?,
      jsUrl: 'https://d3f5pyioow99x0.cloudfront.net'
    }
    if current_user
      ret[:userHash] = Hull.user_hash({ 
        id: current_user.id, 
        email: current_user.email, 
        name: current_user.name,
        picture: current_user.picture
      })
    end
    ret
  end

  def hull_init
    <<-HULL_INIT
    <script src="https://d3f5pyioow99x0.cloudfront.net/develop/hull.js"></script>
    <script>Hull.init(#{hull_config.to_json});</script>
    HULL_INIT
  end

  def hello
    "Hello #{current_user ? current_user.email : "anynomous user"}"
  end

end
