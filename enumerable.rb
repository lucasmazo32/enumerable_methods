# frozen_string_literal: true

module Enumerable
  def my_each
    return to_enum(:each) unless block_given?

    arr = []
    real_arr = to_a
    (0...real_arr.length).each do |i|
      yield (real_arr[i])
      arr << real_arr[i]
    end
    arr
  end

  def my_each_with_index
    return to_enum(:each_with_index) unless block_given?

    arr = []
    cont = 0
    my_each do |x|
      arr << x
      x = [x, cont]
      cont += 1
      yield(x)
    end
    arr
  end

  def my_select
    return to_enum(:select) unless block_given?

    my_arr = []
    my_each do |x|
      my_arr << x if yield(x)
    end
    my_arr
  end

  def my_all?(ver = nil)
    if block_given?
      my_each do |x|
        return false unless yield(x)
      end
    elsif ver.nil?
      my_each do |x|
        return false if x.nil? || x == false
      end
    elsif ver.is_a? Class
      my_each do |x|
        return false unless x.is_a? ver
      end
    elsif ver.is_a? Regexp
      my_each do |x|
        return false unless x.to_s.match?(ver)
      end
    else
      my_each do |x|
        return false unless x == ver
      end
    end
    true
  end

  def my_any?(ver = nil)
    if block_given?
      my_each do |x|
        return true if yield(x)
      end
    elsif ver.nil?
      my_each do |x|
        return true if !x.nil? && x != false
      end
    elsif ver.is_a? Class
      my_each do |x|
        return true if x.is_a? ver
      end
    elsif ver.is_a? Regexp
      my_each do |x|
        return true if x.to_s.match?(ver)
      end
    else
      my_each do |x|
        return true if x == ver
      end
    end
    false
  end

  def my_none?(ver = nil)
    if block_given?
      my_each do |x|
        return false if yield(x)
      end
    elsif ver.nil?
      my_each do |x|
        return false unless x == false || x.nil?
      end
    elsif ver.is_a? Class
      my_each do |x|
        return false if x.is_a? ver
      end
    elsif ver.is_a? Regexp
      my_each do |x|
        return false if x.to_s.match?(ver)
      end
    else
      my_each do |x|
        return false if x == ver
      end
    end
    true
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
    return to_enum(:map) unless block_given?

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

  def my_inject(opposym = nil, sym = nil)
    cons = 1
    sum = 1
    memo = ''
    if opposym.nil? && sym.nil? && my_all?(Integer)
      my_each do |x|
        cons = yield(cons, x)
        sum += x
      end
      return cons - 1 if cons == sum

      return cons
    elsif opposym.nil? && sym.nil? && my_all?(String)
      my_each do |x|
        memo = yield(memo, x)
      end
      return memo
    elsif !opposym.nil? && block_given?
      my_each do |x|
        opposym = yield(opposym, x)
      end
    elsif !opposym.nil? && !sym.nil?
      my_each do |x|
        opposym = opposym.method(sym).call(x)
      end
    else
      my_each_with_index do |x, i|
        cons = if i.zero?
                 x
               else
                 cons.method(opposym).call(x)
               end
      end
      return cons
    end
    opposym
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

p [false, false, 3].my_none?
p [false, false, true].my_none?
