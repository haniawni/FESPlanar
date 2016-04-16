%% preamble
clear
clc
clearvars

%% load data

rhoCoeffs = load('rhoCoeffs');
rhoSCoeffs = rhoCoeffs.rhoSCoeffs;
rhoECoeffs = rhoCoeffs.rhoECoeffs;

ldotCoeffs = load('ldotCoeffs');
ldotSCoeffs = ldotCoeffs.ldotS;
ldotECoeffs = ldotCoeffs.ldotE;