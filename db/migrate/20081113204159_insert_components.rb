class InsertComponents < ActiveRecord::Migration
  def self.up
    # get the list of controllers just from the file-system
    #TODO: humanized names are subject to change, ok, the whole list should be hardcoded
    #(IO.popen "ls app/controllers/*.rb").read.split("\n").each do |filename|
    #  filename.gsub!(/^.*\//, '')
    #  filename.gsub!('.rb', '')
    #  unless filename == 'application'
    #    Component.create :name =>filename.gsub('_controller', '').humanize, :controller => filename#.split('_').collect{|part| part.capitalize}.join
    #  end
    #end
  end

  def self.down
    #Component.delete_all
  end
end
