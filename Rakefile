require './constants'

desc 'build style'
task :style do
  sh "curl #{BASE_STYLE_URL} | ruby style.rb > docs/style.json"
end

desc 'host the site locally'
task :host do
  sh "budo -d docs"
end
