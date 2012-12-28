module QuestionsHelper
  def answer_list_item(form, answer)
      content_tag :li,
        "#{form.radio_button(:id, answer.id)} #{answer.text}".html_safe
  end
end
