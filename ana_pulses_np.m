% Analyze the digital signals in an NP data file. 
% Provide the path and filename of the bin file. The metadata file should
% be in the same folder (same name, .meta extension). 
% path and name of np bin file. metadata file should be in same folder. 
binName = 'PhotoDioAndEventsTest_g0_t0.nidq.bin';
path = '/home/dan/work/cclab/ethdata/np';
meta = SGLX_readMeta.ReadMeta(binName, path);
dchanIndices = [2 0];   % indices of the digital channels. cclab np is 
                        % currently wired with A=>0.2 and B=>0.0.

s.I=[];
s.v=[];

Z=process_digital_chunks_np(binName, path, 1000000, dchanIndices, @dig_chunk_func_np,{s,s});
A1=transitions_to_pulses_np(Z{1}.I, Z{1}.v);
A2=transitions_to_pulses_np(Z{2}.I, Z{2}.v);

% The first two pulses should be duplicated in the two channels, ignore
% them.
if A1(1,1) == A2(1,1) && A1(2,1)==A2(2,1)
    fprintf('Initial pulses matched onset, w=%d,%d %d,%d\n', A1(1,2), A2(1,2), A1(2,2), A2(2,2));
else
    fprintf('Initial pulses DO NOT match, w=%d,%d %d,%d\n', A1(1,2), A2(1,2), A1(2,2), A2(2,2));
end

% Average time between pulses
srate = SGLX_readMeta.SampRate(meta);
fprintf('chanA diff avg %.4fs +- %.4fs\n', mean(diff(A1(3:end,1)))/srate, std(diff(A1(3:end,1))/srate))
fprintf('chanB diff avg %.4fs +- %.4fs\n', mean(diff(A2(3:end,1)))/srate, std(diff(A2(3:end,1))/srate))

% A-B diff
Ad = A2(3:end,1) - A1(3:end,1);
fprintf('chA-B diff avg %.4fs +- %.4fs\n', mean(Ad)/srate, std(Ad)/srate);
    
