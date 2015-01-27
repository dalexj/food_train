class TrainsController < ApplicationController
  def create
    @train = Train.new train_params.merge(group_id: params[:group_id])
    if options_count >= 2 && @train.save
      redirect_to group_path(params[:group_id])
    else
      @train.errors.add("train_options", ": must have at least 2") if options_count < 2
      @train_options = Train::MAX_OPTIONS.times.map { TrainOption.new }
      render :new
    end
  end

  def new
    @train = Train.new
    @train_options = Train::MAX_OPTIONS.times.map { TrainOption.new }
  end

  private
  def train_params
    params.require(:train).permit(:departure_time, train_options_attributes: [:place])
  end

  def options_count
    params["train"]["train_options_attributes"].reject{ |k,v| v["place"].empty? }.count
  end
end
