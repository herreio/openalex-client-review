# OpenAlex API Client Review

## Setup

```sh
# Repository
git clone git@github.com:herreio/openalex-client-review.git
cd openalex-client-review
# Python environment
python3 -m venv env
source env/bin/activate
pip install -r requirements.txt
# R environment
Rscript renv/activate.R
Rscript -e "renv::restore()"
```

## Links

- [Client Libraries](https://docs.openalex.org/api#client-libraries) (Documentation)

## Tests

### Python

```sh
pip install -r requirements.txt
```

#### `openalexapi`

##### Usage Example

```py
import openalexapi
```

```txt
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "/home/herre/devel/herreio/openalex-client-review/env/lib/python3.8/site-packages/openalexapi/__init__.py", line 3, in <module>
    import requests
ModuleNotFoundError: No module named 'requests'
```

Package requirements are not properly specified.

```sh
pip install requests pydantic purl
```

### R

```r
renv::restore()
```

#### `openalex` ([kth-library](https://github.com/kth-library/openalex))

#### `openalexR` ([massimoaria](https://github.com/massimoaria/openalexR))

##### Installation

```r
renv::install("./libs/openalexR-massimoaria")
```

#### `openalexR` ([ekmaloney](https://github.com/ekmaloney/openalexR))

##### Installation

```r
renv::install("./libs/openalexR-ekmaloney")
```
