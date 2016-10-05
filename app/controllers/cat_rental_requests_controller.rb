class CatRentalRequestsController < ApplicationController
  before_action :set_cat_rental_request, only: [:approve, :deny]

  def new
    @cat_rental_request = CatRentalRequest.new
    @selected_cat = params[:cat_id] ? params[:cat_id].to_i : 1
    @cats = Cat.all
  end

  def create
    cat_rental_request = CatRentalRequest.new(required_params)
    cat_rental_request.status = 'PENDING'

    if cat_rental_request.save
      redirect_to cat_url(cat_rental_request.cat_id)
    else
      flash[:errors] = cat_rental_request.errors.full_messages
      redirect_to new_cat_rental_request_url
    end
  end

  def approve
    @cat_rental_request.approve!
    redirect_to cat_url(@cat_rental_request.cat_id)
  end

  def deny
    @cat_rental_request.deny!
    redirect_to cat_url(@cat_rental_request.cat_id)
  end

  private
    def set_cat_rental_request
      @cat_rental_request = CatRentalRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def required_params
      params.require(:cat_rental_request).permit(:start_date, :end_date, :cat_id, :plea)
    end
end
