class Link < ActiveRecord::Base
  validate :given_url_should_be_a_valid_url
  after_create :generate_slug
  def fake_id
    id && (id + 1_000_000)
  end

  def generate_slug
    self.slug = fake_id.to_s(36)
    save!
  end

  private

  def given_url_should_be_a_valid_url
    uri = URI.parse(given_url)
    unless uri.kind_of?(URI::HTTP) && uri.host.present?
      errors.add(:given_url, "should be a valid URL")
    end
  end
end
