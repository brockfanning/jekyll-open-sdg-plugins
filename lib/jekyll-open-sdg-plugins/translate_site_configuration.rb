require "jekyll"
require_relative "helpers"

module JekyllOpenSdgPlugins
  class TranslateSiteConfiguration < Jekyll::Generator
    safe true
    priority :highest

    # Some site configuration settings need to be translated.
    def generate(site)

        # Set some defaults in data_fields doesn't have reporting type.
        if site.data['data_fields'].nil?
            site.data['data_fields'] = {}
        end
        if site.data['data_fields']['reportingtype'].nil?
            site.data['data_fields']['reportingtype'] = 'REPORTING_TYPE'
        end
        if site.data['data_fields']['reportingtype_national'].nil?
            site.data['data_fields']['reportingtype_national'] = 'N'
        end
        if site.data['data_fields']['reportingtype_global'].nil?
            site.data['data_fields']['reportingtype_global'] = 'G'
        end

        site.data['translated_site_config'] = {}
        site.config['languages'].each_with_index do |language, index|
            site.data['translated_site_config'][language] = {}
            translated_settings = {}
            translated_settings['reportingtype'] = opensdg_translate_key(
                site.data['data_fields']['reportingtype'] + '.' + site.data['data_fields']['reportingtype'],
                site.data['translations'],
                language
            )
            translated_settings['reportingtype_national'] = opensdg_translate_key(
                site.data['data_fields']['reportingtype'] + '.' + site.data['data_fields']['reportingtype_national'],
                site.data['translations'],
                language
            )
            translated_settings['reportingtype_global'] = opensdg_translate_key(
                site.data['data_fields']['reportingtype'] + '.' + site.data['data_fields']['reportingtype_global'],
                site.data['translations'],
                language
            )
            site.data['translated_site_config'][language]['data_fields'] = translated_settings
            puts site.data['translated_site_config'][language]
        end
    end
  end
end
