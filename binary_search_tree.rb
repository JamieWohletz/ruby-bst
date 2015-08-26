# This class is a simple implementation of a binary search tree in Ruby.
#
# Author:: Jamie Wohletz
# License:: MIT
class BinarySearchTree
  def initialize
    @root = make_new_node
  end

  # Attempts to insert a value into the tree.
  # Will not insert duplicate values. Will not insert values with
  # different types than the root value type. In other words,
  # you may not insert both an integer and a string into the same tree
  # unless you clear the tree first.
  def insert(value)
    if @root[:value].nil?
      @root[:value] = value
      return true
    end
    return false if contains(value)
    recursive_insert(value, @root)
  end

  # Attempts to remove a value from the tree.
  # This value must match the root node's value type.
  # Returns true if value removed, false otherwise.
  def remove(value)
    return false if @root[:value].nil?
    type_check value

    child = search(value, @root)
    return false if is_nil(child)

    if is_leaf(child)
      make_nil(child)
    elsif has_one_child(child)
      replacement_value =
        (child[:left] || {})[:value] || child[:right][:value]
    else
      replacement_value = get_replacement_node(child, true)[:value]
      remove(replacement_value)
    end
    child[:value] = replacement_value
    true
  end

  # Checks to see if a value exists in the tree.
  def contains(value)
    return false if @root[:value].nil?
    type_check value
    !search(value,@root).nil?
  end

  private
  def recursive_insert(val, node)
    if val < node[:value]

      if is_nil(node[:left])
        node[:left] = make_new_node(val)
      else
        return recursive_insert(val,node[:left])
      end

    else

      if is_nil(node[:right])
        node[:right] = make_new_node(val)
      else
        return recursive_insert(val,node[:right])
      end

    end
    true
  end

  def search(val, node)
    if val < node[:value] and !is_nil(node[:left])
      return search(val, node[:left])
    elsif val > node[:value] and !is_nil(node[:right])
      return search(val, node[:right])
    elsif val == node[:value]
      return node
    end
    nil
  end

  def get_replacement_node(node, go_left = false)
    if go_left
      return get_replacement_node(node[:left])
    end

    return is_nil(node[:right]) ? node : get_replacement_node(node[:right])
  end

  #Helpers

  def type_check(value)
    unless @root[:value].is_a? value.class
      raise TypeError, 'Only one type is allowed in the tree at any time!'
    end
  end

  def is_leaf(node)
    is_nil(node[:left]) && is_nil(node[:right])
  end

  def has_one_child(node)
    (!is_nil(node[:right]) && is_nil(node[:left])) ||
    (!is_nil(node[:left]) && is_nil(node[:right]))
  end

  def make_new_node(value = nil, left = nil, right = nil)
    {value:value,left:left,right:right}
  end

  def is_nil(node)
    node.nil? || node[:value].nil?
  end

  def make_nil(node)
    node[:value] = nil
    node[:left] = nil
    node[:right] = nil
  end
end
