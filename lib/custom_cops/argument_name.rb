class ArgumentName < RuboCop::Cop::Cop
  def_node_matcher :argument_name, <<~PATTERN
    (send nil? :devise (:sym $_) ...)
  PATTERN

  MSG = "Use snake_case for argument names".freeze
  SNAKE_CASE = /^[\da-z_]+[!?=]?$/.freeze

  def on_send(node)
    argument_name(node) do |name|
      next if name.match?(SNAKE_CASE)

      add_offense(node)
    end
  end
end
