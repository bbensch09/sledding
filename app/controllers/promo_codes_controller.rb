class PromoCodesController < ApplicationController
  before_action :set_promo_code, only: [:show, :edit, :update, :destroy]

  # GET /promo_codes
  # GET /promo_codes.json
  def index
    @promo_codes = PromoCode.all
  end

  # GET /promo_codes/1
  # GET /promo_codes/1.json
  def show
  end

  # GET /promo_codes/new
  def new
    @promo_code = PromoCode.new
  end

  # GET /promo_codes/1/edit
  def edit
  end

  def generate_2_ticket_bulk_promo_codes
    num_codes = 100
    array = (1..num_codes).to_a
    array.each do |i|
      last_id = PromoCode.any? ? PromoCode.last.id : 0
      new_id = last_id + 1
      PromoCode.create!({
        promo_code: "GROUPON_2019-WKDY-200#{new_id}",
        status: 'active', 
        discount: 100,
        discount_type: 'percent', 
        description: 'groupon 2-ticket weekday redemption', 
        single_use: true
      })
      puts "promo code created for GROUPON_2019-WKDY-200#{i}"
    end
    redirect_to '/promo_codes'
  end

  def generate_4_ticket_bulk_promo_codes
    num_codes = 100
    array = (1..num_codes).to_a
    array.each do |i|
      last_id = PromoCode.any? ? PromoCode.last.id : 0
      new_id = last_id + 1
      PromoCode.create!({
        promo_code: "GROUPON_2019-WKDY-400#{new_id}",
        status: 'active', 
        discount: 100,
        discount_type: 'percent', 
        description: 'groupon 4-ticket weekday redemption', 
        single_use: true
      })
      puts "promo code created for GROUPON_2019-WKDY-400#{i}"
    end
    redirect_to '/promo_codes'
  end


  # POST /promo_codes
  # POST /promo_codes.json
  def create
    @promo_code = PromoCode.new(promo_code_params)

    respond_to do |format|
      if @promo_code.save
        format.html { redirect_to @promo_code, notice: 'Promo code was successfully created.' }
        format.json { render :show, status: :created, location: @promo_code }
      else
        format.html { render :new }
        format.json { render json: @promo_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /promo_codes/1
  # PATCH/PUT /promo_codes/1.json
  def update
    respond_to do |format|
      if @promo_code.update(promo_code_params)
        format.html { redirect_to @promo_code, notice: 'Promo code was successfully updated.' }
        format.json { render :show, status: :ok, location: @promo_code }
      else
        format.html { render :edit }
        format.json { render json: @promo_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /promo_codes/1
  # DELETE /promo_codes/1.json
  def destroy
    @promo_code.destroy
    respond_to do |format|
      format.html { redirect_to promo_codes_url, notice: 'Promo code was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_promo_code
      @promo_code = PromoCode.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def promo_code_params
      params.require(:promo_code).permit(:promo_code, :status, :discount, :discount_type, :redemptions, :description, :single_use)
    end
end
