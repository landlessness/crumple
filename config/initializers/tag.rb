module ActsAsTaggableOn
  class Tag
    include ActsAsVisualizable
    def viz_node_name
      self.name
    end
  end
end