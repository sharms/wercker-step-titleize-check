# Wercker Step Titleize Check

This step will use the [titleize gem](https://github.com/granth/titleize) to scan markdown files, find title: tags and check their capitalization. 

# Example wercker.yml (Classic)

```yml
box: wercker/default
build:
  steps:
    - sharms/wercker-step-titleize-check@1.0.3
```
