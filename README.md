# Analyze proteomics data of a single cohort

You can easily analyze outlying (dysregulated) markers for each sample
in a cohort. Lets generate a toy proteomics data for a cohort of 30
disease samples, each quantifying 100 proteins.

``` r
set.seed(1)
cohort1.proteomes = as.data.frame(matrix(abs(rnorm(100*30)), 100, 30)) 
rownames(cohort1.proteomes) = paste('marker', 1:100, sep = '')
colnames(cohort1.proteomes) = paste('cohort1.sample', 1:30, sep = '')
```

Outlier analysis is run by the `oppti` function:

``` r
library(oppti)
result = oppti(cohort1.proteomes)
```

The outlier scores of each marker in each sample are then returned in
the first element of the
result:

``` r
cohort1.outlier.scores = result[[1]] 
```

|          | cohort1.sample1 | cohort1.sample2 | cohort1.sample3 | cohort1.sample4 |
| -------- | --------------: | --------------: | --------------: | --------------: |
| marker1  |            0.11 |          \-0.28 |          \-0.31 |            0.12 |
| marker2  |          \-0.14 |          \-0.31 |            0.32 |          \-0.08 |
| marker3  |          \-0.10 |            0.16 |            0.55 |            0.65 |
| marker4  |            0.77 |          \-0.60 |          \-0.68 |          \-0.18 |
| marker5  |          \-0.30 |            0.02 |            1.62 |            1.01 |
| marker6  |            0.06 |            0.39 |            0.77 |            0.55 |
| marker7  |            0.01 |          \-0.05 |            0.00 |          \-0.06 |
| marker8  |            0.17 |            0.30 |          \-0.01 |          \-0.02 |
| marker9  |          \-0.21 |          \-0.48 |          \-0.80 |            0.02 |
| marker10 |          \-0.36 |            0.74 |          \-0.36 |          \-0.55 |

Example matrix of outlier scores, displayed for the first 10 proteins
(rows) and the first 4 samples (columns)

In this toy example, marker5 has a (somewhat) elevated outlier score in
sample3, suggesting a protruding expression in the disease state of
sample3 relative to a normal state (i.e., the consensus co-expression
network inferred for marker5). Note that a negative sign in the outlier
score indicates a negative dysregulation event, i.e., relatively “lower”
protein expression is expected in the observed disease state compared to
the normal state. The landscape of these aberrant expressions analyzed
for a cohort of individuals may serve for the discovery of personalized
actionable targets.

# Analyze proteomics data of multiple cohorts

For pan-cancer analyses, the normalized proteomics data from different
cohorts can be supplied to `oppti` in a list object. Lets generate
another toy proteomics data for a separate cohort of 20 disease samples,
each quantifying 80 proteins (say, 50 of which are overlapping with
those quantified in the first cohort).

``` r
cohort2.proteomes = as.data.frame(matrix(abs(rnorm(80*20)), 80, 20)) 
rownames(cohort2.proteomes) = paste('marker', 51:130, sep = '')
colnames(cohort2.proteomes) = paste('cohort2.sample', 31:50, sep = '')
```

To run `oppti` for both cohorts, the data are simply fed in a single
list object:

``` r
result = oppti(list(cohort1.proteomes,cohort2.proteomes))
```

Again, the outlier scores of each marker in each sample are returned in
the first element of the result.

``` r
outlier.scores = result[[1]]
```

However, this object is a list of 2 elements per se, corresponding to
two cohorts. To obtain the outlier scores of the first
cohort:

``` r
cohort1.outlier.scores = outlier.scores[[1]]
```

|          | cohort1.sample1 | cohort1.sample2 | cohort1.sample3 | cohort1.sample4 |
| -------- | --------------: | --------------: | --------------: | --------------: |
| marker1  |            0.11 |          \-0.28 |          \-0.31 |            0.12 |
| marker2  |          \-0.14 |          \-0.31 |            0.32 |          \-0.08 |
| marker3  |          \-0.10 |            0.16 |            0.55 |            0.65 |
| marker4  |            0.77 |          \-0.60 |          \-0.68 |          \-0.18 |
| marker5  |          \-0.30 |            0.02 |            1.62 |            1.01 |
| marker6  |            0.06 |            0.39 |            0.77 |            0.55 |
| marker7  |            0.01 |          \-0.05 |            0.00 |          \-0.06 |
| marker8  |            0.17 |            0.30 |          \-0.01 |          \-0.02 |
| marker9  |          \-0.21 |          \-0.48 |          \-0.80 |            0.02 |
| marker10 |          \-0.36 |            0.74 |          \-0.36 |          \-0.55 |

Example outlier scores in cohort1

Similarly, for the second cohort the outlier scores are obtained
by:

``` r
cohort2.outlier.scores = outlier.scores[[2]]
```

|          | cohort2.sample31 | cohort2.sample32 | cohort2.sample33 | cohort2.sample34 |
| -------- | ---------------: | ---------------: | ---------------: | ---------------: |
| marker51 |             0.08 |           \-0.28 |             0.23 |           \-0.17 |
| marker52 |           \-0.28 |           \-0.43 |           \-0.41 |             0.13 |
| marker53 |             0.25 |             0.29 |             0.00 |           \-0.13 |
| marker54 |             0.11 |           \-0.16 |             0.38 |           \-0.12 |
| marker55 |             0.32 |           \-0.20 |             0.67 |             0.61 |
| marker56 |           \-0.29 |             0.09 |           \-0.21 |             0.23 |
| marker57 |             0.50 |           \-0.07 |             0.38 |           \-0.40 |
| marker58 |           \-0.41 |             0.00 |             0.23 |             0.64 |
| marker59 |             0.19 |             0.15 |           \-0.15 |           \-0.03 |
| marker60 |             0.07 |           \-0.39 |             0.28 |           \-0.33 |

Example outlier scores in cohort2

One can analyze the markers in terms of outlying events they exhibit
across the cohort by using the `draw.sc.plots` flag. The outlier samples
will be marked on a scatter plot of the disease (observed) vs normal
(imputed) expressions. You can always set `panel.markers` parameter to
restrict your analysis to a specific set of
markers.

``` r
result = oppti(list(cohort1.proteomes,cohort2.proteomes), draw.sc.plots = TRUE,
    panel.markers = rownames(cohort1.proteomes)[46:55])
```

To dislay the summary results of the markers’ outlying events across
cohorts you can use
`draw.ou.plots`:

``` r
result = oppti(list(cohort1.proteomes,cohort2.proteomes), draw.ou.plots = TRUE,
    panel.markers = rownames(cohort1.proteomes)[46:55])
```
