class CodewarsRecorder
  include Sidekiq::Worker
  include HTTParty

  def perform(user_id, codewars_username)
    user = User.includes(:codewars).find(user_id)
    user_codewar_slugs = user.codewars.map(&:slug)
    codewars = HTTParty.get("http://www.codewars.com/api/v1/users/#{codewars_username}/code-challenges/completed")['data']
    codewars.each do |codewar|
      unless user_codewar_slugs.include?(codewar["slug"])
        user.codewars.create(:slug => codewar["slug"])
      end
    end
  end
end
