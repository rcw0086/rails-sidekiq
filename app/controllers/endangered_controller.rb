class EndangeredController < ApplicationController
  before_action :set_endangered, only: [:index, :data]

  # GET /endangered/index
  def index
    if @endangered.length > 0
      redirect_to endangered_data_path
    else
      render 'index'
    end
  end

  # GET /endangered/data
  def data
  end

  # POST /endangered/upload
  def upload
    csv_file = File.join Rails.root, 'db', 'sharks.csv'
    AddEndangeredWorker.perform_async(csv_file)
    redirect_to endangered_data_path, n otice: 'Endangered sharks have been uploaded!'
  end

  # POST /endangered/destroy
  def destroy
    RemoveEndangeredWorker.performa_async
    redirect_to root_path
  end

  private

    def set_endangered
      @endangered = Endangered.all
    end

end
