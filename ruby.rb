# frozen_string_literal: true

module Enumerable
  def my_each
    arr = []
    (0...length).each do |i|
      arr << yield(self[i])
    end
    arr
  end

  def my_each_with_index
    arr = []
    (0...length).each do |i|
      self[i] = [self[i], i]
      arr << yield(self[i])
    end
    arr
  end

  def my_select
    my_arr = []
    my_each do |x|
      my_arr << x if yield(x)
    end
    my_arr
  end

  def my_all?
    if block_given?
      my_each do |x|
        return false unless yield(x)
      end
      true
    else
      false
    end
  end

  def my_any?
    if block_given?
      my_each do |x|
        return true if yield(x)
      end
      false
    else
      true
    end
  end

  def my_none?
    if block_given?
      my_each do |x|
        return false if yield(x)
      end
      true
    elsif my_any? { |x| x == true }
      false
    else
      true
    end
  end

  def my_count(num = nil)
    cons = 0
    if block_given?
      my_each do |x|
        cons += 1 if yield(x)
      end
      cons
    elsif !num.nil?
      my_each do |x|
        cons += 1 if num == x
      end
      cons
    else
      length
    end
  end

  def my_map(proc_g = nil)
    my_arr = []
    if proc_g.nil?
      my_each do |x|
        my_arr << yield(x)
      end
    else
      my_each do |x|
        my_arr << proc_g.call(x)
      end
    end
    my_arr
  end

  def my_inject(opp = nil)
    cons = 0
    if block_given?
      if !opp.nil?
        my_each do |x|
          cons += x if yield(x)
        end
      else
        (0...length).each do |i|
          puts cons
          cons = yield(cons, self[i])
        end
      end
      cons
    else
      'Error!'
    end
  end

  def multiply_els(arr = nil)
    ans = 1
    if arr.nil?
      (0...length).each do |i|
        ans *= self[i]
      end
    else
      (0...arr.length).each do |i|
        ans *= arr[i]
      end
    end
    ans
  end
end

a = [1, 2, 2, 4, 3, 4, 1, 4]

line = proc { puts '-----------------------------------' }

a.my_each { |x| puts "This is my each #{x}" }

line.call

a.my_each_with_index { |x, ind| puts "#{x} is value #{ind}" }

a = [1, 2, 2, 4, 3, 4, 1, 4]

line.call

puts a.my_select(&:even?)

line.call

a = [1, 2, 2, 4, 3, 4, 1, 4]

puts a.my_all?(&:even?)

a = [1, 2, 2, 4, 3, 4, 1, 4]

line.call

puts(a.my_any? { |x| x == 2 })

a = [1, 2, 2, 4, 3, 4, 1, 4]

line.call

puts(a.my_none? { |x| x == 2 })

a = [1, 2, 2, 4, 3, 4, 1, 4]

line.call

# If you dont type anything after the .my_count, it will give you the length. If you type a
# number it will give you the match or you can add a block with the condition

puts a.my_count(4)

a = [1, 2, 2, 4, 3, 4, 1, 4]

line.call

puts(a.my_map { |x| x * 2 })

a = [1, 2, 2, 4, 3, 4, 1, 4]

line.call
# You can also call my_inject as (:+)

puts(a.my_inject { |sum, x| sum + x })

a = [1, 2, 2, 4, 3, 4, 1, 4]

line.call
# You can also call multiply_els as example.multiply_els(my_array)

puts a.multiply_els

a = [1, 2, 2, 4, 3, 4, 1, 4]

line.call

my_proc = proc { |x| x * 2 }

puts a.my_map(my_proc)
