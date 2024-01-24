test_that("load_file() handles input types", {
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


test_that("Upload works", {
testServer(server_test, {
  
  df <- data.frame(x = "Acacia sp.", y = 2)
  path_csv <- tempfile()
  utils::write.csv(df, path_csv, row.names = FALSE)
  
  session$setInputs(inputType = "upload",
                    file_input = list(datapath = path_csv),
                    submit_button = 1,
                    full = FALSE,
                    taxonomic_splits = "most_likely_species"
                    )
  
  expect_equal(dataInput()$original_name, df$x)
}
)
})
