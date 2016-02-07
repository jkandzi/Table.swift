Pod::Spec.new do |s|
  s.name = 'Table.swift'
  s.version = '0.1.0'
  s.license = 'MIT'
  s.summary = 'Instantly draw beautiful tables to your terminal.'
  s.description = <<-DESC
                  Pretty print arrays to your terminal.
                  DESC
  s.platform = :osx
  s.homepage = 'https://github.com/jkandzi/Table.swift'
  s.social_media_url = 'http://twitter.com/justuskandzi'
  s.authors = { 'Justus Kandzi' => "jusus.kandzi@gmail.com" }
  s.source = { :git => 'https://github.com/jkandzi/Table.swift.git', :tag => s.version }
  s.source_files = 'Sources/*.swift'
  s.requires_arc = true
  s.osx.deployment_target = "10.9"
  s.module_name = 'Table'
end
