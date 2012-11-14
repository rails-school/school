module Slug
  def self.generate(text)
    slug = "#{text}"
    slug.gsub! /['`]/,""
    slug.gsub! /\s*@\s*/, " at "
    slug.gsub! /\s*&\s*/, " and "
    slug.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '_'
    slug.gsub! /_+/,"_"
    slug.gsub! /\A[_\.]+|[_\.]+\z/,""
    slug.downcase!
    slug
  end
end
