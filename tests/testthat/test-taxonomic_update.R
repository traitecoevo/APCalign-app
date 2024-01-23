test_that("reactive executes", {
  testServer(server_test, {
    session$setInputs(submit_button = 1,
                      names_input = "Acacia aneura",
                      full = TRUE,
                      taxonomic_splits = "most_likely_species")
    
    expect_named(dataInput())
    expect_s3_class(dataInput(), "data.frame")
    expect_equal(ncol(dataInput()), 21)
    expect_equal(nrow(dataInput()), 1)
  })
})


test_that("Output changes with inputs", {
  testServer(server_test, {
    session$setInputs(submit_button = 1,
                      names_input = "Acacia aneura",
                      full = FALSE,
                      taxonomic_splits = "return_all")
    
    expect_named(dataInput())
    expect_s3_class(dataInput(), "data.frame")
    expect_equal(ncol(dataInput()), 12)
    expect_equal(nrow(dataInput()), 3)
  })
})





