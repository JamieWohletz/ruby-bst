require_relative 'binary_search_tree'
require 'test/unit'

class TestBinarySearchTree < Test::Unit::TestCase

  def setup
    @bst = BinarySearchTree.new
  end

  def teardown
    @bst = nil
  end

  def test_insert_integer
    assert @bst.insert(45), 'Should insert root value successfully'
    assert @bst.insert(32), 'Should insert second value successfully'
    assert_raise(TypeError) do
      @bst.insert('string')
    end
    assert @bst.insert(-5), 'Should insert negative number successfully'
    assert_false @bst.insert(45), 'Should not insert duplicate value'
  end

  def test_insert_string
    assert @bst.insert('somestring'), 'Should insert root string'
    assert @bst.insert('aardvark'), 'Should insert second string'
    assert_raise(TypeError) do
      @bst.insert(35)
    end
    assert_false @bst.insert('aardvark'), 'Should not insert duplicate string'
  end

  def test_remove
    root = 45
    right = 50
    @bst.insert root
    assert @bst.remove(root), 'Should remove root node'
    assert_false @bst.contains(root), 'Element should be removed'
    @bst.insert root
    @bst.insert right
    assert @bst.remove(right), 'Should remove leaf node'
    assert_false @bst.contains(right), 'Element should be removed'
    @bst.insert(right)
    @bst.insert(46)
    @bst.insert(60)
    assert @bst.remove(right), 'Should remove parent node'
    assert_false @bst.contains(right), 'Element should be removed'

    assert @bst.remove(46), 'Should remove parent of one child node'
    assert_false @bst.contains(46), 'Element should be removed'

    assert_false @bst.remove(325), 'Should not remove a nonexistant node'

    assert_raise(TypeError) do
      @bst.remove('a string!')
    end
  end

  def test_contains
    @bst.insert 'Something'
    assert @bst.contains('Something'), 'Should contain existant node'
    assert_false @bst.contains('Else'), 'Should not contain nonexistant node'
  end
end
