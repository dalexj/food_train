class TrainsController < ApplicationController
  before_action :require_in_group, only: [:create]
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

  def destroy
    train = Train.find_by(id: params[:id])
    if train
      if current_user == train.group.owner
        redirect_to group_path(train.group)
        train.delete
      else
        redirect_to :back, notice: "Only the owner can do that"
      end
    else
      redirect_to :back, notice: "This train doesn't exist"
    end
  end

  private
  def train_params
    params.require(:train).permit(:departure_time, train_options_attributes: [:place])
  end

  def options_count
    params["train"]["train_options_attributes"].reject{ |k,v| v["place"].empty? }.count
  end

  def require_in_group
    group = Group.find_by(id: params[:group_id])
    return unless group
    unless group.has_user? current_user
      redirect_to group_path(group), notice: "you're not in this group"
    end
  end
end
