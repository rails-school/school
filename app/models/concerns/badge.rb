require 'delegate'

module Badge
  extend ActiveSupport::Concern

  # We store the different badge types indexed in a couple useful ways
  @including_classes = []
  @including_classes_by_slug = {}
  @including_classes_by_badge_id = {}

  class << self
    # Allow us to call Badge.first, Badge.find, etc. to work with our badge types
    include Enumerable
    delegate :each, to: :@including_classes
  end

  def slug
    self.class.slug
  end

  def display_name
    self.class::DISPLAY_NAME
  end

  def to_param
    slug
  end

  included do
    def self.id
      self::BADGE_ID
    end

    def self.slug
      self::SLUG
    end

    Badge.add_including_class(self)
  end

  def self.all
    @including_classes
  end

  def self.find_by_badge_id(badge_id)
    @including_classes_by_badge_id[badge_id.to_i]
  end

  def self.find_by_slug(slug)
    @including_classes_by_slug[slug.to_s]
  end

  private
  def self.add_including_class(klass)
    # Store this class in our bookkeeping data structures
    @including_classes << klass
    @including_classes_by_slug[klass.slug] = klass
    @including_classes_by_badge_id[klass.id] = klass
  end
end

# Need to load all the sources now in case we want to do anything with
# Badge.included_classes
Dir[Rails.root + 'app/models/badges/*.rb'].each do |path|
  require path
end
