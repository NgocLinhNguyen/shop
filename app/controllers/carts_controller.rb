class CartsController < ApplicationController
  include ApplicationHelper	
  

  def edit
    # byebug
    session[:cart_id] = Cart.last.id
    @cart = Cart.find_by(id: session[:cart_id])
    if(@cart.cartItems.count == 0)
      redirect_to root_path
    end

    product_id= params[:id]
    if (params[:product_id])
      if (session[:cart_id] && Cart.find_by(id:session[:cart_id]))
         if Cart.find_by(id:session[:cart_id]).cartItems.find_by(product_id: params[:product_id])
           Cart.find_by(id:session[:cart_id]).cartItems.find_by(product_id: params[:product_id]).update_attribute(:quantity, params[:quantity])
         else
           Cart.find_by(id:session[:cart_id]).cartItems.build(product_id: product_id, quantity:params[:quantity]).save
         end
         # byebug
      else
          @cart=Cart.new()
          @cart.save
          session[:cart_id] = Cart.last.id
          @cart.cartItems.build(product_id: product_id, quantity:params[:quantity]).save
      end
      render :nothing => true
    else
      # byebug
      @cart = Cart.find(session[:cart_id])

    end
    
  end


  def show
    session[:cart_id] = Cart.last.id
    @cart = Cart.find_by(id: session[:cart_id])
    if @cart.cartItems.count != 0
      
    else
      redirect_to root_path
    end
    
  end


  def destroy
   session[:cart_id] = nil
   @cart=Cart.new()
   @cart.save
   session[:cart_id] = @cart.id
   redirect_to root_path
  end

  def update
    @cart = Cart.find_by(id: session[:cart_id])
    @cart.update_attributes(cart_params)
    redirect_to edit_cart_path
  end

  private
    def create
      cart=Cart.new()
      session[:cart_id] = cart.id
    end

    def cart_params
      params.require(:cart).permit(cartItems_attributes:[:quantity, :id, :_destroy])
    end


end
