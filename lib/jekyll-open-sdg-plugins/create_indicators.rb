require "jekyll"
require_relative "helpers"

module JekyllOpenSdgPlugins
  class CreateIndicators < Jekyll::Generator
    safe true
    priority :normal

    def generate(site)
      # If site.create_indicators is set, create indicators per the metadata.
      if site.config['languages'] and site.config['create_indicators']
        # Decide what layout to use for the indicator pages.
        layout = 'indicator'
        if site.config['create_indicators'].key?('layout')
          layout = site.config['create_indicators']['layout']
        end
        # See if we need to "map" any language codes.
        languages_public = Hash.new
        if site.config['languages_public']
          languages_public = opensdg_languages_public(site)
        end
        # Loop through the languages.
        site.config['languages'].each_with_index do |language, index|
          # Get the "public language" (for URLs) which may be different.
          language_public = language
          if languages_public[language]
            language_public = languages_public[language]
          end
          metadata = {}
          if opensdg_translated_builds(site)
            # If we are using translated builds, the metadata is underneath a
            # language code.
            metadata = site.data[language]['meta']
          else
            # Otherwise the 'meta' data is not underneath any language code.
            metadata = site.data['meta']
          end
          # Loop through the indicators (using metadata as a list).
          metadata.each do |inid, meta|
            # Add the language subfolder for all except the default (first) language.
            dir = index == 0 ? inid : File.join(language_public, inid)
            # Create the indicator page.
            site.collections['indicators'].docs << IndicatorPage.new(site, site.source, dir, inid, language, layout)
            # Create the indicator config page on staging sites.
            if site.config['environment'] == 'staging'
              dir = File.join(dir, 'config')
              site.collections['pages'].docs << IndicatorConfigPage.new(site, site.source, dir, inid, language, meta)
            end
          end
        end
      end
    end
  end

  # A Page subclass used in the `CreateIndicators` class.
  class IndicatorPage < Jekyll::Page
    def initialize(site, base, dir, inid, language, layout)
      @site = site
      @base = base
      @dir  = dir
      @name = 'index.html'

      self.process(@name)
      self.data = {}
      self.data['indicator_number'] = inid.gsub('-', '.')
      self.data['layout'] = layout
      self.data['language'] = language
      # Backwards compatibility:
      self.data['indicator'] = self.data['indicator_number']
    end
  end

  # A Page subclass used in the `CreateIndicators` class.
  class IndicatorConfigPage < Jekyll::Page
    def initialize(site, base, dir, inid, language, meta)
      @site = site
      @base = base
      @dir  = dir
      @name = 'index.html'

      self.process(@name)
      self.data = {}
      self.data['indicator_number'] = inid.gsub('-', '.')
      self.data['config_type'] = 'indicator'
      self.data['layout'] = 'config-builder'
      self.data['language'] = language
      self.data['meta'] = meta
    end
  end
end
