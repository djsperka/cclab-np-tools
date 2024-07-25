function [I,v] = find_dig_transitions_np(d)
%find_pulses_np Given a vector of values from a neuropixel digital channel,
%returns the start index and width of all pulses (up,down sequence).
%   Transitions assumed to occur at the first index which is different than
%   the one before it. So, if d(i)=0, and d(i+1)=1, then the transition
%   occurs at index i+1. Later in the sequence, if d(i+n)=1 (and all
%   previous values since i+1) and d(i+n+1)=0, then the transition occurs
%   at index i+n+1. The width of this pulse is (i+n+1)-(i+1) = n.

    if ~isvector(d)
        error('Expecting single digital vector arg');
    end
    if ~isempty(setdiff(unique(d),[0,1]))
        error('Expecting vector of 0,1 values');
    end


    % c is the diff array. Remember that the index values in I must be
    % adjusted UP by 1 to be the index we take the transition to be. We
    % will do that later.
    A = [];
    np = 0; % number of pulses
    c = diff(int16(d));
    I = find(c);
    v = c(I);
    % 
    % 
    % if isempty(I)
    %     return
    % end
    % 

end