This is the repository for Global vaccine risk index using multiple data sources.

Final data and figures are generated using R version 3.6.3. 

Use make file to generate the figures and data.
```
make -f compile_data_figures.makefile
```

Following packages must be installed for the script to work:

- tidyverse
- ggcorrplot
- psych (Please install package mnormt version 1.5-7 using devtools before installing psych)
- GPArotation
- lavaan
- sf
- skimr (For viewing data summary)
- DescTools 



