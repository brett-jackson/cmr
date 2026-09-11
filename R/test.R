cmr_query <- function()
{
    req <- httr2::request(CMR_ENDPOINT)
    req |> 
        httr2::req_url_path_append("search","collections") |>
        httr2::req_headers(Authorization = Sys.getenv("EDL_TOKEN"))
    httr2::req_perform(req)
}