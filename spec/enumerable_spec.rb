# frozen_string_literal: true

require_relative '../enumerable.rb'

#let(:dummy_class) { Class.new { include Enumerable}}

RSpec.describe Enumerable do
    describe '#my_each' do
        it 'Select each element of the array and yields it' do
            arr = [1, 2, 3]
            my_proc = Proc.new { |x| x*2 }
            expect(arr.my_each{|x| x*2}).to eql(arr.each(&my_proc))
        end

        it 'Returns enumerator if they do not give any block' do
            arr = [1,2,3]
            expect(arr.my_each).to be_a Enumerator
        end
    end

    describe '#my_each_with_index' do
        context 'Returns the array and yields the block' do
            it 'Returns the array' do
                arr = [1,2,3]
                expect(arr.my_each_with_index{ |x,index| index + x }).to eql(arr)
            end

            it 'Returns an enumerator if they do not give any block' do
                arr = [1,2,3]
                expect(arr.my_each_with_index).to be_a Enumerator
            end
        end
    end
end