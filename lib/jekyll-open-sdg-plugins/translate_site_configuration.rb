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
        reportingtype = site.data['data_fields']['reportingtype']
        reportingtype_global = site.data['data_fields']['reportingtype_global']
        reportingtype_national = site.data['data_fields']['reportingtype_national']
        reportingtype_key = reportingtype + '.' + reportingtype
        reportingtype_global_key = reportingtype + '.' + reportingtype_global
        reportingtype_national_key = reportingtype + '.' + reportingtype_national
        site.config['languages'].each_with_index do |language, index|
            site.data['translated_site_config'][language] = {}
            translated_settings = {}
            reportingtype_translated = opensdg_translate_key(
                reportingtype_key,
                site.data['translations'],
                language
            )
            if reportingtype_translated == reportingtype_key
                reportingtype_translated = reportingtype
            end
            reportingtype_global_translated = opensdg_translate_key(
                reportingtype_global_key,
                site.data['translations'],
                language
            )
            if reportingtype_global_translated == reportingtype_global_key
                reportingtype_global_translated = reportingtype_global
            end
            reportingtype_national_translated = opensdg_translate_key(
                reportingtype_national_translated,
                site.data['translations'],
                language
            )
            if reportingtype_national_translated == reportingtype_national_key
                reportingtype_national_translated = reportingtype_national
            end
            translated_settings['reportingtype'] = reportingtype_translated
            translated_settings['reportingtype_national'] = reportingtype_national_translated
            translated_settings['reportingtype_global'] = reportingtype_global_translated
            site.data['translated_site_config'][language]['data_fields'] = translated_settings
        end
    end
  end
end
