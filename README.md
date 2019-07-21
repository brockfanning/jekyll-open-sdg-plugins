# jekyll-open-sdg-plugins

> 💎 Jekyll plugins for use with the Open SDG platform

This plugin provides some Jekyll functionality for the [Open SDG](https://github.com/open-sdg/open-sdg) platform.

The functionality provided consists of:

## 1. A "t" Liquid filter for translating strings.

Usage example:

```
{{ my_variable | t }}
```

## 2. Fill in missing fields to allow partially translated metadata.

This allows metadata to be translated, field-by-field as needed, in subfolders in the data repository.

## 3. Automatically create goal pages based on data.

This creates goal pages automatically based on the data, so that the site repository does not need to maintain a `_goals` folder. It depends on a `_config.yml` setting.

Usage example (in `_config.yml`):
```
create_goals:
  # This determines which layout is used to render the pages.
  layout: goal
```

## 4. Automatically create indicator pages based on data.

This creates indicator pages automatically based on the data, so that the site repository does not need to maintain a `_indicators` folder. It depends on a `_config.yml` setting.

Usage example (in `_config.yml`):
```
create_indicators:
  # This determines which layout is used to render the pages.
  layout: indicator
```

## 5. Automatically create 4 required pages.

This automates the creation of 4 required pages that all implementations of Open SDG will need. These consist of:

* the home page: /
* the indicators json page: /indicators.json
* the search results page: /search
* the reporting status page: /reporting-status

There are advanced options for overriding the location of these pages (see creae_pages.rb). But see the example below to use the defaults.

Usage example (in `_config.yml`):
```
create_pages: true
```

## 6. Automatically fetch remote data and translations.

This automates the fetching of the remote data (from the "data repository") and any remote translations.

Note: This feature is disabled if "jekyll_get_json" is in the site config. This was the older (more verbose) way to do this.

Usage example (in `_config.yml`):
```
remote_data_prefix: https://mygithuborg.github.io/my-data-repository
remote_translations:
  - https://open-sdg.github.io/sdg-translations/translations-0.6.0.json

```

For those interested in switching to this convenience feature, note that this makes the "jekyll_get_json" and "remotedatabaseurl" settings obsolete; so they can be removed.
