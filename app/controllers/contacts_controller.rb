class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def confirm
    @contact = Contact.new(contact_params)
    @contact.user_id = @current_user.id

    # 内容に問題がなければ確認画面を表示する
    if @contact.valid?
      render :confirm
    # 内容に問題があればエラーメッセージを表示する
    else
      render :new
    end
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.user_id = @current_user.id

    if @contact.save
      redirect_to contacts_complete_path
    else
      render :new
    end
  end

  private
  def contact_params
    params.require(:contact).permit(:contact_name, :contact_email, :body)
  end
end
