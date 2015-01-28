class TrainOptionsController < ApplicationController
  before_action :require_in_group
  def new
    @train_option = TrainOption.new
    @back_to_group_path = find_group_path
  end

  def create
    @train_option = TrainOption.new(train_option_params.merge train_id: params[:train_id])
    if @train_option.save
      redirect_to find_group_path
    else
      render :new
    end
  end

  def require_in_group
    train = Train.find_by(id: params[:train_id])
    return unless train
    unless train.group.has_user? current_user
      redirect_to :back, notice: "you're not in this group"
    end
  end

  def train_option_params
    params.require(:train_option).permit(:place)
  end

  def find_group_path
    group_path(Train.find_by(id: params[:train_id]).group_id)
  end
end
