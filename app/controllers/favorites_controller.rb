class FavoritesController < ApplicationController
	def create
		@book = Book.find(params[:book_id])
		@favorite = @book.favorites.new(user_id: current_user.id) #2,3行目が大事（ネスト型のため）
        #@favorite = Favorites.new(user_id: current_user.id, book_id: params[:book.id])
        @favorite.save
        #@favorites = @book.favorites.count
        redirect_to request.referer #現在ページを返す

    end
    def destroy
    	@book = Book.find(params[:book_id])
        @favorite = @book.favorites.find_by(user_id: current_user.id)
        @favorite.destroy
        redirect_to request.referer
    end
end
