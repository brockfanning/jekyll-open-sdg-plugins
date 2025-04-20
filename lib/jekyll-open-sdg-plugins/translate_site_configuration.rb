require "jekyll"
require_relative "helpers"

module JekyllOpenSdgPlugins
  class TranslateSiteConfiguration < Jekyll::Generator
    safe true
    priority :highest

    # Some site configuration settings need to be translated.
    def generate(site)

    site.data['translated_site_config'] = {}
    site.config['languages'].each_with_index do |language, index|
        puts language
        site.data['translated_site_config'][language] = {}
        puts site.data['translations'][language]
    end
  end
end
