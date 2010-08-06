module ActsAsVisualizable
  def viz_node_value
    self.class.name + '_' + self.id.to_s
  end
end