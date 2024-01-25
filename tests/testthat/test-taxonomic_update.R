test_that("reactive executes", {
  skip_on_ci()
  
  testServer(server, {
    session$setInputs(submit = 1,
                      names_input = "Acacia aneura",
                      full = TRUE,
                      taxonomic_splits = "most_likely_species",
                      ident = FALSE)
    
    expect_named(update_lookup())
    expect_s3_class(update_lookup(), "data.frame")
    expect_equal(ncol(update_lookup()), 21)
    expect_equal(nrow(update_lookup()), 1)
  })
})


test_that("Output changes with inputs", {
  testServer(server, {
    session$setInputs(submit = 1,
                      names_input = "Acacia aneura",
                      full = FALSE,
                      taxonomic_splits = "return_all",
                      ident = FALSE)
    
    expect_named(update_lookup())
    expect_s3_class(update_lookup(), "data.frame")
    expect_equal(ncol(update_lookup()), 12)
    expect_equal(nrow(update_lookup()), 3)
  })
})





