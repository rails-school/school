class JobPost < ActiveRecord::Base
  belongs_to :school

  scope :active, -> { where("? BETWEEN starts_at AND ends_at", Time.now) }

  def href
    if self.url.present?
      self.url
    else
      Rails.application.routes.url_helpers.job_post_path(self)
    end
  end
end
