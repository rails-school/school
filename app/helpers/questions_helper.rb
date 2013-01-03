module QuestionsHelper
  def answer_list_item(form, answer)
    content_tag :li do
      form.radio_button(:id, answer.id) +
      answer.text
    end
  end
end
