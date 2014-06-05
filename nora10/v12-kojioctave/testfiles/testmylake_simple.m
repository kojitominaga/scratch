
% Script to run MyLake (v_12) for Vansjo 
% Used in E-project Pcode
% by TSA, last modified 23.02.2005

clear all;
% $$$ path(path,'../air_sea') %path for air-sea toolbox
% $$$ path(path,'../v12') %path for MyLake model code
% $$$ path(path,'../v12_1') %path for MyLake model code

warning('off', 'all') %% Koji 06.10.10

global ies80 Eevapor;
test_time=0;
Eevapor=0;
% $$$ 
% $$$ load ../Vansjo_application/Observations/vansjoice.dat
% $$$ load ../Vansjo_application/Observations/vansjotemp.dat 
% $$$ 
% $$$ % [Obs_TP_Chla, trash]=xlsread('../Vansjo_application/Observations/Vansjo_TP_Chla84_05.txt'); % Koji changed 10.11.09
% $$$ Obs_TP_Chla=xlsread('../Vansjo_application/Observations/Vansjo_TP_Chla84_05.txt'); % Koji changed 10.11.09
% $$$ % furhter changed Koji 06.10.10 6 Oct 10
% $$$ Obs_TP_Chla(1:2, :)=[]; %%%%
% $$$ % year, month, day, TP, Chla
% $$$ load ../Vansjo_application/Observations/Obs_SS.dat; 
% $$$ % year, month, day, SS (mg/L)
% $$$ load ../Vansjo_application/Observations/Obs_PO4P.dat; 
% $$$ % year, month, day, PO4P (microg/L)

lake='Vansjo-Storefjorden';
year=1994;
m_start=[1994,5,1]; 
m_stop=[1994,6,1];
%m_stop=[2005,11,30];

initfile='VAN_init_v12.txt'; % Koji changed 10.11.09 
parafile='VAN_para_v12_1b.txt'; % Koji changed 10.11.09
inputfile='VAN_input_PGS84_00_v12.txt'; % Koji changed 10.11.09

tic
  [zz,Az,Vz,tt,Qst,Kzt,Tzt,Czt,Szt,Pzt,Chlzt,PPzt,DOPzt,DOCzt,Qzt_sed,lambdazt,...
        P3zt_sed,P3zt_sed_sc,His,DoF,DoM,MixStat,Wt] = ...
           = solvemodel_v12_1b_simple(m_start,m_stop,initfile,'lake',inputfile,'timeseries', parafile,'lake');    
run_time=toc
