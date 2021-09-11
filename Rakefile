require './constants'

desc 'build style'
task :style do
  sh "curl #{BASE_STYLE_URL} | ruby style.rb > docs/style.json"
end
