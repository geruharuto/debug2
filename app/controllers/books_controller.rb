class BooksController < ApplicationController
  before_action :baria_user, only: [:edit]
  before_action :authenticate_user!

  def show
  	@book_find = Book.find(params[:id])
    @comment = BookComment.new
    @comments = @book_find.book_comments
    @user = User.find_by(id: @book_find.user_id)
    @book = Book.new
  end

  def index
    @book = Book.new
    @books = Book.all #一覧表示するためにBookモデルの情報を全てくださいのall
    @user = current_user
  end

  def create
  	@book = Book.new(book_params) #Bookモデルのテーブルを使用しているのでbookコントローラで保存する。
    @book.user_id = current_user.id
    @user = current_user
    if @book.save #入力されたデータをdbに保存する。
  		redirect_to book_path(@book), notice: "successfully created book!"#保存された場合の移動先を指定。
  	else
  		@books = Book.all
  		render :index
  	end
  end

  def edit
  	@book = Book.find(params[:id])
  end

  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		redirect_to book_path(@book), notice: "successfully updated book!"
  	else #if文でエラー発生時と正常時のリンク先を枝分かれにしている。
  		render "edit"
  	end
  end

  def destroy
  	book = Book.find(params[:id])
  	book.destroy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
  	params.require(:book).permit(:title, :body)
  end
  def baria_user
    show
    if current_user != @user
      redirect_to books_path
    end
   end

end
