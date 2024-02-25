# Code Repository: Attention in Action - Peripheral Reaching Experiment
R & Matlab code for Bayesian analysis of a motion-tracking [dataset]([url](https://osf.io/q8nj6/)) from a rare neuropsychological stroke patient & control-group.

## Article
https://osf.io/preprints/psyarxiv/2qjfs

## Citation
Knights, E., Ford, C., McIntosh, R. D., & Rossit, S. (2021, September 6). Attention in Action: evidence from peripheral and bimanual reaching deficits in a single case study of visual neglect and extinction post-stroke.

### Analysis instructions for Experiment - Peripheral Reaching

Download preprocessed data from OSF (Experiment 1) to `./results/`:
https://osf.io/kmvhw/

Run analysis in R from the 'R' directory:
```r
source run_analysis.R
```

Run plotting in R from the 'R' directory:
```r
source recreate_article_figures.R
```

Data preprocessing and plotting was originally performed with matlab:
`run_AnalysisOpticAtaxia.m`
