function [objpos,objdim] = distributeObjects(nobjects,startpos,endpos,gap,warnoff)

%Returns the proper positions and size for uniformly spaced GUI objects.

if nargin<5
	warnoff = 0;
end

rev = 0;
if startpos > endpos
    rev = 1;
    tmp = endpos;
    endpos = startpos;
    startpos = tmp;
end
    
objdim = ((endpos-startpos)-(nobjects-1)*gap)/nobjects;
objpos = startpos:objdim+gap:endpos; 
objpos = objpos(1:nobjects);

if rev
    objpos = objpos(end:-1:1);
end
if ~warnoff && (any(objpos < 0) || objdim < 0)
	warndlg('The parameters you entered result in a negative starting point or dimension. You may want to rethink that.');
end
