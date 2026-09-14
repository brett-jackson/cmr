# Form base API request, or return piped request back
request_base <- function( req = NULL )
{
    # Create request if nothing was piped
    if ( is.null(req) )
    {
        # Create default request with CMR endpoint and EDL token
        req <- httr2::request(CMR_ENDPOINT)|> 
            httr2::req_url_path_append("search") |>
            httr2::req_headers(Authorization = Sys.getenv("EDL_TOKEN"))
    }
    return(req)
}


# Form request for concept id
request_concept <- function( req = NULL, concept_id )
{
    # Form base request if NULL
    req <- req |> request_base()
}

# Create request with temporal range or add temporal parameter to existing request
request_temporal <- function( req = NULL, time_range )
{
    # Check validity of temporal range parameter
    stopifnot(
        "time_range must be a string" = is.character(time_range)
    )
    
    # Form request
    req <- req |> 
        request_base() |> # Form base request if not provided by pipe
        req_url_query('temporal',time_range) # Add temporal parameter to url
}
# Send a CMR request
send_request <- function( req )
{
    httr2::req_perform(req)
}