class CardsController < ApplicationController
  before_action :set_card, only: [:show, :edit, :update, :update_position, :destroy]
  before_action :setup_board, only: [:index, :show, :new, :edit]

  # GET /cards
  # GET /cards.json
  def index
  end

  # GET /cards/1
  # GET /cards/1.json
  def show
  end

  # GET /cards/new
  def new
    @card = Card.new(list_id: params[:list])
  end

  # GET /cards/1/edit
  def edit
  end

  # POST /cards
  # POST /cards.json
  def create
    @card = Card.create_card(card_params)

    respond_to do |format|
      if @card.save
        format.html { redirect_to @card, notice: 'Card was successfully created.' }
        format.json { render :show, status: :created, location: @card }
      else
        format.html { render :new }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cards/1
  # PATCH/PUT /cards/1.json
  def update
    respond_to do |format|
      if @card.update(card_params)
        format.html { redirect_to @card, notice: 'Card was successfully updated.' }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { render :edit }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_position
    @card.update_position(params[:updown])

    respond_to do |format|
      format.html { redirect_to cards_url, notice: 'Card was moved.' }
      format.json { head :no_content }
    end
  end

  # DELETE /cards/1
  # DELETE /cards/1.json
  def destroy
    @card.delete_card

    respond_to do |format|
      format.html { redirect_to cards_url, notice: 'Card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end

    def setup_board
      @lists = List.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def card_params
      params.require(:card).permit(:title, :description, :list_id)
    end
end
