class BookCommentsController < ApplicationController

	def create
	 	@book_find = Book.find(params[:book_id])
	 	@comment = @book_find.book_comments.new(comment_params)
	 	@comment.user_id = current_user.id #同じ変数を使い、足りない情報を追加している
	 	@comments = BookComment.where(book_id: @book_find.id)
	 	if @comment.save
	 	   redirect_to book_path(@book_find.id)
	 	else
	 	   @user = User.find(@book_find.user_id)
	 	   @book = Book.new
           render template: "books/show"
	 	end
	end

	def destroy
		@comment = BookComment.find(params[:id])
        if @comment.user_id == current_user.id
           @comment.destroy
	       redirect_to request.referer
        else
           @book_find = Book.find(params[:book_id])
           @user = User.find(@book_find.user_id)
	 	   @book = Book.new
	 	   @comments = @book_find.book_comments
           render template: "books/show"
	    end
    end

	private
		def comment_params
			params.require(:book_comment).permit(:comment)
		end
end
