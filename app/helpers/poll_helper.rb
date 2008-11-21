module PollHelper
  def add_option_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, :poll_options, :partial => 'newoption', :object => PollOption.new
    end
  end
end
