class CodewarsRecorder
  include Sidekiq::Worker
  include HTTParty

  def perform(user_id, codewars_username)
    user = User.includes(:codewars).find(user_id)
    codewars = HTTParty.get("http://www.codewars.com/api/v1/users/#{codewars_username}/code-challenges/completed")['data']
    codewars.each do |codewar|
      codewar["completedLanguages"].each do |language|
        unless user.codewars.where(:slug=>codewar["slug"], :language=> language).present?
          user.codewars.create(:slug => codewar["slug"], :language => language)
        end
      end
    end
  end
end
