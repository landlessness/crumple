module ActsAsTaggableOn
  class Tag
    include ActsAsVisualizable
    def viz_group
      1
    end
  end
end