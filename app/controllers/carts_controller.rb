class CartsController < ApplicationController
  include SessionsHelper
  def show
    @cart_items = CartItem.where(cart_id: current_cart.id)
    @sum = 0
  end

  def confirmed_order
    # 複数のデータを作成(削除)するので、トランザクションを行う
    ActiveRecord::Base.transaction do
      number = "%9d" % rand(999_999_999)
      # ランダムな数字は注文番号として使用するが、重複がない様にチェックを行う
      check = Order.find_by(order_number: number)
      # 重複があった場合に、ループ処理で重複がなくなるまでランダムな数字を変更する
      while check.present?
        number = "%9d" % rand(999_999_999)
        check = Order.find_by(order_number: number)
      end
      order = current_user.orders.create!(order_date: Time.zone.today, order_number: number)
      # カート内の商品をそれぞれ注文詳細に登録するための処理
      shipment_status_id = ShipmentStatus.find_by(shipment_status_name: "準備中").id
      CartItem.all.each do |item|
        order.order_details.create!(order_quantity: item.quantity, product_id: item.product_id, shipment_status_id: shipment_status_id)
      end
      # カートの中身を空にする
      records = CartItem.where(cart_id: current_cart.id).destroy_all
      # destroy_all!などの例外を吐き出すメソッドがないため、下記でチェック
      unless records.all?(&:destroyed?)
        raise ActiveRecord::Rollback
      end
      # 下3行は、destroy_allを使わない方法です。これはカートごと削除することで、カートの中身をからにしています。どちらの方がいいと思いますか？
      # Cart.find_by(user_id: current_user.id).destroy!
      # @current_cart = nil
      # current_cart
    end
    flash[:succes] = t("notice.success_order")
    # TODO: ルート変更が必要、フロント購入完了画面へ
    redirect_to root_path
  rescue
    flash[:danger] = t("notice.failure_order")
    redirect_to user_cart_path(current_user.id)
  end
end
