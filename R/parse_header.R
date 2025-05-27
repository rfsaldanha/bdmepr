parse_header <- function(file) {
  readr::read_delim(
    file = file,
    n_max = 8,
    col_names = c("name", "value"),
    col_types = c("cc"),
    delim = ";",
    locale = readr::locale(
      encoding = "latin1",
      decimal_mark = ",",
      grouping_mark = "."
    )
  )
}
