class OrdersController < ApplicationController
  include SessionsHelper
  def show
    @order = Order.find_by(id: params[:id])
  end

  def create
    # 複数のデータを作成(削除)するので、トランザクションを行う
    ActiveRecord::Base.transaction do
      # ランダムな数字は注文番号として使用するが、重複がない様にチェックを行う
      # 重複があった場合に、ループ処理で重複がなくなるまでランダムな数字を変更する
      loop do
        @number = "%9d" % rand(999_999_999)
        check = Order.find_by(order_number: @number)
        break if check.blank?
      end
      @order = current_user.orders.create!(order_date: Time.zone.today, order_number: @number)
      # カート内の商品をそれぞれ注文詳細に登録するための処理
      shipment_status_id = ShipmentStatus.find_by(shipment_status_name: "準備中").id
      cart = current_user.cart
      cart.cart_items.each do |cart_item|
        @order.order_details.create!(order_quantity: cart_item.quantity, product_id: cart_item.product_id, shipment_status_id: shipment_status_id)
      end
      # カートの中身を空にする
      cart.destroy!
      Cart.create!(user_id: current_user.id)
    end
    flash[:succes] = t("notice.success_order")
    redirect_to purchase_completed_order_path(@order.id)
  rescue
    flash[:danger] = t("notice.failure_order")
    redirect_to cart_path
  end

  def purchase_completed
    @order = Order.find_by(id: params[:id])
  end
end
