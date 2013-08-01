require 'base64'

module HullEntity

  extend ActiveSupport::Concern

  included do 
    after_save do
      # We probably want to do this asynchronously...
      save_entity
    end

    after_create do
      # We probably want to do this asynchronously...
      publish_activity
    end
  end

  def entity_uid
    [self.class.name.underscore, self.id].join("/")
  end

  def entity_encoded_uid
    "~#{Base64.urlsafe_encode64(entity_uid)}"
  end

  def save_entity
    Hull.put('entity', { 
      uid: entity_uid, 
      name: self.title, 
      description: self.content,
      object_type: self.class.name.underscore,
      extra: { foo: "BAR", created_by: self.user.id }
    })
  end

  def get_entity rel=nil
    path = ['entity', rel].compact.join("/")
    Hull.get(path, uid: entity_uid)
  end

  def publish_activity
    user_uid = "external:#{self.user.id}"
    Hull.as(user_uid).post("#{entity_encoded_uid}/activity", { verb: "create" })
  end

end