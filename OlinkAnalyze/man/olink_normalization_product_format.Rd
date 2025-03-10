% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/olink_normalization_product.R
\name{olink_normalization_product_format}
\alias{olink_normalization_product_format}
\title{Formatting the output of olink_normalization_product for seamless use with
downstream Olink Analyze functions.}
\usage{
olink_normalization_product_format(
  bridged_df,
  df1,
  df1_project_nr,
  df2,
  df2_project_nr,
  reference_project
)
}
\arguments{
\item{bridged_df}{A "tibble" of Olink data in long format resulting from the
olink_normalization_product function.}

\item{df1}{First dataset to be used for normalization, pre-normalization.
Must match df1 used in olink_normalization product bridging.}

\item{df1_project_nr}{Project name of first dataset. Must match name used in
olink_normalization product bridging.}

\item{df2}{Second dataset to be used for normalization, pre-normalization.
Must match df2 used in olink_normalization product bridging.}

\item{df2_project_nr}{Project name of second dataset. Must match name used in
olink_normalization product bridging.}

\item{reference_project}{Project name of reference project. Must match name
used in olink_normalization product bridging and be one of df1_project_nr or
df2_project_nr.}
}
\value{
A "tibble" of Olink data in long format containing both input
datasets with the bridged NPX quantifications, with the above
modifications.
}
\description{
Replaces the NPX values of the non-reference project by the Median Centered
or QS Normalized NPX, according to the Bridging Recommendation. Edits the
BridgingRecommendation column to indicate whether an assay is NotBridgeable,
NotOverlapping, MedianCentering, or QuantileSmoothing bridged. Replaces
OlinkID by the concatenation of the Explore HT and Explore 3072 OlinkIDs to
record the OlinkIDs from both projects for bridgeable assays. Assays that are
NotBridgeable or NotOverlapping retain their original non-reference OlinkIDs
and NPX values. Replaces SampleID with the concatenation of SampleID and
Project to make unique sample IDs for downstream analysis. Removes internal
and external controls. Removes  MedianCenteredNPX, QSNormalizedNPX,
OlinkID_E3072 columns.
}
\examples{
\donttest{
# Bridge samples
bridge_samples <- intersect(
  x = unique(OlinkAnalyze:::data_ht_small$SampleID),
  y = unique(OlinkAnalyze:::data_3k_small$SampleID)
) |>
  (\(x) x[!grepl("CONTROL", x)])()

# Run olink_normalization_product
npx_br_data <- olink_normalization(
df1 = OlinkAnalyze:::data_ht_small,
df2 = OlinkAnalyze:::data_3k_small,
overlapping_samples_df1 = bridge_samples,
df1_project_nr = "Explore HT",
df2_project_nr = "Explore 3072",
reference_project = "Explore HT")

# Format output
npx_br_data_format <- OlinkAnalyze:::olink_normalization_product_format(
bridged_df = npx_br_data,
df1 = OlinkAnalyze:::data_ht_small,
df2 = OlinkAnalyze:::data_3k_small,
df1_project_nr = "Explore HT",
df2_project_nr = "Explore 3072",
reference_project = "Explore HT")

}
}
\author{
Danai G. Topouza
}
