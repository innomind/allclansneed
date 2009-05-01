xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title @anchor.title
    xml.description "Threads"
    xml.link forum_url(@anchor)

    for thread in @threads
      xml.item do
        xml.title thread.title
        xml.description thread.forum_messages.collect{|m| m.message}.join("\n\n--Nachricht--\n").gsub("\n","<br>")
        xml.pubDate thread.created_at.to_s(:rfc822)
        xml.link forum_thread_url(thread)
      end
    end
  end
end
