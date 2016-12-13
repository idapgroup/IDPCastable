Pod::Spec.new do |s|
  s.name      = "IDPCastable"
  s.version   = "0.1.0"
  s.summary   = "Chainable Swift typecasting without iflets and guards"
  s.homepage  = "https://github.com/idapgroup/IDPCastable"
  s.license   = { :type => "New BSD", :file => "LICENSE" }
  s.author    = { "IDAP Group" => "admin@idapgroup.com" }
  s.source    = { :git => "https://github.com/idapgroup/IDPCastable.git", 
                  :tag => s.version.to_s }

  # Platform setup
  s.requires_arc          = true  
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  
  # Preserve the layout of headers in the Module directory
  s.header_mappings_dir   = 'Source'
  s.source_files          = 'Source/**/*.{swift,h,m,c,cpp}'
end


