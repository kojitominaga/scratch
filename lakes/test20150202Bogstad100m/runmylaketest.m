#!/usr/bin/env octave -qf

%% usage: octave runmylake.m init par input starty m d endy m d outdir

clear all;
path(path, '../v12-kojioctave')
warning('off', 'all') 

arg_list = argv();

initfile = 'init';
parfile = 'par'; 
inputfile = 'input';
m_start = [1969, 1, 1]; 
m_stop = [1975, 12, 31]; 
outdir = '.';

% need to take care of it
% individually 
newpar2 = 0.00745;
newpar5 = 0.2811;

global ies80 Eevapor;
test_time = 0;
Eevapor = 0;

dt = 1.0;

% tic

[In_Z, In_Az, tt, In_Tz, In_Cz, In_Sz, In_TPz, ...
 In_DOPz, In_Chlz, In_DOCz, In_TPz_sed, In_Chlz_sed, ...
 In_FIM, Ice0, Wt, Inflw, ...
 Phys_par, Phys_par_range, Phys_par_names, ...
 Bio_par, Bio_par_range, Bio_par_names] ...
    = modelinputs_v12_1b(m_start, m_stop, initfile, 'lake', ...
                         inputfile, 'timeseries',  parfile, 'lake', ...
                         dt);

Phys_par(2) = newpar2;
Phys_par(5) = newpar5;

[zz,Az, Vz, tt, Qst, Kzt, Tzt, Czt, Szt, Pzt, Chlzt, PPzt, DOPzt, DOCzt, ...
 lambdazt, His, DoF, DoM, MixStat, Wt] ...
    = solvemodel_v12_1k(m_start, m_stop, initfile, 'lake', ...
                        inputfile, 'timeseries',  parfile, 'lake', ...
                        In_Z, In_Az, tt, In_Tz, In_Cz, In_Sz, In_TPz, ...
                        In_DOPz, In_Chlz, In_DOCz, In_TPz_sed, In_Chlz_sed, ...
                        In_FIM, Ice0, Wt, Inflw, ...
                        Phys_par, Phys_par_range, Phys_par_names, ...
                        Bio_par, Bio_par_range, Bio_par_names);    
% run_time=toc
dlmwrite('Tzt.csv', Tzt(:, 731:end)', 'delimiter', ',', 'precision', '%.3f')
dlmwrite('His.csv', His(:, 731:end)', 'delimiter', ',', 'precision', '%.3f')
dlmwrite('Kzt.csv', Kzt(:, 731:end)', 'delimiter', ',', 'precision', '%.3f')
dlmwrite('lambdazt.csv', lambdazt(:, 731:end)', 'delimiter', ',', 'precision', '%.3f')
dlmwrite('Qst.csv', Qst(:, 731:end)', 'delimiter', ',', 'precision', '%.3f')

          
