class Api::BookingsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_room

  def create
    booking = @room.bookings.new(booking_params)
    booking.set_total_price

    if booking.save
      render status: 200, json: {
        message: "Booking successfully created",
        room: @room,
        booking: booking
      }.to_json
    else
      render status: 422, json: {
        message: "Booking could not be created",
        errors: booking.errors
      }.to_json
    end
  end

  private

def set_room
    @room = Room.find(params[:room_id])
  end

  def booking_params
    params.require(:booking).permit(:starts_at, :ends_at, :price)
  end
end
