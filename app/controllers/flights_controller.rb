class FlightsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @all_flights = Flight.all
    gon.flights = Flight.all
  end

  def show
    # find flight by id
    @individual_flight = Flight.find(params[:id])
    # pass the data into your js
    gon.flight = Flight.find(params[:id])
    # alert the data into the screen

    # @all_passengers = @individual_flight.passengers
  end

  def edit
    @individual_flight = Flight.find(params[:id])
  end

  def new
    @new_flight = Flight.new
  end

  # RECEIVING A POST REQUEST TO CREATE
  def create
    @submitted_flight = Flight.new(filter_params)
    if @submitted_flight.save
      # ActionCable.server.broadcast(<stream>, <messages>)
      ActionCable.server.broadcast 'flight_update_channel',
                                    content: @submitted_flight,
                                    username: current_user

      redirect_to flights_path
    end


  end

  # RECEIVING A PUT/PATCH REQUEST TO UPDATE
  # put request from this url
  # /flights/:id/edit
  def update
    @updated_flight = Flight.find(params[:id])
    if @updated_flight.update(filter_params) # if this update is successful
      redirect_to flights_path
    end
  end

  # HANDLE A DELETE REQUEST
  def destroy
    @deleted_flight = Flight.find(params[:id])
    @deleted_flight.destroy

    redirect_to flights_path
  end

  private

  # filter method called by create and update
  def filter_params
    params.require(:flight).permit(:from, :to, :airline, :num_passenger)
  end
end
