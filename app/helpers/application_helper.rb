module ApplicationHelper
    def markdown(text)
        @@markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, 
          autolink: true, tables: true, fenced_code_blocks: true)
        @@markdown.render(text).html_safe
    end
end
