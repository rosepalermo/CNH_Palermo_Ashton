function varargout = get_flat_values(ind, varargin)
    if nargin == 1
        disp("That's not how you use this function!");
        return;
    end
    
	sz = zeros(1,nargin-1);
    for i=1:nargin-1
		sz(i) = length(varargin{i});
    end
    
    sub = cell(1,nargin-1);
    varargout = cell(1,nargin-1);
    [sub{1:nargin-1}] = ind2sub(sz,ind);
    for i=1:nargin-1
        varargout{i} = varargin{i}(sub{i});
    end
end