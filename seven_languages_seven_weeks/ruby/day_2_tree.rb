class Tree
  attr_accessor :children, :node_name
  
  def initialize(hash)
    @node_name, child_hash = hash.to_a[0]
    @children = child_hash.to_a.map { |h| Tree.new({h[0] => h[1]}) if h != nil }
  end

  def visit_all(&block)
    visit &block
    children.each { |c| c.visit_all &block }
  end

  def visit(&block)
    block.call self
  end
end

family_tree_hash = {'grandpa' => { 'dad' => { 'child 1' => {}, 'child 2' => {}}, 'uncle' => {'child 3' => {}, 'child 4' => {}}}}

family_tree = Tree.new(family_tree_hash)

family_tree.visit_all { |n| p n.node_name }
