library(openalexR)

query <- oaQueryBuild(
  identifier=NULL,
  entity = "works",
  filter = "raw_affiliation_string.search:dresden",
  date_from = "2020-01-01",
  date_to = "2020-12-31",
  search=NULL,
  endpoint = "https://api.openalex.org/"
)

res <- oaApiRequest(
  query_url = query,
  total.count = FALSE,
  verbose = TRUE
)

# Requesting url: https://api.openalex.org/works?filter=raw_affiliation_string.search%3Adresden%2Cfrom_publication_date%3A2020-01-01%2Cto_publication_date%3A2020-12-31
# About to get a total of 43 pages of results with a total of 8469 records.

jsonlite::write_json(res, "data/raw-affiliation-string-dresden-2020--r-massimoaria.json")
saveRDS(res, "data/raw-affiliation-string-dresden-2020--r-massimoaria.RDS")

df <- oa2df(res, entity = "works")

write.csv(df, "data/raw-affiliation-string-dresden-2020--r-massimoaria.csv", row.names=FALSE)
# Error in utils::write.table(df, "data/raw-affiliation-string-dresden-2020--r-massimoaria.csv",  :
#  unimplemented type 'list' in 'EncodeElement'

readr::write_csv(df, "data/raw-affiliation-string-dresden-2020--r-massimoaria.csv", na="")

# ~~~ Create custom CSV output ~~~ #

oa2020json <- jsonlite::read_json("data/raw-affiliation-string-dresden-2020--r-massimoaria.json")

# Field Names
# "id"                      "doi"
# "title"                   "display_name"
# "relevance_score"         "publication_year"
# "publication_date"        "ids"
# "host_venue"              "type"
# "open_access"             "authorships"
# "cited_by_count"          "biblio"
# "is_retracted"            "is_paratext"
# "concepts"                "mesh"
# "alternate_host_venues"   "referenced_works"
# "related_works"           "abstract_inverted_index"
# "cited_by_api_url"        "counts_by_year"
# "updated_date"            "created_date"

# Field Names (authorships)
# "author_position"        "author"                 "institutions"
# "raw_affiliation_string"

# Field Names (host_venue)
# "id"           "issn_l"       "issn"         "display_name" "publisher"
# "type"         "url"          "is_oa"        "version"      "license"

# Field Names (alternate_host_venues)
# "id"           "display_name" "type"         "url"          "is_oa"
# "version"      "license"

# Field Names (open_access)
# "is_oa"     "oa_status" "oa_url"

oa2020_ids <- as.character(lapply(oa2020json, function(x) unlist(x$id)))
oa2020_types <- as.character(lapply(oa2020json, function(x) unlist(x$type)))
oa2020_types <- gsub("NULL", "", oa2020_types, fixed=TRUE)
oa2020_pys <- as.integer(lapply(oa2020json, function(x) unlist(x$publication_year)))
oa2020_dois <- as.character(lapply(oa2020json, function(x) unlist(x$doi)))
oa2020_dois <- gsub("character(0)", "", oa2020_dois, fixed=TRUE)
oa2020_dois <- gsub("NULL", "", oa2020_dois, fixed=TRUE)

oa2020_is_oa <- as.logical(lapply(oa2020json, function(x) {
    paste(lapply(x$open_access$is_oa, function(y) {
        y
    }))
}))

oa2020_oa_status <- as.character(lapply(oa2020json, function(x) {
    paste(lapply(x$open_access$oa_status, function(y) {
        y
    }))
}))

oa2020_oa_status <- gsub("character(0)", "", oa2020_oa_status, fixed=TRUE)

oa2020_host_venue_issn_ls <- as.character(lapply(oa2020json, function(x) {
    paste(lapply(x$host_venue$issn_l, function(y) {
        y
    }))
}))
oa2020_host_venue_issn_ls <- gsub("character(0)", "", oa2020_host_venue_issn_ls, fixed=TRUE)

oa2020_host_venue_issns <- as.character(lapply(oa2020json, function(x) {
    paste(lapply(x$host_venue$issn, function(y) {
        paste(unlist(y), collapse="~")
    }), collapse="|")
}))

oa2020_authorships_institution_id <- as.character(lapply(oa2020json, function(x) {
    paste(unlist(lapply(x$authorships, function(y) {
        paste(unlist(lapply(y$institutions, function(z) {
            z$id
        })), collapse="~")
    })), collapse="|")
}))

oa2020_authorships_institution_ror <- as.character(lapply(oa2020json, function(x) {
    paste(unlist(lapply(x$authorships, function(y) {
        paste(unlist(lapply(y$institutions, function(z) {
            z$ror
        })), collapse="~")
    })), collapse="|")
}))

oa2020_authorships_raw_affiliation_string <- as.character(lapply(oa2020json, function(x) {
    paste(unlist(lapply(x$authorships, function(y) {
        paste(unlist(lapply(y$raw_affiliation_string, function(z) {
            z
        })), collapse="~")
    })), collapse="|")
}))

oa2020df <- data.frame(
    id=oa2020_ids,
    types=oa2020_types,
    publication_year=oa2020_pys,
    is_oa=oa2020_is_oa,
    oa_status=oa2020_oa_status,
    doi=oa2020_dois,
    issn=oa2020_host_venue_issns,
    issn_l=oa2020_host_venue_issn_ls,
    author_institution_id=oa2020_authorships_institution_id,
    author_institution_ror=oa2020_authorships_institution_ror,
    author_institution_raw=oa2020_authorships_raw_affiliation_string,
    stringsAsFactors=FALSE
)

write.csv(oa2020df, "data/raw-affiliation-string-dresden-2020--r-massimoaria--custom.csv", row.names=FALSE, na="")
