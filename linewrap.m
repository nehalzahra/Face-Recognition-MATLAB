function c = linewrap(s, maxchars)
% Separate a single string into multiple strings

error(nargchk(1, 2, nargin));

bad_s = ~ischar(s) || (ndims(s) > 2) || (size(s, 1) ~= 1);
if bad_s
   error('S must be a single-row char array.');
end

if nargin < 2
   % Default value for second input argument.
   maxchars = 80;
end

% Trim leading and trailing whitespace.
s = strtrim(s);

% Form the desired regular expression from maxchars.
exp = sprintf('(\\S\\S{%d,}|.{1,%d})(?:\\s+|$)', maxchars, maxchars);

tokens = regexp(s, exp, 'tokens').';

get_contents = @(f) f{1};
c = cellfun(get_contents, tokens, 'UniformOutput', false);

c = deblank(c);


