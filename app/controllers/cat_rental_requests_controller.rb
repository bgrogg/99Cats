class CatRentalRequestsController < ApplicationController

  def new
    @cats = Cat.all
    render :new
  end

  def create

    request = CatRentalRequest.new(cat_rental_requests_params)
    if request.save
      redirect_to cat_url(Cat.find_by(:id => request.cat_id))
    else
      redirect_to new_cat_rental_request_url
    end
  end


  private

  def cat_rental_requests_params
    params.require(:cat_rental_requests).permit(:cat_id, :start_date, :end_date)
  end
end
