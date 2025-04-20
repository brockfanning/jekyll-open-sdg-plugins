require "jekyll"
require_relative "helpers"

module JekyllOpenSdgPlugins
  class TranslateSiteConfiguration < Jekyll::Generator
    safe true
    priority :highest

    # Some site configuration settings need to be translated.
    def generate(site)

        if site.data['data_fields'].nil?
            site.data['data_fields'] = {}
        end
        if site.data['data_fields']['reportingtype'].nil?
            site.data['data_fields']['reportingtype'] = 'REPORTING_TYPE'
            site.data['data_fields']['reportingtype_national'] = 'N'
            site.data['data_fields']['reportingtypeglobal'] = 'G'
        end

        site.data['translated_site_config'] = {}
        site.config['languages'].each_with_index do |language, index|
            puts language
            site.data['translated_site_config'][language] = {}
            reportingtype = site.data['data_fields']['reportingtype']
            reportingtype_national = site.data['data_fields']['reportingtype_national']
            reportingtype_global = site.data['data_fields']['reportingtype_global']
            puts site.data['translations'][language][reportingtype]
        end
    end
  end
end
