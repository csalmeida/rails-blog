module ApplicationHelper

  # Renders all errors tied to a specific to a field.
  # Useful to show an error message next to the field that triggered it.
  # Might be better to move html to its own partial.
  # @param field_name#symbol 
  # @param errors#array
  def render_field_errors(field_name, errors=nil)
    if errors && errors[field_name].size > 0
      messages = ""

      errors.full_messages_for(field_name).each do |error|
        messages += <<-HTML
          <p><span style="color:red;">#{error}</span></p>
        HTML
      end

      return messages.html_safe
    end
  end
end
