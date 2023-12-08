require 'test/unit'

class Queue

  Node = Struct.new :value, :next
  attr_accessor :enqueue, :dequeue, :clear, :to_s

  MAX_SIZE = 10

  def initialize()
    @head = nil
    @tail = nil
    @size = 0
  end

  def enqueue(ele)
    if is_full?
      puts "Queue is full!"
      return nil
    end

    n = Node.new ele, nil
    unless @tail
      @head = @tail = n
    else
      @tail.next = n
      @tail = n
    end
    @size += 1
    return ele
  end

  def dequeue
    # unless @tail
    #   puts "Empty queue!!"
    #   reuturn nil
    # end

    if is_empty?
      puts "Empty queue!!"
      return nil
    end

    n = @head
    if 1 == @size
      clear
      return n.value
    end

    @head = n.next
    @size -= 1
    return n.value
  end

  def clear
    @head = @tail  = nil
    @size = 0
  end

  def get_head
    return @head && @head.value
  end

  def get_tail
    return @tail && @tail.value
  end

  def is_empty?
    return 0 == @size
  end

  def is_full?
    return @size == MAX_SIZE
  end

  def to_s
    _ds = []

    if is_empty?
      puts "Empty queue!!"
      return _ds
    end

    n = @head
    
    while n
      
      if n.next.nil? && _ds.empty?
        _ds << n.value.to_s + "(head & tail)"
      else
        if n.next
          _ds << n.value.to_s + "(head)"
        else
          _ds << n.value.to_s + "(tail)"
        end
      end
      n = n.next
    end
    return _ds.join(",")
  end

end # Queue

if __FILE__ == $0
  puts "file:;#{__FILE__}"
  class MyTest < Test::Unit::TestCase

    def setup
      puts "comig"
      @queue || @queue = Queue.new
      @eles || @eles = [1,2,3]
      @rmv_ele || @rmv_ele = @eles.sample()
    end

    def test_add_queue_ele
      @eles.each do |ele|
        puts "Adding #{ele} to queue."
        add_ele = @queue.enqueue ele
        assert_equal ele, add_ele
      end
      puts "Queue ele are: #{@queue.to_s}"
    end

    def test_remove_queue_ele
      @eles.each do |ele|
        add_ele = @queue.enqueue ele
        assert_equal ele, add_ele
      end
      q_head = @queue.get_head
      puts "Removing #{q_head} from queue."
      rmv_ele = @queue.dequeue
      puts "Queue ele are: #{@queue.to_s}"
      assert_equal rmv_ele, q_head  
    end
  end
end

# fllow = true
# q_otpn = nil
# while fllow
#   puts ""
#   ds_q = Queue.new
#   puts "Eneter value to quere"
#   q_val = gets.chomp
#   puts "Entered val #{q_val}"
#   ds_q.enqueue q_val
#   puts "Wish to continue y/n?"
#   optn = gets.chomp
#   puts "Entered option #{optn}"
#   if "n" == optn.downcase
#     puts "Exiting!!!"
#     return
#   end
# end

