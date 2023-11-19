class Public::AddressesController < ApplicationController
  def new
    @address = Address.new
  end
end
