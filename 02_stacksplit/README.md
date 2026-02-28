# StackSplit

### A plugin for multi-event shear wave splitting analyses in SplitLab

> [!NOTE]
> * No compatibility of StackSplit with MATLAB R2025a yet (please see [issue 12](https://github.com/yvonnefroehlich/splitlab-stacksplit/issues/12) for details).
>
> * Updated versions based on [StackSplit v3.0](https://github.com/michaelgrund/stacksplit/releases/tag/v3.0); changes are **not** contributed to the [original repository](https://github.com/michaelgrund/stacksplit/). 


StackSplit ([**_Grund 2017_**](https://doi.org/10.1016/j.cageo.2017.04.015)) is a plugin for the MATLAB toolbox
SplitLab ([**_Wüstefeld et al. 2008_**](https://www.sciencedirect.com/science/article/pii/S0098300407001859))
which allows applying multi-event techniques for shear wave splitting (SWS) measurements directly within the
main program.

For details regarding installation and usage, see the [UserGuide](https://github.com/yvonnefroehlich/splitlab-stacksplit/blob/main/02_stacksplit/StackSplit/Doc/StackSplit_userguide.md).


## Citation

If you make use of StackSplit in your work, please acknowledge the paper in which the program is described:

- [**_Grund M (2017)_**](https://doi.org/10.1016/j.cageo.2017.04.015).
  StackSplit - a plugin for multi-event shear wave splitting analyses in SplitLab.
  *Computers & Geosciences*, 105:43-50.
  https://doi.org/10.1016/j.cageo.2017.04.015.

It's recommended to cite also the included corrections:

- [**_Walsh E, Arnold R, Savage M K (2013)_**](https://doi.org/10.1002/jgrb.50386).
  Silver and Chan revisited.
  *Journal of Geophysical Research: Solid Earth*, 118(10):5500-5515.
  https://doi.org/10.1002/jgrb.50386.

- [**_Fröhlich Y, Grund M, Ritter J R R (2022)_**](https://doi.org/10.4401/ag-8781).
  On the effects of wrongly aligned seismogram components for shear wave splitting analysis.
  *Annals of Geophysics*, 66(2).
  https://doi.org/10.4401/ag-8781.


## Available stacking methods

StackSplit grants easy access to four stacking schemes with which single SWS measurements made with SplitLab can
be processed:

| Method | Concept | Specification | Publication |
| --- | --- | --- | --- |
| **WS**        | Stacking of error surfaces                   | Normalization on the minimum or maximum (depending on input) of each single surface                    | [**_Wolfe,&nbsp;Silver&nbsp;(1998)_**](https://doi.org/10.1029/97JB02023)                     |
| **RH**        | Modified WS method                           | Weighting on the SNR of each measurement; normalization regarding the available backazimuth directions | [**_Restivo,&nbsp;Helffrich&nbsp;(1999)_**](https://doi.org/10.1046/j.1365-246x.1999.00845.x) |
| **no weight** | Stacking of error surfaces                   | No weighting                                                                                           | [**_Wüstefeld&nbsp;(2007)_**](https://splitting.gm.univ-montp2.fr)                       |
| **SIMW**      | Simultaneous inversion of multiple waveforms | Waveform concentration and joint inversion in time domain                                              | [**_Roy&nbsp;et&nbsp;al.&nbsp;(2017)_**](https://doi.org/10.1093/gji/ggw470)                       |

![fig4github](https://user-images.githubusercontent.com/23025878/56716351-6d3d2a80-673a-11e9-8b34-2191c119d780.png)


## Releases and compatibility with SplitLab and MATLAB versions

| StackSplit | Date | Zenodo DOI | SplitLab | MATLAB |
| --- | --- | --- | --- | --- |
| [dev YF](https://github.com/yvonnefroehlich/splitlab-stacksplit) | | | [1.2.1](https://robporritt.wordpress.com/software/), 1.0.5 (not tested) | >= [2024b](https://mathworks.com/help/releases/R2024b/index.html) (< 2024b might work, but not tested yet) |
| [dev MG](https://github.com/michaelgrund/stacksplit) | | | [1.2.1](https://robporritt.wordpress.com/software/), 1.0.5 (not tested) | >= [2020a](https://mathworks.com/help/releases/R2020a/index.html) (< 2020a might work, but not tested yet) |
| [v3.0](https://github.com/michaelgrund/stacksplit/releases/tag/v3.0) | 2021/12/23 | [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.5802051.svg)](https://doi.org/10.5281/zenodo.5802051) | [1.2.1](https://robporritt.wordpress.com/software/), 1.0.5 (not tested) | >= [2020a](https://mathworks.com/help/releases/R2020a/index.html) (< 2020a might work, but not tested yet) |
| [v2.0](https://github.com/michaelgrund/stacksplit/releases/tag/v2.0) | 2019/06/28 | [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.7118716.svg)](https://doi.org/10.5281/zenodo.7118716) | [1.2.1](https://robporritt.wordpress.com/software/), 1.0.5 | >= [2014b](https://mathworks.com/company/newsroom/mathworks-introduces-new-features-in-matlab-and-simulink.html) (tested up to and including [2018b](https://mathworks.com/help/releases/R2018b/index.html)) |
| [v1.0](https://github.com/michaelgrund/stacksplit/releases/tag/v1.0) | 2017/04/04 | [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.464385.svg)](https://doi.org/10.5281/zenodo.464385) | [1.2.1](https://robporritt.wordpress.com/software/), 1.0.5 | <= [2014a](https://mathworks.com/company/newsroom/mathworks-announces-release-2014a-of-the-matlab-and-simulink-product-families.html) |

For details regarding the different StackSplit versions, see the [Changelog](https://github.com/yvonnefroehlich/splitlab-stacksplit/blob/main/02_stacksplit/changelog.md).


## References

- [**_Restivo A, Helffrich G (1999)_**](https://doi.org/10.1046/j.1365-246x.1999.00845.x).
  Teleseismic shear wave splitting measurements in noisy environments.
  *Geophysical Journal International*, 137:821-830.
  https://doi.org/10.1046/j.1365-246x.1999.00845.x.
- [**_Roy C, Winter A, Ritter J R R, Schweitzer J (2017)_**](https://doi.org/10.1093/gji/ggw470).
  On the improvement of SKS splitting measurements by the simultaneous inversion of multiple waveforms (SIMW).
  *Geophysical Journal International*, 208:1508–1523.
  https://doi.org/10.1093/gji/ggw470.
- [**_Wolfe C J, Silver P G (1998)_**](https://doi.org/10.1029/97JB02023).
  Seismic anisotropy of oceanic upper mantle: Shear wave splitting methodologies and observations.
  *Journal of Geophysical Research*, 103(B1):749-771,
  https://doi.org/10.1029/97JB02023.
- [**_Wüstefeld A (2007)_**](https://splitting.gm.univ-montp2.fr).
  Methods and applications of shear wave splitting: The East European Craton.
  *Ph.D. thesis*, Univ. de Montpellier, France.
  https://splitting.gm.univ-montp2.fr.
- [**_Wüstefeld A, Bokelmann G, Zaroli C, Barruol G (2008)_**](https://doi.org/10.1016/j.cageo.2007.08.002).
  SplitLab: A shear-wave splitting environment in Matlab.
  *Computers & Geosciences*, 34:515–528,
  https://doi.org/10.1016/j.cageo.2007.08.002.


## Funding

The presented research as well as MG and YF received support from various sources:

- MG
  - DFG grant RI1133/11-1 within the LITHOS-CAPP project
- YF
  - Scholarship of the [Graduate Funding from the German States](https://www.khys.kit.edu/english/graduate_funding.php)
  - [DFG Priority Program DeepDyn SPP 2404 – 500707704](https://www.geo.lmu.de/deepdyn/en/) (research assistant)
