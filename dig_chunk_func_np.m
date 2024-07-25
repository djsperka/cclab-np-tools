function [Z] = dig_chunk_func_np(digData, iSampLast, iBlock, Z)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here

    for i=1:size(digData,1)
        [I,v] = find_dig_transitions_np(digData(i,:));
        if ~isempty(I)
            I = I + iSampLast;
            Z{i}.I = horzcat(Z{i}.I, I);
            Z{i}.v = horzcat(Z{i}.v, v);
        end
    end

end