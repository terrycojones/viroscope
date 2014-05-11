#!/bin/sh

if [ ! -f data/taxonomy.csv ]
then
    echo "Please run this script from the top-level viroscope directory." >&2
    exit 1
fi

./bin/000-taxonomy.coffee < data/taxonomy.csv |
./bin/001-properties.coffee data/properties.json data/viralzone.json |
./bin/003-canonicalize.coffee |
./bin/005-virion-size.coffee |
./bin/010-envelope-propagate-up.coffee |
./bin/010-genome-type-propagate-up.coffee |
./bin/010-host-propagate-up.coffee |
./bin/010-virion-size-propagate-up.coffee > data/taxonomy.json

test -d dist && cp data/taxonomy.json dist
