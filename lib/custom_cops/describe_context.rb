class DescribeContext < RuboCop::Cop::Cop
  def_node_search :context_block, <<~PATTERN
    (send nil? :context (:str _)...)
  PATTERN

  MSG = "Context should appear nested within Describe block.".freeze

  def on_block(node)
    context_block(node).each do |current|
      pp current.to_s
    end
  end
end
