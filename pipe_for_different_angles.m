clear all
close all
clc

% Script to generate blockmesh.dict for any wedge angle for a pipe with
% diameter D and lenght L

%% input parameters
theta = 45; % required wedge angle
Re = 2100; % reynolds number
D = 0.025;% Diameter of pipe in meters
L = 0.06*Re*D; % length of pipe in meters
R = D/2; % radius

%% co-ordinates for the vertices will be as follows using trignometric
% relatiuons

c0 = [0 0 0]; % point of origin;
c1 = [0 R*(cosd(theta/2)) R*(sind(theta/2))];
c2 = [0 R*(cosd(theta/2)) -R*(sind(theta/2))];
c3 = [L 0 0];
c4 = [L R*(cosd(theta/2)) R*(sind(theta/2))];
c5 = [L R*(cosd(theta/2)) -R*(sind(theta/2))];

%%strings for blockMeshDict file

h1 = ('/*--------------------------------*- C++ -*----------------------------------*\');
h2 = ('| =========                                                                   |');
h3 = ('| \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox           |');
h4 = ('|  \\    /   O peration     | Version:  4.1                                   |');
h5 = ('|   \\  /    A nd           | Web:      www.OpenFOAM.org                      |');
h6 = ('|    \\/     M anipulation  |                                                 |');
h7 = ('\*---------------------------------------------------------------------------*/');
h8 = ('// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //');

%% Generating a blockMeshDict file

%Header
name = sprintf('blockMeshDict_%d',theta);
fileID = fopen(name,'w');
fprintf(fileID,'%s\n',h1);
fprintf(fileID,'%s\n',h2);
fprintf(fileID,'%s\n',h3);
fprintf(fileID,'%s\n',h4);
fprintf(fileID,'%s\n',h5);
fprintf(fileID,'%s\n',h6);
fprintf(fileID,'%s\n',h7);
fprintf(fileID,'FoamFile\n{\n');
fprintf(fileID,'%16s \t 2.0;\n','version');
fprintf(fileID,'%16s \t ascii;\n','format');
fprintf(fileID,'%16s \t dictionary;\n','class');
fprintf(fileID,'%16s \t blockMeshDict;\n}\n','object');
fprintf(fileID,'%s\n\n',h8);

%vertices

fprintf(fileID,'convertToMeters 1;\n\n');
fprintf(fileID,'vertices\n(\n');
fprintf(fileID,'\t(%d %d %d)\n',c0(1),c0(2),c0(3));
fprintf(fileID,'\t(%d %d %d)\n',c1(1),c1(2),c1(3));
fprintf(fileID,'\t(%d %d %d)\n',c2(1),c2(2),c2(3));
fprintf(fileID,'\t(%d %d %d)\n',c3(1),c3(2),c3(3));
fprintf(fileID,'\t(%d %d %d)\n',c4(1),c4(2),c4(3));
fprintf(fileID,'\t(%d %d %d)\n);\n\n',c5(1),c5(2),c5(3));
fprintf(fileID,'blocks\n(\n');
fprintf(fileID,'\t hex (0 3 5 2 0 3 4 1) (400 40 1) simplegrading (1 0.1 1)\n');
fprintf(fileID,');\n');
fprintf(fileID,'edges\n(\n');
fprintf(fileID,'\t arc 1 2 (%d %d %d)\n',0, R, 0);
fprintf(fileID,'\t arc 4 5 (%d %d %d)\n',L, R, 0);
fprintf(fileID,');\n');
fprintf(fileID,'boundary\n(\n');
fprintf(fileID,'\t Inlet\n');
fprintf(fileID,'\t {\n');
fprintf(fileID,'\t type patch;\n');
fprintf(fileID,'\t faces\n');
fprintf(fileID,'\t (\n');
fprintf(fileID,'\t\t (0 1 2 0)\n');
fprintf(fileID,'\t );\n');
fprintf(fileID,'\t }\n\n');
fprintf(fileID,'\t Outlet\n');
fprintf(fileID,'\t {\n');
fprintf(fileID,'\t type patch;\n');
fprintf(fileID,'\t faces\n');
fprintf(fileID,'\t (\n');
fprintf(fileID,'\t\t (3 4 5 3)\n');
fprintf(fileID,'\t );\n');
fprintf(fileID,'\t }\n');
fprintf(fileID,'\t Top\n');
fprintf(fileID,'\t {\n');
fprintf(fileID,'\t type patch;\n');
fprintf(fileID,'\t faces\n');
fprintf(fileID,'\t (\n');
fprintf(fileID,'\t\t (1 2 5 4)\n');
fprintf(fileID,'\t );\n');
fprintf(fileID,'\t }\n');
fprintf(fileID,'\t wedgeback\n');
fprintf(fileID,'\t {\n');
fprintf(fileID,'\t type symmetry;\n');
fprintf(fileID,'\t faces\n');
fprintf(fileID,'\t (\n');
fprintf(fileID,'\t\t (0 1 4 3)\n');
fprintf(fileID,'\t );\n');
fprintf(fileID,'\t }\n');
fprintf(fileID,'\t wedgefront\n');
fprintf(fileID,'\t {\n');
fprintf(fileID,'\t type symmetry;\n');
fprintf(fileID,'\t faces\n');
fprintf(fileID,'\t (\n');
fprintf(fileID,'\t\t (0 2 5 3)\n');
fprintf(fileID,'\t );\n');
fprintf(fileID,'\t }\n');
fprintf(fileID,'\t axis\n');
fprintf(fileID,'\t {\n');
fprintf(fileID,'\t type empty;\n');
fprintf(fileID,'\t faces\n');
fprintf(fileID,'\t (\n');
fprintf(fileID,'\t\t (0 3 3 0)\n');
fprintf(fileID,'\t );\n');
fprintf(fileID,'\t }\n');
fprintf(fileID,');\n');
fprintf(fileID,'mergePatchPairs\n');
fprintf(fileID,'(\n');
fprintf(fileID,');\n');

fprintf(fileID,h8);
