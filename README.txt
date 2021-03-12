run_AnalysisOpticAtaxia.m
Ultimately calls crawfordCI.m

Explain rawData for neglect optic atxia project


I got the FREEPER_database.xls from MSc work. 

Next, I extracted participants data (for the 4 conditions) with matlab which 
(1) saves rawData_opticAtaxia.mat (as a backup)
(2) saves data.csv file with all data stacked on top of each other.
IMPORTANT Note on control sample (also see ControlDemographic_Database.xlsx)
- data collection  N = 14 (there was 1 more, but didnt finish experiment). 
- But we dropped 3 before processing as inappropriate controls (N=11):
- DM24: not gender matched.
- LB26: gluacoma
- RR01: missing eye tracking data
