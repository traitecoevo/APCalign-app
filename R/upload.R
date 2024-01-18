#' Read uploaded file as a data frame
#' 
#' @param path path of file
#' @return vector of input names (first column of data frame)

upload_file <- function(path){
  # Read in the csv
  data_set <- read.csv(path)
  
  # Check if first column contains species name
  if(!is.character(data_set[,1]))
    stop("The first column must contain taxonomic names - see Getting Started")
  
  # Assign the first column as input names
  input_names <- data_set[,1]
}