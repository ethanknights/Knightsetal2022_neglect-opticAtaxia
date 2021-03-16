=================
Purpose
=================
The purpose of this matlab pipeline is to - 
(1) Print input for Crawford's Single Case Programs (to results/<variable>/*.txt)
(2) Produce plots

Run with -
run_AnalysisOpticAtaxia.m (ultimately calls crawfordCI.m)

Stats are printed, but statistical results in the paper are reported based 
on calculations which have different precision restrictions, using:
homepages.adbn.ac.uk/j.crawford/pages/dept/SingleCaseMethodsComputerPrograms.HTML


=================
Notes on rawData
=================
The FREEPER_database.xls was produced during my MSc by combining kine.csv's
from the QTMpreprocess.m GUI.

This matlab script will extract participants data (for the 4 conditions) to
(1) saves rawData.mat (as a backup)
(2) saves data.csv file with the final data and sample based on these exclusions:
Summary of ControlDemographic_Database.xlsx:
- data collection N = 14 (there was 1 additional control, who didnt finish experiment). 
- 3 controls were dropped before processing as inappropriate controls (N=11):
- LB26: gluacoma
- DM24: not gender matched
- RR01: missing eye tracking data

=================
Contact
=================
Ethan Knights
Stephanie Rossit


=================
Acknowledgements
=================
Thanks to Fraser Smith for writing crawfordCI.m.

