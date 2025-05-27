#' @importFrom rlang .data
parse_bdmep <- function(file) {
  # Variables abbreviated names and types
  data_col_names <- c(
    "data",
    "hora",
    "prec_total",
    "press",
    "press_max",
    "press_min",
    "rad",
    "temp_sec",
    "temp_orv",
    "temp_max",
    "temp_min",
    "temp_orv_max",
    "temp_orv_min",
    "umid_rel_min",
    "umid_rel_max",
    "umid_real",
    "vento_dir",
    "vento_raj",
    "vento_veloc"
  )
  data_col_types <- c("ccnnnnnnnnnnnnnnnnn")

  # Parse header
  header <- parse_header(file = file)

  # CSV file reading with encoding, skip the header
  tmp <- readr::read_delim(
    file = file,
    skip = 9,
    col_names = data_col_names,
    col_types = data_col_types,
    delim = ";",
    na = c("", "NA", "-9999", -9999),
    locale = readr::locale(
      encoding = "latin1",
      decimal_mark = ",",
      grouping_mark = "."
    )
  ) |>
    # Remove junk variable
    dplyr::select(-"X20") |>
    # Parse correct date and time
    dplyr::mutate(
      datetime = lubridate::parse_date_time(
        x = paste(.data$data, .data$hora),
        tz = "UTC",
        orders = c(
          "%Y/%m/%d %H%M",
          "%Y/%m/%d %H:%M",
          "%Y-%m-%d %H%M",
          "%Y-%m-%d %H:%M"
        )
      ) |>
        lubridate::with_tz(tzone = "UTC")
    ) |>
    # Add station code and name from header
    dplyr::mutate(
      station_cod = dplyr::pull(header[4, 2]),
      station_name = dplyr::pull(header[3, 2])
    ) |>
    # Remove original date and time
    dplyr::select(-"data", -"hora") |>
    # Relocate select(-data, -hora)
    dplyr::relocate("station_cod", "station_name", "datetime")

  # Return result
  return(tmp)
}
