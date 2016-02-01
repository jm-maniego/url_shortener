class Link < ActiveRecord::Base
  after_create :generate_slug
  def generate_slug
    self.slug = id.to_s(36)
    save!
  end
end
