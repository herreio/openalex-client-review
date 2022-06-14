from openalexapi import OpenAlex

openalex = OpenAlex(email="bibliometrie@slub-dresden.de")

# https://api.openalex.org/works/doi:https://doi.org/10.1016/j.nonrwa.2021.103462
work = openalex.get_single_work("doi:10.1016/j.nonrwa.2021.103462")

# Traceback (most recent call last):
#   File "<stdin>", line 1, in <module>
#   File "~/devel/herreio/openalex-client-review/env/lib64/python3.8/site-packages/openalexapi/__init__.py", line 35, in get_single_work
#     return Work(**response.json())
#   File "pydantic/main.py", line 341, in pydantic.main.BaseModel.__init__
# pydantic.error_wrappers.ValidationError: 1 validation error for Work
# open_access -> oa_status
#   none is not an allowed value (type=type_error.none.not_allowed)

# https://api.openalex.org/works/W3215657048
work = openalex.get_single_work("W3215657048")

# Traceback (most recent call last):
#   File "<stdin>", line 1, in <module>
#   File "~/devel/herreio/openalex-client-review/env/lib/python3.8/site-packages/openalexapi/__init__.py", line 35, in get_single_work
#     return Work(**response.json())
#   File "pydantic/main.py", line 341, in pydantic.main.BaseModel.__init__
# pydantic.error_wrappers.ValidationError: 1 validation error for Work
# open_access -> oa_status
#   none is not an allowed value (type=type_error.none.not_allowed)
