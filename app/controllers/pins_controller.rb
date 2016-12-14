class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:index, :show]

  respond_to :html

  def index
    @pins = Pin.all.order(created_at: :desc)
    respond_with(@pins)
  end

  def show
    respond_with(@pin)
  end

  def new
    @pin = current_user.pins.build
    respond_with(@pin)
  end

  def edit
  end

  def create
    @pin = current_user.pins.build(pin_params)
    if @pin.save
    respond_with(@pin) 
    flash[:notice] = "pin was successfully created"
    end
  end

  def update
    @pin.update(pin_params)
      respond_with(@pin) 
      flash[:notice] = "pin was successfully updated"
  end

  def destroy
    if @pin.destroy
      respond_with(@pin) 
      flash[:notice] = "pin was successfully deleted"
    end
  end

  private
    def set_pin
      @pin = Pin.find(params[:id])
    end

    def correct_user
      @pin = current_user.pins.find_by(id: params[:id])
      redirect_to pins_path, notice: "This is not your pin. Keep your hands to yourself!" if @pin.nil?
    end

    def pin_params
      params.require(:pin).permit(:description, :image)
    end
  end

