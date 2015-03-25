% Class Slab
% author WN
% created 18/03/2015

classdef Slab < handle

    properties(GetAccess = 'public', SetAccess = 'private')
        slab
        slabSize
        predictionSize
        prediction
        mpi = 0 % Missed Prediction Index
    end

    properties(GetAccess = 'public', SetAccess = 'public')
        occurrences = 0
        hits = 0
        pipsEarned = 0
        pipsLost = 0
    end

    methods (Access = public)
        function obj = Slab(slab)

            obj.slab = slab;
            obj.slabSize = length(slab);
        end

        function setPrediction(obj, prediction, predictionSize)
            obj.predictionSize = predictionSize;
            obj.prediction = prediction;
        end

        function accuracy = getAccuracy(obj)
            if obj.occurrences == 0
                accuracy = 0;
                return
            end

            accuracy = obj.hits/obj.occurrences;
        end

        function array = toArray(obj)
            array = [obj.slabSize obj.slab obj.predictionSize obj.prediction obj.occurrences obj.hits obj.pipsEarned obj.pipsLost obj.mpi];
        end
    end

    methods(Static)
        function obj = make(components)

            if (components(1) + 3) ~= length(components(1,:))
                throw(MException('MYFUN:make', 'Components are not valid format'));
            end

            obj = Slab(components(2:components(1)+1));
            obj.setPrediction(components(components(1)+3), components(components(1)+2));

            if (components(1) + 4) <= length(components(1,:))
                obj.occurrences = components(components(1)+4);

                if (components(1) + 5) <= length(components(1,:))
                    obj.hits = components(components(1)+5);

                    if (components(1) + 6) <= length(components(1,:))
                        obj.pipsEarned = components(components(1)+6);

                        if (components(1) + 7) <= length(components(1,:))
                            obj.pipsLost = components(components(1)+7);

                            if (components(1) + 8) <= length(components(1,:))
                                obj.mpi = components(components(1)+8);
                            end
                        end
                    end
                end
            end
        end
    end
end
