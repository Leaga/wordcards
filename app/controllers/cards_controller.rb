class CardsController < ApplicationController

  respond_to :html

  before_filter ->{@card = Card.find(params[:id])}, only: [:edit, :update, :show, :destroy]


  def index
    @cards = Card.all.paginate(:page => params[:page])
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(params[:card])
    puts "lalalalal #{@card.image_src}"
    @card.image_src = 'no-icon.png' if params[:card][:image_src].empty?
    puts "lblblblbl #{@card.image_src }  empty?=#{params[:card][:image_src].empty?}"
    result = @card.save
    result || (render(action: :new) && return)
    redirect_to @card, notice: "Word card was successfully created"
  end

  def show
  end

  def edit
  end

  def update
    result = @card.update_attributes(params[:card])
    result || (render(action: :edit) && return)
    redirect_to @card, notice: "Word card was successfully updated"
  end

  def destroy
    @card.destroy
    redirect_to cards_path
  end
end
