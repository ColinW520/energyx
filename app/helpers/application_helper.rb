module ApplicationHelper
  def self.line_break(s)
    s.gsub("\n", '<br/>')
  end
end
