class Link < ActiveRecord::Base
  after_create :generate_slug
  def fake_id
    id && (id + 1_000_000)
  end

  def generate_slug
    self.slug = fake_id.to_s(36)
    save!
  end
end
