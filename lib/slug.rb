class Slug
  def initialize(text)
    @text = text
  end

  def generate
    @text.downcase.gsub(/[^a-z0-9]+/, ' ').strip.gsub(' ', '-')
  end
end
