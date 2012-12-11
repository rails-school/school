module FaqHelper

  def faq_item_question(question)
    fragment = question.gsub(/[^a-zA-Z0-9 ]+/, '').camelize.tr(' ', '_')
    link_to content_tag(:h2, question), "##{fragment}", :id => fragment
  end

end
