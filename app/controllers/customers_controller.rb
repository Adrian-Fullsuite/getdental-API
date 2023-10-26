class CustomersController < ApplicationController
  before_action :authorized, except: [:create, :login]
  before_action :set_customer, only: %i[ show update destroy ]

  # GET /customers
  def index
    @customers = Customer.all

    render json: @customers
  end

  # GET /customers/1
  def show
    render json: @customer
  end

  # POST /customers
  def create
    @customer = Customer.new(customer_params)
    if @customer.valid? || @customer.save
      @customer.save
      token_exp = Time.now.to_i + 24 * 60 * 60
      token = encode_token({user_id: @customer.id, exp: token_exp})
      render json: {user: @customer, token: token}
    else
      render json: {error: 'Invalid username or passowrd'}
    end
  end

  def login
    @customer = Customer.find_by(email_address: params[:email_address])
    if @customer && @customer.authenticate(params[:password])
      token_exp = Time.now.to_i + 24 * 60 * 60
      token = encode_token({user_id: @customer.id, exp: token_exp})
      render json: {user: @customer, token: token}
    else
      render json: {error: 'Invalid username or passowrd'}
    end
  end

  # PATCH/PUT /customers/1
  def update
    if @customer.update(customer_params)
      render json: @customer
    else
      render json: @customer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /customers/1
  def destroy
    @customer.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def customer_params
      params.require(:customer).permit(:first_name, :middle_name, :last_name, :age, :email_address, :password, :password_confirmation)
    end
end
