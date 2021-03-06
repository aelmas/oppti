% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/analyze.R
\name{artImpute}
\alias{artImpute}
\title{Artificially miss and impute each data entry individually by ignoring
outlying values}
\usage{
artImpute(dat, ku = 6, marker.proc.list = NULL, miss.pstat = 0.4,
verbose = FALSE)
}
\arguments{
\item{dat}{an object of log2-normalized protein (or gene) expressions,
containing markers in rows and samples in columns.}

\item{ku}{an integer in [1,num.markers], upper bound on the number of
nearest neighbors of a marker.}

\item{marker.proc.list}{character array, the row names of the data to be
processed/imputed.}

\item{miss.pstat}{the score threshold for ignoring potential outliers
during imputation. miss.pstat = 1 ignores values outside of the density box
(i.e., 1st-3rd quartiles). The algorithm ignores values lying at least
(1/miss.pstat)-1 times IQR away from the box; e.g., use miss.pstat=1 to
ignore all values lying outside of the box; use miss.pstat=0.4 to ignore
values lying at least 1.5 x IQR away from the box; use miss.pstat=0 to
employ all data during imputation.}

\item{verbose}{logical, to show progress of the algorithm.}
}
\value{
the imputed data that putatively represents the expressions of the
markers in the (matched) normal states.
}
\description{
Infers the normal-state expression of a marker based on its
co-expression network, i.e., the weighted average of the marker's nearest
neighbors in the data. The returned imputed data will later be used to
elucidate dysregulated (protruding) events.
}
\examples{
dat = setNames(as.data.frame(matrix(1:(5*10),5,10),
row.names = paste('marker',1:5,sep='')), paste('sample',1:10,sep=''))
imputed = artImpute(dat, ku = 2)
}
