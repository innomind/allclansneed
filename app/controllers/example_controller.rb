class ExampleController < ApplicationController
  def example
  end

  def index
    #@examples = Example.find :all
    #$site_id = 2
    bf = Example::BitField.new(20)
    bf[1] = 1
    @bf = bf
    
    @accs = Account.all
     tst = ""
    for n in 1..255 do
      tst << n
    end
    
    @accs.each do |acc|
      acc.mask = tst
      acc.save
    end
    #@accs[0].save
    @examples = Example.find_for_site :all
    
    render :action => 'example'
  end

end
