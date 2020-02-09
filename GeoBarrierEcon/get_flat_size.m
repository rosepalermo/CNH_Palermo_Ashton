function n = get_flat_size(varargin)
    if nargin == 0
        n = 0;
        return;
    end
    
	n = 1;
	for i=1:nargin
		n = n*length(varargin{i});
	end
end
