test_that("names and output updates", {
  testServer(server_test, {
    session$setInputs(submit_button = 1,
                      names_input = "Acacia aneura",
                      full = FALSE,
                      taxonomic_splits = "most_likely_species")
    
    expect_named(dataInput())
    expect_s3_class(dataInput(), "data.frame")
  })
})


