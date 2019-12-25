module Enumerable

    def my_each
        for i in 0...length()
            yield(self[i])
        end
    end

    def my_each_with_index
        for i in 0...length()
            self[i] = [self[i], i]
            yield(self[i])
        end
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
            return true
        else
            return false
        end
    end

    def my_any?
        if block_given?
            my_each do |x|
                return true if yield(x)
            end
            return false
        else
            return true
        end
    end

    def my_none?
        if block_given?
            my_each do |x|
                return false if yield(x)
            end
            true
        elsif my_any?{|x| x==true}
            false
        else
            true
        end
    end

    def my_count(num = nil)
        cons = 0
        if block_given?
            my_each do |x|
                if yield(x)
                    cons += 1
                end
            end
            cons
        elsif num != nil
            my_each do |x|
                if num == x
                    cons += 1
                end
            end
            cons
        else
            length
        end
    end

    def my
        my_each do |x|
        end
    end

    def my
        my_each do |x|
        end
    end
end

include Enumerable

a = [1, 2, 2, 4, 3, 4, 1, 4]

#puts a.my_each{|x| puts "This is my each #{x}"}

#puts a.my_each_with_index { |x,ind| puts "#{x} is value #{ind}"}

#puts a.my_select(&:even?)

#puts a.my_all?(&:even?)

#puts a.my_any?

#puts a.my_none?

#puts a.my_count(4)