#Load reference results
refRes_file <- testthat::test_path('data','refResults.RData')
load(refRes_file)

#Load data with hidden/excluded assays (all NPX=NA)
load(file = test_path('data','npx_data_format221010.RData'))

#Run olink_wilcox
wilcox.test_results <- olink_wilcox(npx_data1, 'Treatment')

wilcox.test_results_paired <- npx_data1 %>% #Paired Mann-Whitney U Test
  filter(Time %in% c("Baseline","Week.6")) %>%
  olink_wilcox(variable = "Time", pair_id = "Subject")

test_that("Wilcox-test function works", {
  expect_equal(wilcox.test_results, ref_results$wilcox.test_results)  # compare results to ref
  expect_equal(as.matrix(wilcox.test_results_paired),
               as.matrix(ref_results$wilcox.test_results_paired))  # compare results to ref
  expect_error(olink_wilcox(df = npx_data1)) # no input data
  expect_error(olink_wilcox(npx_data1, "Time")) # more than 2 levels in the grouping variable

  expect_warning(olink_wilcox(npx_data_format221010, 'treatment1')) # data with all NPX=NA for some assays
})
