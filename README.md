# T2StartMapping
A MATLAB script to create T2* maps out of Multi-echo GRE MRI scans. This script uses a mono-exponential fit to achieve this.
'baseFileName': the base file name of the 'n' ME-GRE images acquired at 'n' difference echo times (TE).
'z_Rage': the range of slice numbers, within a 3D image, that we want to perform T2* fitting on.
'TEarr': an array of 'n' numbers representing the actual echo times (TE) used in ME-GRE scans
'Outfname': file name of the output T2* map
