class UsersController < ApplicationController
  def show
    @user = User.find_by(booking_link: params[:booking_link])
  end

   def free_event
    @free_events = BookingType.where(payement_required: false).includes(:user)
   end

end
