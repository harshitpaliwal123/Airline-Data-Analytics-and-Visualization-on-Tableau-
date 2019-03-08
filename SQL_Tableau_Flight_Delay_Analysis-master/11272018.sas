libname test 'C:\Users\dkewon\Documents\sql\group\Group_assignment';
data airlines;
set test.airlines;
run;
proc print data=airlines;
title 'airline information';
run;
