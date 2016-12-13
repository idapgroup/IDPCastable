Pod::Spec.new do |s|
  s.name      = "IDPCastable"
  s.version   = "0.1.0"
  s.summary   = "Chainable Swift typecasting"
  s.description  = <<-DESC
                     IDPCastable is a chainable casting type used to avoid excessive iflets and guards, whe you are working with multiple unrelated types expected under a single variable.
                     DESC
  s.homepage  = "https://github.com/idapgroup/IDPCastable"
  s.license   = { :type => "New BSD", :file => "LICENSE" }
  s.author    = { "IDAP Group" => "admin@idapgroup.com" }
  s.source    = { :git => "https://github.com/idapgroup/IDPCastable.git", 
                  :tag => s.version.to_s }

  # Platform setup
  s.requires_arc          = true  
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.tvos.deployment_target = '9.0'
  
  # Preserve the layout of headers in the Module directory
  s.header_mappings_dir   = 'Source'
  s.source_files          = 'Source/**/*.{swift,h,m,c,cpp}'
end


