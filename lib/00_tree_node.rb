require "byebug"
class PolyTreeNode
  attr_reader :value, :parent, :children
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(passed_node)
    old_parent = parent
    @parent = passed_node
    if !passed_node.nil?
      old_parent.children.delete(self) unless old_parent == nil
      parent.children << self unless parent.children.include? self
    end
  end


  def add_child(child)
    @children << child unless children.include?(child)
    child.parent=(self)
  end

  def remove_child(child)
    raise "Node is not a child" unless children.include?(child)
    children.delete(child)
    child.parent = nil
  end

  def dfs(target)
    # debugger
    return self if self.value == target
    self.children.each do |child|
      result = child.dfs(target)
      return result if !result.nil?
    end
    nil
  end

  def bfs(target)
    # debugger
    q = Array.new
    q.push(self)

    # q.empty?
    # q.push(3)
    # value = q.shift
    until q.empty?
      node = q.shift
      return node if node.value == target
      node.children.each { |child| q.push(child) }
    end
    nil
  end
#   def inspect
#     "{ Node Value=#{self.value.inspect} }"
#   end
  
end