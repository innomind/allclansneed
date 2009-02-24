module PollHelper
  def add_option_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, :poll_options, :partial => 'newoption', :object => PollOption.new
    end
  end
  
  def init_progress_bar
    content_for :header_tags do
      stylesheet_link_tag('poll')
    end
  end
  
  def progress_bar status = 50
    "<div id='progress_box'>
    <div id='progress_bar' style='width:#{status}%;'>#{status}%</div>
    </div>"
  end
end
