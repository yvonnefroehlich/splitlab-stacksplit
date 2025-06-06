The following functions are essential to run StackSplit (besides the SplitLab package).
If any problem occurs or you have suggestions to make StackSplit better please don't hesitate to
open a new issue or PR on GitHub to give comments or address suggestions for improvements etc.

| Function | Description |
| --- | --- |
| install_StackSplit.m               | Run in command wdw to start installation process of StackSplit |
| SS_basic_settings.m                | Set/change basic settings |
| SS_calc_RH.m                       | Apply the RH method, calculate SNR-weight and BAZ-normalization |
| SS_calc_SIMW.m                     | Apply SIMW on selected waveforms using the predefined methods (RC,SC,EV) |
| SS_check_inputs.m                  | Check consistency of input data like sampling rate (apply resampling if necessary), phi-dt grid parameters etc. |
| SS_check_matlab_version.m          | Check current MATLAB version to avoid problems in some functions with R2014b or newer |
| SS_disp_Esurf_single.m             | Display single error surface of selected list entry |
| SS_gen_legends.m                   | Subfunction to generate the GUI legends with splits and nulls above listbox |
| SS_gen_stackresplot.m              | Generate output plot after using SAVE button in the surface stacking procedure |
| SS_gen_worldmap.m                  | Subfunction to generate the GUI world map for displaying the selected event locations |
| SS_geterrorbars_stack_Esurf.m      | Calculate errors for stacked surfaces |
| SS_layout.m                        | Generate GUI layout |
| SS_plates.mat                      | File containing the plate boundaries for the world map |
| SS_prep_SIMW.m                     | Display single and concatenated waveforms after selection in listbox |
| SS_read_SLresults.m                | Read individual single event results saved from SplitLab |
| SS_saveresults.m                   | Save multi-event results (error surfaces, SIMW) to mat-file |
| SS_splitdiagnosticLayout.m         | Generate layout for diagnostic plot using SIMW |
| SS_splitdiagnosticplot.m           | Make diagnostic plot using SIMW |
| SS_splitdiagnosticSetHeader.m      | Set header values for diagnostic plot using SIMW |
| SS_stack_Esurf.m                   | Calculate stacked error surface |
| SS_stacksplit_start.m              | Main function of StackSplit that is called by button Stacking via SplitLab |
| unistall_StackSplit.m              | Run in command wdw to uninstall StackSplit from your system |
