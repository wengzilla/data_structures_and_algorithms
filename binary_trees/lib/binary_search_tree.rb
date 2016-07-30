class Node
  attr_accessor :data, :left, :right

  def initialize(data, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end
end

class BinarySearchTree
  attr_accessor :root_node

  def initialize
    @root_node = nil
  end

  def push(new_data)
    if root_node.nil?
      self.root_node = Node.new(new_data)
    else
      current_node = root_node
      last_node = nil
      until current_node.nil?
        last_node = current_node
        if current_node.data <= new_data
          current_node = current_node.left
        else
          current_node = current_node.right
        end
      end
      last_node.left = Node.new(new_data)
    end
  end

  def insert(root, new_data, parent)
    if root_node.nil?
      return self.root_node = Node.new(new_data)
    end

    
  end
end