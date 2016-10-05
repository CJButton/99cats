class CatsController < ApplicationController
  before_action :set_cat, only: [:show, :edit, :update, :destroy]

  def index
    @cats = Cat.all
  end

  def show
  end

  def edit
    @colors = ["Blue", "Black", "Purple", "White", "Rainbow"]
  end

  def new
    @cat = Cat.new
    @colors = ["Blue", "Black", "Purple", "White", "Rainbow"]
  end

  def update
    @cat.update(required_params)
    redirect_to cat_url(@cat.id)
  end

  def destroy
    @cat.destroy
    redirect_to cats_url
  end

  def create
    cat = Cat.new(required_params)

    if cat.save
      redirect_to cats_url
    else
      # errors happening!!!
    end
  end

  private
  def set_cat
    @cat = Cat.find(params[:id])
  end

  def required_params
    params.require(:cat).permit(:name, :birth_date, :sex, :description, :color)
  end
end
