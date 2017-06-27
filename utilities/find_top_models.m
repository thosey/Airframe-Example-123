function [topModels, topModelsWithChildren] = find_top_models()
%find_top_models  Find the top-level models in the current project
%
%   Use the Simulink Project Dependency Analysis to find the top-level
%   models in the current project. 
%
%   [topModels, topModelsWithChildren] = find_top_models()

%   Copyright 2016 The MathWorks, Inc.

project = simulinkproject;
fileDependencyGraph = project.Dependencies.Graph;
if isempty(fileDependencyGraph.Nodes)
    % Use the Simulink Project API to run the file dependency analysis
    disp('Running dependency analysis')
    project.Dependencies.update;
    % Get the updated graph
    fileDependencyGraph = project.Dependencies.Graph;
end

% Get all the model files in the current project:
models = cellfun(@(f)isModelFile(f), fileDependencyGraph.Nodes.Name);
sg = subgraph(fileDependencyGraph, fileDependencyGraph.Nodes.Name(models));

% Find all the top-level models
topModelsIndex = indegree(sg)==0;
topModels = sg.Nodes.Name(topModelsIndex);

% Find only the top-level models with children (those that contain links to
% Simulink libraries and/or contain model references)
topModelsWithChildrenIndex = indegree(sg)==0 & outdegree(sg)>0;
topModelsWithChildren = sg.Nodes.Name(topModelsWithChildrenIndex);

end


function isModel = isModelFile(filename)
% Determine if the supplied file is a Simulink file by looking at its 
% file extension
[~,~,this_ext] = fileparts(filename);
isModel = ismember(this_ext, {'.slx',',mdl'});
end
