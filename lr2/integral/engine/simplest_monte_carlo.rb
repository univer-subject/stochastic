module Integral
  module Engine
    class SimplestMonteCarlo < Mode
      p self

      def self.compute_function(borders, func, quantity)
        sum = quantity.times.map do
          func.call(rand(borders))
        end.reduce(:+)
        amplitude(borders).to_f * sum.to_f / quantity.to_f

      end

      def compute_mistake
        raw_mistake = AXISES.map do |axis|
          amplitude(@borders[axis]) * Math.sqrt(dispersion(axis))
        end.reduce(:+)
        @mistake =  raw_mistake / 3.0
      end

      private
        def dispersion(axis)
          sum = {smpl: 0, pow2: 0}
          @quantity.times do
            f = @functions[axis].call(rand(@borders[axis]))
            sum[:smpl] += f
            sum[:pow2] += f ** 2
          end

          raw_dispersion1 =  sum[:pow2] / @quantity.to_f 
          raw_dispersion2 = (sum[:smpl] / @quantity.to_f) ** 2

          raw_dispersion1 - raw_dispersion2/ @quantity.to_f
        end
    end
  end
end