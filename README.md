# Baseline
A simple tool/function for baselining Windows computer systems via Powershell.
______________________________________________________________________________

Paste or open file into powershell.
______________________________________________________________________________
Call upon the function via "baseline"
______________________________________________________________________________
The script will initialize and start the first scan
______________________________________________________________________________
C:\Users\$loggedinuser\Baseline\ will be created in the logged in users directory.
______________________________________________________________________________
C:\Users\$loggedinuser\Baseline\\Scan1 file will be created within the C:\Users\$loggedinuser\Baseline\
______________________________________________________________________________
Prompt for "Post-Scan", in which this time you would run the application, virus or hardware first.
______________________________________________________________________________
Type "Y" for continuing to Post-Scan or Type "N" to just stop at the initial command.
______________________________________________________________________________
Continuing to Post-Scan runs another Scan and saves the files in C:\Users\$loggedinuser\Baseline\Scan2
______________________________________________________________________________
A "rawfile" will always be created, in which contains all information requested into one file for secondary comparison and exportation.
Rawfile is created at C:\Users\$loggedinuser\Baseline\Rawfile
______________________________________________________________________________
After the post-scan, the Initial-Scan and the Post-Scan will then be compared for differences.
______________________________________________________________________________
-JackerHones
