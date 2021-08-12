# to test: run command rubocop --auto-gen-config  spec/system/buyer_creates_rfp_spec.rb --only DescribeContext
class DescribeContext < RuboCop::Cop::Cop
  def_node_search :context_block, <<~PATTERN
    (send nil? :context (:str _)...)
  PATTERN

  MSG = "Context block should appear nested within describe block.".freeze

  def on_send(node)
    context_block(node) do |current|
      next unless current.block_node.to_s.include?("describe")
      add_offense(node)
    end
  end
end

