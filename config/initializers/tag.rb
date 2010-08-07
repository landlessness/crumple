module ActsAsTaggableOn
  class Tag
    def viz_html_node_name
      "tag: <strong>#{self.name}</strong>"
    end
    def viz_node_name
      "tag: #{self.name}"
    end
    def viz_node_value
      self.class.name + '_' + self.name
    end
  end
end