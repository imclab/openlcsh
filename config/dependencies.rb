# dependencies are generated using a strict version, don't forget to edit the dependency versions when upgrading.
merb_gems_version = "1.0.15"
dm_gems_version   = "0.10.2"
do_gems_version   = "0.10.1"

# For more information about each component, please read http://wiki.merbivore.com/faqs/merb_components
dependency "merb-core", merb_gems_version 
dependency "merb-action-args", merb_gems_version
dependency "merb-assets", merb_gems_version  
dependency("merb-cache", merb_gems_version) do
  Merb::Cache.setup do
    register(Merb::Cache::FileStore) unless Merb.cache
  end
end
dependency "merb-helpers", merb_gems_version 
dependency "merb-mailer", merb_gems_version  
dependency "merb-slices", merb_gems_version  
dependency "merb-auth-core", merb_gems_version
dependency "merb-auth-more", merb_gems_version
dependency "merb-auth-slice-password", merb_gems_version
dependency "merb-param-protection", merb_gems_version
dependency "merb-exceptions", merb_gems_version
dependency "data_objects", do_gems_version
dependency "do_sqlite3", do_gems_version # If using another database, replace this
dependency "dm-core", dm_gems_version         
dependency "dm-aggregates", dm_gems_version   
dependency "dm-migrations", dm_gems_version   
dependency "dm-timestamps", dm_gems_version   
dependency "dm-types", dm_gems_version        
dependency "dm-validations", dm_gems_version  
dependency "dm-serializer", dm_gems_version   

dependency "merb_datamapper", merb_gems_version

dependency "pho", ">=0.4"
dependency "nokogiri", ">=1.4.0"
dependency 'ruby-openid', :require_as => 'openid'
dependency 'rdfobjects', ">= 0.3.1",:require_as => 'rdf_objects'
dependency 'geonames'