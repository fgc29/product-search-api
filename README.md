# Product Search API

![Sample Screen Shot of Product Search API ](https://user-images.githubusercontent.com/6156896/43077055-437f04c6-8e54-11e8-960a-1d94e03a8a30.png)
## Getting started

``` shell
git clone git@github.com:fgc29/product-search-api.git
cd product-search-api
bundle
cd client
yarn
cd ..
rake db:create && rake db:migrate && rake db:seed
```

## Start App
``` shell
rails s -p 3001
yarn --cwd client start
```

## Approach

I decided to use the Levenshtein Distance Algorithm to be able capture products via 
a fuzzy match query. 

## Improvements

For a production ready application the use of pg-tgrm in postgresql would work or possibly
a gem that implements some fuzzy matching logic.