# frozen_string_literal: true

require_relative '../enumerable.rb'

# let(:dummy_class) { Class.new { include Enumerable}}

RSpec.describe Enumerable do
  describe '#my_each' do
    it 'Select each element of the array and yields it' do
      arr = [1, 2, 3]
      my_proc = proc { |x| x * 2 }
      expect(arr.my_each { |x| x * 2 }).to eql(arr.each(&my_proc))
    end

    it 'Returns enumerator if they do not give any block' do
      arr = [1, 2, 3]
      expect(arr.my_each).to be_a Enumerator
    end
  end

  describe '#my_each_with_index' do
    context 'Returns the array and yields the block' do
      it 'Returns the array' do
        arr = [1, 2, 3]
        expect(arr.my_each_with_index { |x, index| index + x }).to eql(arr)
      end

      it 'Returns an enumerator if they do not give any block' do
        arr = [1, 2, 3]
        expect(arr.my_each_with_index).to be_a Enumerator
      end
    end
  end

  describe '#my_select' do
    it 'returns the items in the array wich meet the criteria in the block' do
      expect([1, 2, 3].my_select { |x| x < 3 }).to eql([1, 2])
    end
    it 'Returns an enumerator if they do not give any block' do
      arr = [1, 2, 3]
      expect(arr.my_select).to be_a Enumerator
    end
  end

  describe '#my_all?' do
    context 'if a block is given checks if ALL item in the array meets this criteria' do
      it 'if every item meets the criteria returns true' do
        expect([1, 2, 3].my_all? { |x| x < 4 }).to be true
      end
      it 'if not every item meets the criteria returns false' do
        expect([1, 2, 3].my_all? { |x| x < 3 }).to be false
      end
    end
    context 'else if there is not either a block or a parameter, checks for every item in the array to be truthy' do
      it 'if every tiem is truthy returns true' do
        expect([1, 2, 3].my_all?).to be true
      end
      it 'if not every tiem is truthy returns false' do
        expect([1, 2, false].my_all?).to be false
      end
    end
    context 'if the verification is not null checks the type' do
      it 'if it is a Class it compares ir to the items in the array ' do
        expect([1, 2, 3].my_all?(Integer)).to be true
      end
      it 'if it is a Regex it compares ir to the items in the array ' do
        expect([1, 2, 3].my_all?(/\d/)).to be true
      end
      it 'if it is a a variable it compares ir to the items in the array ' do
        expect([1, 2, 3].my_all?(1)).to be false
      end
    end
  end

  describe '#my_any?' do
    context 'if a block is given checks if ANY item in the array meets this criteria' do
      it 'if any item meets the criteria returns true' do
        expect([1, 2, 3].my_any? { |x| x < 2 }).to be true
      end
      it 'if non of the items meets the criteria returns false' do
        expect([1, 2, 3].my_all? { |x| x > 3 }).to be false
      end
    end
    context 'else if there is not either a block or a parameter, checks for every item in the array to be truthy' do
      it 'if any item is truthy returns true' do
        expect([false, 2, false].my_any?).to be true
      end
      it 'if non of the items is truthy returns false' do
        expect([false, false, false].my_all?).to be false
      end
    end
    context 'if the verification is not null checks the type' do
      it 'if it is a Class it compares ir to the items in the array ' do
        expect([1, 2, 3].my_any?(Integer)).to be true
      end
      it 'if it is a Regex it compares ir to the items in the array ' do
        expect([1, 2, 3].my_any?(/\d/)).to be true
      end
      it 'if it is a a variable it compares ir to the items in the array ' do
        expect([1, 2, 3].my_any?(1)).to be true
      end
    end
  end

  describe '#my_none?' do
    context 'if a block is given checks if NONE of the items in the array meets this criteria' do
      it 'if none of the items meet the criteria returns true' do
        expect([1, 2, 3].my_none? { |x| x > 3 }).to be true
      end
      it 'if at least one of the items meets the criteria returns false' do
        expect([1, 2, 3].my_none? { |x| x < 2 }).to be false
      end
    end
    context 'else if there is not either a block or a parameter, checks for every item in the array to be truthy' do
      it 'if none of the items is truthy returns true' do
        expect([false, false, false].my_none?).to be true
      end
      it 'if at least one of the items is truthy returns false' do
        expect([false, false, 3].my_none?).to be false
      end
    end
    context 'if the verification is not null checks the type' do
      it 'if it is a Class it compares it to the items in the array ' do
        expect([1, 2, 3].my_none?(String)).to be true
      end
      it 'if it is a Regex it compares ir to the items in the array ' do
        expect([1, 2, 3].my_none?(/\D/)).to be true
      end
      it 'if it is a a variable it compares ir to the items in the array ' do
        expect([1, 2, 3].my_none?(1)).to be false
      end
    end
  end

  describe '#my_count' do
    context 'returns the number of times an item appears based on a condition' do
      it 'if a block was given it takes it as the condition' do
        expect([1, 2, 3].my_count(&:even?)).to eql(1)
      end
      it 'if a no block was given, but there is a parameter it takes it as the condition' do
        expect([1, 2, 3].my_count(&:even?)).to eql(1)
      end
      it 'if there is no block or parameter it returns the length of the array' do
        expect([1, 2, 3].my_count).to eql(3)
      end
    end
  end

  describe '#my_map' do
    it 'returns an enumerator if no block is given' do
      expect([1, 2, 3].my_map).to be_a Enumerator
    end
    it 'if a proc was given it returns a new array from the instructions given' do
      my_proc = proc { |x| x * 2 }
      expect([1, 2, 3].my_map(&my_proc)).to eql([2, 4, 6])
    end
    it 'if a block was given it returns a new array from the instructions given' do
      expect([1, 2, 3].my_map { |x| x * 2 }).to eql([2, 4, 6])
    end
  end

  describe '#my_inject' do
    it 'if a block is given but no parameters are given, it yields the block' do
      expect([1, 2, 3].my_inject { |sum, x| sum + x }).to eql(6)
    end
    it 'if a block and a parameters are given, it will yield the block with the initial result in the parameter' do
      expect([1, 2, 3].my_inject(1) { |sum, x| x + sum }).to eql(7)
    end
    it 'if a block is not given, and I have one parameter, it will do de operation' do
      expect([1, 2, 3].my_inject(:+)).to eql(6)
    end
    it 'if a block is not given and I have two parameters,
          the first one is the initial result and the second is the operator' do
      expect([1, 2, 3].my_inject(1, :+)).to eql(7)
    end
  end
end
