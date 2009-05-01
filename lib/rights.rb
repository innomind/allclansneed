class Rights
  @@access_list = nil
  @@restful = {:index => "public", :show => "public", :new => "right", :create => "right", :edit => "right", :update => "right", :destroy => "right"}
  
  def self.load
    File.open( 'config/access.yml' ) { |yf| @@access_list = YAML::load( yf ) }
  end
  
  def self.lookup_class(lookup_class, action)
    self.load if @@access_list.nil?
    begin
      return @@access_list[lookup_class][action] unless @@access_list[lookup_class][action].nil?
      return @@restful[action.to_sym] unless @@access_list[lookup_class]["restful"].nil? || !@@restful[action].nil?
      return @@access_list[lookup_class]["default"]
    rescue NoMethodError
      return nil
    end
  end
end