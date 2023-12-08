require 'test/unit'

class Node
  attr_accessor :value, :next
   
  def initialize value
    @value = value
    @next = nil
  end

  def to_s
    puts "Node value is: #{@value}"
  end
end

class Linkedlist

  def initialize
    @head = nil
    @tail = nil
  end


  def find_tail
    reutrn @tail if @tail

    node = @head
    return node if !node.next
    return node if !node.next while(node = node.next)
  end

  def find(value)
    unless @head
      puts "Empty Linked-list!!!"
      return false
    end

    node = @head
    # if !node.next
    #   puts "No node found with value #{value}!!"
    #   return false 
    # end
    return node if node.value == value

    while(node = node.next)
      return node if value == node.value
    end
  end

  def find_before(value)
    node = @head
    if @head.value == value
      @head = @head.next
      return
    end

    return false if !node.next
    return node if node.next.value == value

    while(node = node.next)
      return node if node.next && node.next.value == value
    end

  end

  def print
    node  = @head
    puts node
    while (node = node.next)
      puts node
    end
  end

  def append(value)
    node  = Node.new(value)
    if @head
      find_tail.next = node
    else
      @head= node
    end
  end

  def append_after(tr_value, value)
    node = find(tr_value)

    return unless node
    old_next = node.next
    node.next = Node.new(value)
    node.next.next = old_next
  end

  def delete(value)

    if @head.value == value
      puts "Deleting the head node!!"
      if @head.next
        @head = @head.next
      else
        @head = nil
      end
      return true
    end

    puts "delete::value::#{value}"
    bfr_node = find_before(value)
    bfr_node.to_s
    puts "@head.value::#{@head.value}, value::#{value}"

    bfr_node.next = bfr_node.next.next
    return true
  end

end


if __FILE__ == $0

  class MyTest < Test::Unit::TestCase
    
    self.test_order = :defined

    def setup
      puts "Coming"
      @llist || @llist = Linkedlist.new
      puts "@llist:::#{@llist}"
      @head_list = 1
      @list_ele = [1,2,3,5]
    end

    def test_for_single_node
      puts "===============Create HEAD node==================="
      @llist.append(@head_list)
      @llist.print
      assert_equal @head_list, @llist.find(@head_list).value
      assert_equal nil, @llist.find(@head_list).next
    end

    def test_for_adding_nodes
      puts "===============Append node==================="
      @list_ele.each do |list_val|
        @llist.append(list_val)
        assert_equal list_val, @llist.find(list_val).value
        puts "list_val::#{list_val}, found in list::#{@llist.print}"
        assert_equal @llist.find(list_val), @llist.find_tail
        puts "Appended to list !!"
      end
    end

    def test_node_delete
      puts "===============Delete node==================="
      @llist.append(10)
      @llist.append(12)
      @llist.append(14)
      @llist.print
      @llist.delete(12)
      puts "===============Delete node==================="
      @llist.print      
      assert_equal nil, @llist.find(12)
    end

    def test_head_node_delete
      puts "===============Delete HEAD node==================="
      @llist.append(10)
      @llist.append(12)
      @llist.append(14)
      @llist.print
      @llist.delete(10)
      puts "===============Delete HEAD node==================="      
      @llist.print      
      assert_equal nil, @llist.find(10)      
    end

    def test_tail_node_delete
      puts "===============Delete TAIL node==================="
      @llist.append(10)
      @llist.append(12)
      @llist.append(14)
      @llist.print
      @llist.delete(14)
      puts "===============Delete TAIL node==================="      
      @llist.print      
      assert_equal nil, @llist.find(14)      
    end    
  end
end