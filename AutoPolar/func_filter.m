function processed_data = func_filter(data,varargin)
    p = inputParser;
    addParameter(p, 'tptr', 'minimaxi');
    addParameter(p, 'sorh', 's');
    addParameter(p, 'scal', 'one');
    addParameter(p, 'N', 5);
    parse(p,varargin{:})
    tptr = p.Results.tptr;
    sorh = p.Results.sorh;
    scal = p.Results.scal;
    N = p.Results.N;
    processed_data = wden(data,tptr,sorh,scal,N,'db3');
    processed_data(end) = processed_data(1);
end