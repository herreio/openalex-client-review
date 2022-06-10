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
