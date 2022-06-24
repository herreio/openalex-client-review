library(openalexR)

query <- oaQueryBuild(
  identifier=NULL,
  entity = "works",
  filter = "raw_affiliation_string.search:dresden",
  date_from = "2017-01-01",
  date_to = "2022-12-31",
  search=NULL,
  endpoint = "https://api.openalex.org/"
)

res <- oaApiRequest(
  query_url = query,
  total.count = FALSE,
  verbose = TRUE
)

# Requesting url: https://api.openalex.org/works?filter=raw_affiliation_string.search%3Adresden%2Cfrom_publication_date%3A2017-01-01%2Cto_publication_date%3A2022-12-31
# About to get a total of 214 pages of results with a total of 42768 records.

jsonlite::write_json(res, "data/raw-affiliation-string-dresden--r-massimoaria.json")
saveRDS(res, "data/raw-affiliation-string-dresden--r-massimoaria.RDS")

df <- oa2df(res, entity = "works")

# converting [=================>-------------]  57% eta:  5m
# Error in data.frame(au_id = l[["author"]]$id, au_name = l[["author"]]$display_name,  :
# arguments imply differing number of rows: 1, 0

# write.csv("res/openalex-raw-affiliation-string-dresden--r-massimoaria.csv", row.names=FALSE)
