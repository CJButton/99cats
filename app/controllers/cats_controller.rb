class CatsController < ApplicationController
  def index
    @cats = Cat.all
  end

  def show
    @cat = Cat.find(params[:id])
  end

  def edit
    @colors = ["Blue", "Black", "Purple", "White", "Rainbow"]
    @cat = Cat.find(params[:id])
  end

  def new
    @colors = ["Blue", "Black", "Purple", "White", "Rainbow"]
  end

  def update
    @cat = Cat.find(params[:id])
    @cat.update(required_params)
    redirect_to cat_url(@cat.id)
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
  def required_params
    params.require(:cat).permit(:name, :birth_date, :sex, :description, :color)
  end
end
