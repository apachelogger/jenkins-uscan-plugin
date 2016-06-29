Jenkins::Plugin::Specification.new do |plugin|
  plugin.name = 'uscan'
  plugin.display_name = 'UScan SCM Plugin'
  plugin.version = '0.0.1'
  plugin.description = 'Description Yolo'

  plugin.url = 'https://github.com/melezhik/chef-plugin'
  plugin.uses_repository git: 'file:///home/me/src/git/jenkins-uscan-plugin'
  plugin.depends_on 'ruby-runtime', '0.12'
end
