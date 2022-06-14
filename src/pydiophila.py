from diophila import OpenAlex

openalex = OpenAlex("bibliometrie@slub-dresden.de")

api_url = "https://api.openalex.org/works?filter=raw_affiliation_string.search:dresden,publication_year:%3E2016"
call = openalex.get_works_by_api_url(api_url)
first_batch = next(call)

filters = {
    "raw_affiliation_string.search": "dresden",
    "publication_year": ">2016"
}
call = openalex.get_list_of_works(filters=filters, per_page=100)
first_batch = next(call)
