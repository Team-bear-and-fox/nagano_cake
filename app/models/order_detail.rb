class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order
  enum production_status: { production_unable: 0, production_pending: 1, in_production: 2, production_complete: 3 }

  def add_sub_total
    (item.value * 1.10).floor * amount
  end
end
def create
  @item = Item.find(cart_item_params[:item_id])
  @cart_items = current_customer.cart_items.all

  # 同じ商品がすでにカートに存在するか確認
  existing_cart_item = @cart_items.find_by(item_id: @item.id)

  if existing_cart_item
    # 同じ商品がある場合は数量を更新して保存
    existing_cart_item.amount += @cart_item.amount.to_i
    existing_cart_item.save
  else
    # 同じ商品がない場合は新しいCartItemを作成
    @cart_item = current_customer.cart_items.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.item_id = @item.id
    if @cart_item.save
      flash[:notice] = "カートに商品が追加されました。"
    else
      byebug
      redirect_to item_path(@item.id)
      return
    end
  end

  redirect_to cart_items_path
end
