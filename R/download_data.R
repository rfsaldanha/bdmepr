#' Download BDMEP files
#'
#' This function download BDMEP files from INMET
#'
#' @param year numeric. From 200 to current year.
#' @param destpath character. Destination path to the file.
#' @param quiet logical. Print messages and progress bar on console.
#' @param unzip_file logical. Unzip file after downloading.
#'
#' @return The file list of the destination path.
#' @export

download_data <- function(year, destpath, quiet = FALSE, unzip_file = TRUE) {
  # Assertions
  checkmate::assert_numeric(
    x = year,
    lower = 2000,
    upper = as.integer(substr(Sys.Date(), 0, 4))
  )
  checkmate::assert_path_for_output(x = destpath, overwrite = TRUE)
  checkmate::assertLogical(quiet)
  checkmate::assertLogical(unzip_file)

  # Check internet and INMET website access
  if (check_internet() == FALSE) {
    cli::cli_alert_warning(
      "It appears that your local Internet connection is not working or INMET website is down. No file was downloaded. Try it again later..."
    )
    return(NULL)
  }

  # INMET base url
  base_url <- "https://portal.inmet.gov.br/uploads/dadoshistoricos/"

  # Print file name
  if (quiet == FALSE) cli::cli_alert_info(fs::path(base_url, year, ext = "zip"))

  # Download file
  curl::curl_download(
    url = fs::path(base_url, year, ext = "zip"),
    destfile = fs::path(destpath, year, ext = "zip"),
    quiet = quiet
  )

  # Unzip file
  if (unzip_file == TRUE) {
    if (quiet == FALSE) cli::cli_alert_info("Unziping file...")

    utils::unzip(
      zipfile = fs::path(destpath, year, ext = "zip"),
      exdir = destpath
    )

    if (quiet == FALSE) cli::cli_alert_info("File unziped!")
  }

  # Return
  return(fs::dir_ls(path = destpath, recurse = TRUE))
}
