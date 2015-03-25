% Class Series
% author WN
% created 26/01/2015

classdef Series < handle

    properties(GetAccess = 'private', SetAccess = 'private')
        data
        pointer = 1
    end

    properties(GetAccess = 'public', SetAccess = 'private')
        size
        slabSize
        slabCount
        predictionSize
    end

    methods (Access = public)
        function obj = Series(data, slabSize, predictionSize)

            if nargin < 3
                predictionSize = 0;
            end

            obj.data = data;
            obj.size = length(data);

            obj.predictionSize = predictionSize;

            obj.slabSize = slabSize;
            obj.slabCount = obj.size - slabSize + predictionSize + 1;
        end

        function slab = getSlab(obj, x)

            if (x == 0)
                slab = zeros(1,obj.slabSize);
                return
            end

            if (x > obj.slabCount)
                Logger.error('Series trying to access non exisiting slab.');
                slab = zeros(1,obj.slabSize);
                return
            end

            slab = obj.data([x:x+obj.slabSize-1]) - obj.data(x);
        end

        function prediction = getPrediction(obj, x)

            if (obj.predictionSize == 0)
                return
            end

            if (x == 0)
                prediction = zeros(1,obj.slabSize);
                return
            end

            if (x > obj.slabCount)
                Logger.error('Series trying to access non exisiting slab.');
                prediction = zeros(1,obj.slabSize);
                return
            end

            prediction = obj.data([x+obj.slabSize:x+obj.slabSize+obj.predictionSize-1]) - obj.data(x);
        end

        function slab = next(obj)

            slab = obj.getSlab(obj.pointer);
            obj.pointer = obj.pointer + 1;
        end

        function reset(obj)
            obj.pointer = 1;
        end
    end

end
