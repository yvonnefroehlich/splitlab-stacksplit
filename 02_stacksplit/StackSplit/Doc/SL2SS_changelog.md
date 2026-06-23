For full functionality of StackSplit the following (original) SplitLab functions are modified or
added during the installation process. For the changes included in the original StackSplit repo the
related functions are marked with a asterix (*).

| Function | Changes | | Remark |
| --- | --- | --- | --- |
| splitlab.m*             | adjustments for implementation of StackSplit | modified | |
| geterrorbars.m*         | fixed taper and ndf calculation              | modified | see Walsh et al., 2013 |
| geterrorbarsRC.m*       | fixed taper and ndf calculation              | modified | see Walsh et al., 2013 |
| preSplit.m*             | adjustments to save new outputs temporary    | modified | |
| splitdiagnosticplot.m*  | adjustments to save new outputs temporary    | modified | |
| saveresult.m*           | adjustments to save new outputs finally      | modified | |
| database_editResults.m* | adjustments to avoid database conflicts      | modified | |
| seisfigbuttons.m*       | adjustments to avoid database conflicts      | modified | |
| getFileAndEQseconds.m*  | fixed start time extraction by SplitLab      | modified | v3.0, see Fröhlich et al., 2022) |
| checkmattaupclass.m*    | improvements to load matTaup Java class      | added    | v4.0 |
| SL_ttcurves.m           | | modified | |
| taupColor.m             | | added    | |
| taupCurve.m             | | modified | |
| taupLine.m              | | added    | |
| taupPath.m              | | modified | |
