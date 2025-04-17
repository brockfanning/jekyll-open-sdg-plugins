require "jekyll"
require_relative "helpers"

module JekyllOpenSdgPlugins
  class TranslateSiteConfiguration < Jekyll::Generator
    safe true
    priority :highest

    # Some site configuration settings need to be translated.
    def generate(site)

      if site.config['languages']
        site.config['languages'].each_with_index do |language, index|
          puts language
        end
        puts site.data['translations']
      end
    end
  end
end
