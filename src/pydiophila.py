import json
from diophila import OpenAlex

openalex = OpenAlex("bibliometrie@slub-dresden.de")

works = openalex.get_list_of_works(filters={
  "raw_affiliation_string.search": "dresden",
  "publication_year": ">2016"
})

results = []

for batch in works:
    if isinstance(batch, dict) and "results" in batch:
        results.extend(batch["results"])

with open("data/raw-affiliation-string-dresden--py-diophila.json", "w") as f:
    json.dump(results, f)

works = openalex.get_list_of_works(filters={
  "raw_affiliation_string.search": "dresden",
  "publication_year": ">2016",
  "type": "book|book-chapter|dissertation|monograph|reference-book|proceedings|proceedings-article"
})

results = []

for batch in works:
    if isinstance(batch, dict) and "results" in batch:
        results.extend(batch["results"])

with open("data/raw-affiliation-string-dresden--type-selection--py-diophila.json", "w") as f:
    json.dump(results, f)
