class Notifier < ApplicationMailer

  def purchase_confirmation(order)
    @order = order
    @url  = 'http://hstore.dev/'
    mail(to: @order.user.email, subject: 'Purchase confirmation')
  end
end
