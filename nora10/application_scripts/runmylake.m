#!/usr/bin/env octave -qf

%% usage: octave runmylake.m init par input starty m d endy m d outdir

clear all;
path(path, 'v12-kojioctave')
warning('off', 'all') 

arg_list = argv();

initfile = arg_list{1};
parfile = arg_list{2}; 
inputfile = arg_list{3};
m_start = [str2num(arg_list{4}), ...
           str2num(arg_list{5}), ...
           str2num(arg_list{6})]; 
m_stop = [str2num(arg_list{7}), ...
          str2num(arg_list{8}),...
          str2num(arg_list{9})]; 
outdir = arg_list{10};

global ies80 Eevapor;
test_time = 0;
Eevapor = 0;

tic
[zz,Az, Vz, tt, Qst, Kzt, Tzt, Czt, Szt, Pzt, Chlzt, PPzt, DOPzt, DOCzt, ...
 lambdazt, His, DoF, DoM, MixStat, Wt] ...
   = solvemodel_v12_1k(m_start, m_stop, initfile, 'lake', ...
                       inputfile, 'timeseries',  parfile, 'lake');    
run_time=toc
dlmwrite(strcat(outdir, '/Tzt.txt'), Tzt', ...
         'delimiter', ' ', ...
         'precision', '%.3f')

          