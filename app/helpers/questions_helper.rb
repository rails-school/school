module QuestionsHelper
  def answer_list_item(form, answer)
    options = {:checked => false}
    content_tag :li do
      form.radio_button(:id, answer.id, options) +
      answer.text
    end
  end
end
