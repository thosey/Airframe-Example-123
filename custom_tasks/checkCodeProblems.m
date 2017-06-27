function result = checkCodeProblems(file)
%checkCodeProblems   Simulink Project custom task for MATLAB code checking
%
% Input arguments:
%  file - string - The absolute path to a file included in the custom task.
%  When you run the custom task, Simulink Project provides the file 
%  input for each selected file.
%
% Output arguments:
%  result - string - The number of problems detected. The Simulink Project 
%  displays the result in the Custom Task Results column.
%
% Copyright 2012-2016 The MathWorks, Inc.


[~, ~, ext] = fileparts(file);
if strcmp(ext, '.m')
    problems = length(checkcode(file));
    switch problems
        case 0
            result = 'No problems detected';
        case 1
            result = '1 problem detected';
        otherwise
            result = [int2str(problems) ' problems detected'];
    end
else
    result = [];
end

end
