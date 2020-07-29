Pod::Spec.new do |s|
  s.name = 'KPTimeAgo'
  s.version = '0.0.2'
  s.license = 'MIT'
  s.summary = 'Relative Time ago formate.'
  s.homepage = 'https://github.com/parth0072'
  s.author = 'Parth'
  s.source = { :git => 'https://github.com/parth0072/KPTimeAgo.git', :tag => s.version }
  s.swift_versions = ['5.0']
  s.module_name = 'KPTimeAgo'
  s.ios.deployment_target = '8.0'
  s.source_files = 'TimeAgo/*.swift'
end