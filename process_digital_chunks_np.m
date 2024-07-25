function [Z] = process_digital_chunks_np(binName, path, chunkSize, dlist, ChunkFunc, ChunkFuncArg)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

    Z = ChunkFuncArg;

    % Parse metafile
    meta = SGLX_readMeta.ReadMeta(binName, path);
    fprintf('Sampling rate %f\n', SGLX_readMeta.SampRate(meta));
    nChan = str2double(meta.nSavedChans);
    nFileSamp = str2double(meta.fileSizeBytes) / (2 * nChan);
    fprintf('File has %d samples, approx %f sec\n',nFileSamp,nFileSamp/SGLX_readMeta.SampRate(meta));

    iSampLast = 0;

    dw = 1;     % not totally sure what this is for, but its needed.
    iBlock = 0;
    while iSampLast < nFileSamp
        allChannelData = SGLX_readMeta.ReadBin(iSampLast, chunkSize, meta, binName, path);
        iBlock = iBlock+1;
        nSampRead = size(allChannelData, 2);

        digData = SGLX_readMeta.ExtractDigital(allChannelData, meta, dw, dlist);

        % call process func
        Z = ChunkFunc(digData, iSampLast, iBlock, Z);

        % iSampLast needs update
        iSampLast = iSampLast + nSampRead;
    end
end