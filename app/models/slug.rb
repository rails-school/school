class Slug
  def initialize(text)
    @text = text
  end

  def generate
    slug = "#{@text}"
    slug.gsub! /['`]/,""
    slug.gsub! /\s*@\s*/, " at "
    slug.gsub! /\s*&\s*/, " and "
    slug.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '_'
    slug.gsub! /_+/,"_"
    slug.gsub! /\A[_\.]+|[_\.]+\z/,""
    slug.downcase!
  end
end
