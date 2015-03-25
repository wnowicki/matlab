% Class SlabCollection
% author WN
% created 19/03/2015

classdef SlabCollection < handle

    properties(GetAccess = 'private', SetAccess = 'private')
        data
        pointer
    end

    properties(GetAccess = 'public', SetAccess = 'private')
        collectionSize = 0
    end

    methods (Access = public)

        function obj = SlabCollection()
        end

        function addSlab(obj, slab)
            obj.data = [obj.data slab];
            obj.collectionSize = obj.collectionSize + 1;
        end

        function slab = getSlab(obj, key)
            slab = obj.data(key);
        end

        function sortByAccuracy(obj)

            accuracy = ones(1, obj.collectionSize);

            for i=1:obj.collectionSize
                accuracy(i) = obj.getSlab(i).getAccuracy();
            end

            [x i] = sort(accuracy, 'descend');

            obj.data = obj.data(i);
        end

        function array = toArray(obj, slab)

            for i=1:obj.collectionSize
                array(i, :) = obj.getSlab(i).toArray();
            end
        end
    end

    methods(Static)
        function obj = make(components)

            componentsLength = length(components(:,1));

            obj = SlabCollection;

            for i=1:componentsLength
                slab = Slab.make(components(i,:));
                obj.addSlab(slab);

            end
        end
    end
end
