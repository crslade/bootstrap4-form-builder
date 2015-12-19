$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "bootstrap4_form_builder/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "bootstrap4_form_builder"
  s.version     = Bootstrap4FormBuilder::VERSION
  s.authors     = ["Christopher Slade"]
  s.email       = ["crslade@gmail.com"]
  s.homepage    = "https://github.com/crslade/bootstrap4-form-builder"
  s.summary     = "Rails form builder that makes it easy to create forms using Twitter Bootstrap 4+"
  s.description = "Bootstrap Form Builder is a rails form builder that generates the appropriate HTML to be able to quickly create forms using Twitter Bootstrap 4+"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "> 4.2.4"

  s.add_development_dependency "sqlite3"
end
