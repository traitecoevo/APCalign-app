test_that("load_file() handles all input types", {
  # Create sample data
  df <- data.frame(x = "Acacia sp.", y = 2)
  df_bad <- data.frame(x = 1, y = 2)
  
  path_csv <- tempfile()
  path_bad <- tempfile()
  
  utils::write.csv(df, path_csv, row.names = FALSE)
  utils::write.csv(df_bad, path_bad, row.names = FALSE)
  
  expect_equal(upload_file(path_csv), df$x)
  expect_error(upload_file(path_bad), label = "Bad first column")
})