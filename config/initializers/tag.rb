module ActsAsTaggableOn
  class Tag
    include ActsAsVisualizable
    def viz_node_name
      "tag: <strong>#{self.name}</strong>"
    end
  end
end