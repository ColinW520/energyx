class RegistrationsController < ApplicationController
  before_action :set_registration, only: [:show, :edit, :update, :destroy]
  layout 'registrations'

  # GET /registrations
  # GET /registrations.json
  def index
    @registrations = Registration.all
  end

  # GET /registrations/1
  # GET /registrations/1.json
  def show
  end

  # GET /registrations/new
  def new
    @type = params[:type]
    @registration = Registration.new(subtype: params[:type])

    if @type == 'team'
      2.times do @registration.registration_members.build end
    end
  end

  # GET /registrations/1/edit
  def edit
    @type = @registration.subtype
  end

  # POST /registrations
  # POST /registrations.json
  def create
    @registration = Registration.new(registration_params)

    # Amount in cents
    @amount = @registration.subtype == 'team' ? 7000 : 4000

    customer = Stripe::Customer.create(
      :email => params[:stripeEmail],
      :source  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'EnergyX Resolve To Row',
      :currency    => 'usd'
    )

    @registration.is_paid = true if customer && charge
    @registration.stripe_customer_id = customer.id
    @registration.stripe_charge_id = charge.id

    respond_to do |format|
      if @registration.save
        format.html { redirect_to @registration, notice: 'We have successfully created your registration! Your card has also been chared. Please Print this page for your records.' }
        format.json { render :show, status: :created, location: @registration }
      else
        format.html { render :new }
        format.json { render json: @registration.errors, status: :unprocessable_entity }
      end
    end

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_registration_path(@registration)
  end

  # PATCH/PUT /registrations/1
  # PATCH/PUT /registrations/1.json
  def update
    respond_to do |format|
      if @registration.update(registration_params)
        format.html { redirect_to @registration, notice: 'Registration was successfully updated.' }
        format.json { render :show, status: :ok, location: @registration }
      else
        format.html { render :edit }
        format.json { render json: @registration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /registrations/1
  # DELETE /registrations/1.json
  def destroy
    @registration.destroy
    respond_to do |format|
      format.html { redirect_to registrations_url, notice: 'Registration was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_registration
      @registration = Registration.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def registration_params
      params.require(:registration).permit(:is_paid, :name, :subtype, :phone, :email, registration_members_attributes: [:id, :name, :email, :phone, :_destroy])
    end
end
