class AddEndangeredWorker
  require 'csv'
  include Sidekiq::Worker
  sidekiq_options retry:false

  # recieves params from perform_async calls in application code
  def perform(csv_file)
    CSV.foreach(csv_file, headers: true) do |shark|
      Endangered.create(name: shark[0], iucn: shark[1])
    end
  end

end
