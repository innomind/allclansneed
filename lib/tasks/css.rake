require 'erb'

namespace :css do
  
  def load_yml
    File.open( 'config/css_layouts.yml' ) { |yf| @css_definitions = YAML::load( yf ) }
  end
  
  
  # erstellt die css Templates neu
  task :update do
    load_yml
    source_css = "app/views/layouts/default_style.css.erb"
    source_file = IO.read(source_css)
    @css_definitions.each do |style|
      dest_css = "public/stylesheets/#{style.first}/teststyle.css"

      template = ERB.new(source_file)
      @style = style[1]
      css_file = File.open(dest_css, "w")
      css_file.write template.result
      css.file.close 
    end
  end
end