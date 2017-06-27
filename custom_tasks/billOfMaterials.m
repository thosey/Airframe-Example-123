function result = billOfMaterials(file)
%billOfMaterials   Simulink Project custom task for generating a "bill of
%materials" report. This report includes an MD5 checksum for each file in
%the project, together with revision information.
%
% Input arguments:
%  file - string - The absolute path to a file included in the custom task.
%  When you run the custom task, Simulink Project provides the file 
%  input for each selected file.
%
% Output arguments:
%  result - string - Information about the file for inclusion in the 
%  report. The Simulink Project displays the result in the Custom Task 
%  Results column.
%
%   Copyright 2016 The MathWorks, Inc.

project = simulinkproject;
projectFile = project.findFile(file);

resultsCellArray = {...
    ['MD5 Checksum: ' Simulink.getFileChecksum(file)]; ...
    ['Source control status: ' char(projectFile.SourceControlStatus)]; ...
    ['Revision: ' projectFile.Revision] ...
    };

result = strjoin(resultsCellArray, '\n');

end
