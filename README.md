# OpenAlex API Client Review

For details on OpenAlex, see [10.48550/arXiv.2205.01833](https://doi.org/10.48550/arXiv.2205.01833)

## Tasks

- Find publications of authors associated with an academic institution in Dresden (Timespan: 2017-2022)

## Setup

```sh
# Repository
git clone --recurse-submodules git@github.com:herreio/openalex-client-review.git
cd openalex-client-review
# Python environment
python3 -m venv env
source env/bin/activate
pip install -r requirements.txt
# R environment
Rscript renv/activate.R
Rscript -e "renv::restore()"
```

## Clients

### Python

#### `openalexapi` ([dpriskorn](https://github.com/dpriskorn/OpenAlexAPI) / [PyPI](https://pypi.org/project/openalexapi/))

```py
import openalexapi
```

```txt
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "~/devel/herreio/openalex-client-review/env/lib/python3.8/site-packages/openalexapi/__init__.py", line 3, in <module>
    import requests
ModuleNotFoundError: No module named 'requests'
```

Package requirements are not yet properly specified.

```sh
pip install requests pydantic purl
```

#### `diophila` ([smierz](https://github.com/smierz/diophila) / [PyPI](https://pypi.org/project/diophila/))

### R

#### `openalex` ([kth-library](https://github.com/kth-library/openalex))

#### `openalexR` ([ekmaloney](https://github.com/ekmaloney/openalexR))

```r
renv::install("./libs/openalexR-ekmaloney")
```

#### `openalexR` ([massimoaria](https://github.com/massimoaria/openalexR) / [CRAN](https://cran.r-project.org/package=openalexR))

```r
renv::install("./libs/openalexR-massimoaria")
```

## Links

- [Client Libraries](https://docs.openalex.org/api#client-libraries) (Documentation)
