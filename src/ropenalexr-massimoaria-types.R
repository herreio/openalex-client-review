library(openalexR)

query <- oaQueryBuild(
  identifier=NULL,
  entity = "works",
  filter = "raw_affiliation_string.search:dresden,type:book|book-chapter|dissertation|monograph|reference-book|proceedings|proceedings-article",
  date_from = "2017-01-01",
  date_to = "2023-01-01",
  search=NULL,
  endpoint = "https://api.openalex.org/"
)

res <- oaApiRequest(
  query_url = query,
  total.count = FALSE,
  verbose = TRUE
)

# Requesting url: https://api.openalex.org/works?filter=raw_affiliation_string.search%3Adresden%2Ctype%3Abook%7Cbook-chapter%7Cdissertation%7Cmonograph%7Creference-book%7Cproceedings%7Cproceedings-article%2Cfrom_publication_date%3A2017-01-01%2Cto_publication_date%3A2023-01-01
# About to get a total of 37 pages of results with a total of 7317 records.

jsonlite::write_json(res, "data/raw-affiliation-string-dresden--type-selection--r-massimoaria.json")
saveRDS(res, "data/raw-affiliation-string-dresden--type-selection--r-massimoaria.RDS")

df <- oa2df(res, entity = "works")

write.csv(df, "data/raw-affiliation-string-dresden--type-selection--r-massimoaria.csv", row.names=FALSE)
# Error in utils::write.table(df, "data/raw-affiliation-string-dresden--type-selection--r-massimoaria.csv",  :
#   unimplemented type 'list' in 'EncodeElement'

readr::write_csv(df, "data/raw-affiliation-string-dresden--type-selection--r-massimoaria.csv", na="")

# ~~~ Create custom CSV output ~~~ #

oajson <- jsonlite::read_json("data/raw-affiliation-string-dresden--type-selection--r-massimoaria.json")

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

oa_ids <- as.character(lapply(oajson, function(x) unlist(x$id)))
oa_types <- as.character(lapply(oajson, function(x) unlist(x$type)))
oa_types <- gsub("NULL", "", oa_types, fixed=TRUE)
oa_pys <- as.integer(lapply(oajson, function(x) unlist(x$publication_year)))
oa_pds <- as.character(lapply(oajson, function(x) unlist(x$publication_date)))
oa_dois <- as.character(lapply(oajson, function(x) unlist(x$doi)))
oa_dois <- gsub("character(0)", "", oa_dois, fixed=TRUE)
oa_dois <- gsub("NULL", "", oa_dois, fixed=TRUE)

oa_is_oa <- as.logical(lapply(oajson, function(x) {
    paste(lapply(x$open_access$is_oa, function(y) {
        y
    }))
}))

oa_oa_status <- as.character(lapply(oajson, function(x) {
    paste(lapply(x$open_access$oa_status, function(y) {
        y
    }))
}))

oa_oa_status <- gsub("character(0)", "", oa_oa_status, fixed=TRUE)

oa_host_venue_issn_ls <- as.character(lapply(oajson, function(x) {
    paste(lapply(x$host_venue$issn_l, function(y) {
        y
    }))
}))
oa_host_venue_issn_ls <- gsub("character(0)", "", oa_host_venue_issn_ls, fixed=TRUE)

oa_host_venue_issns <- as.character(lapply(oajson, function(x) {
    paste(lapply(x$host_venue$issn, function(y) {
        paste(unlist(y), collapse="~")
    }), collapse="|")
}))

oa_authorships_institution_id <- as.character(lapply(oajson, function(x) {
    paste(unlist(lapply(x$authorships, function(y) {
        paste(unlist(lapply(y$institutions, function(z) {
            z$id
        })), collapse="~")
    })), collapse="|")
}))

oa_authorships_institution_ror <- as.character(lapply(oajson, function(x) {
    paste(unlist(lapply(x$authorships, function(y) {
        paste(unlist(lapply(y$institutions, function(z) {
            z$ror
        })), collapse="~")
    })), collapse="|")
}))

oa_authorships_raw_affiliation_string <- as.character(lapply(oajson, function(x) {
    paste(unlist(lapply(x$authorships, function(y) {
        paste(unlist(lapply(y$raw_affiliation_string, function(z) {
            z
        })), collapse="~")
    })), collapse="|")
}))

oadf <- data.frame(
    id=oa_ids,
    type=oa_types,
    publication_date=oa_pds,
    publication_year=oa_pys,
    is_oa=oa_is_oa,
    oa_status=oa_oa_status,
    doi=oa_dois,
    issn=oa_host_venue_issns,
    issn_l=oa_host_venue_issn_ls,
    author_institution_id=oa_authorships_institution_id,
    author_institution_ror=oa_authorships_institution_ror,
    author_institution_raw=oa_authorships_raw_affiliation_string,
    stringsAsFactors=FALSE
)

write.csv(oadf, "data/raw-affiliation-string-dresden--type-selection--r-massimoaria--custom.csv", row.names=FALSE, na="")
