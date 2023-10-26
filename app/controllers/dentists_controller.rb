class DentistsController < ApplicationController
  before_action :authorized, except: [:create, :login]
  before_action :set_dentist, only: %i[ show update destroy ]

  # GET /dentists
  def index
    @dentists = Dentist.all

    render json: @dentists
  end

  # GET /dentists/1
  def show
    render json: @dentist
  end

  # POST /dentists
  def create
    @dentist = Dentist.new(dentist_params)
    if @dentist.valid? || @dentist.save
      @dentist.save
      token_exp = Time.now.to_i + 24 * 60 * 60
      token = encode_token({user_id: @dentist.id, exp: token_exp})
      render json: {user: @dentist, token: token}
    else
      render json: {error: 'Invalid username or passowrd'}
    end
  end

  def login
    @dentist = Dentist.find_by(email_address: params[:email_address])
    if @dentist && @dentist.authenticate(params[:password])
      token_exp = Time.now.to_i + 24 * 60 * 60
      token = encode_token({user_id: @dentist.id, exp: token_exp})
      render json: {user: @dentist, token: token}
    else
      render json: {error: 'Invalid username or passowrd'}
    end
  end

  # PATCH/PUT /dentists/1
  def update
    if @dentist.update(dentist_params)
      render json: @dentist
    else
      render json: @dentist.errors, status: :unprocessable_entity
    end
  end

  # DELETE /dentists/1
  def destroy
    @dentist.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dentist
      @dentist = Dentist.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def dentist_params
      params.require(:dentist).permit(:first_name, :middle_name, :last_name, :email_address, :password, :password_confirmation)
    end
end
