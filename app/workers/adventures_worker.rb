class AdventuresWorker
  include Sidekiq::Worker 


  def perform(library_id)
    library = Library.find(library_id)
    response = Typhoeus.get("#{library.url}/adventures.json")
    result = JSON.parse(response.body)
    result["adventures"].each do |remote_adventure|
      local_adventure = Adventure.find_by_guid(remote_adventure["guid"])
      if local_adventure 
        if remote_adventure["updated_at"] > local_adventure["updated_at"]
          local_adventure["title"], local_adventure["author"] = remote_adventure["title"], remote_adventure["author"]
          


        end
      else
        new_adventure = Adventure.create(title: remote_adventure["title"], author: remote_adventure["author"], guid: remote_adventure["guid"], library_id: library.id)
        remote_adventure["pages"].each do |page|
          Page.create(name: page["name"], text: page["text"], adventure_id: new_adventure.id)
        end
      end
    end 
  end
end      

#AdventuresWorker.new.perform(11) to test in rails C

#MUST HAVE redis, then sidekiq, then rails servers running
#redis = ~$ sudo redis-server  /etc/redis/redis.conf
#sidekiq =  ~$ sidekiq