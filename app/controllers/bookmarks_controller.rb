class BookmarksController < ApplicationController

	def create_bookmark
		@user=User.find_by_id(params[:user_id])
		if @user.present?
			 @subcat=Subcategory.find_by_id(params[:subcategory_id])
			 @bookmark=Bookmark.create(:user_id=>@user.id,:subcategory_id=>@subcat.id)
			 render :json => { :response_code => 200, :response_message => "Bookmark created",:bookmark=>@bookmark.as_json(except: [:created_at,:updated_at]) }
		else
			render :json => { :response_code => 500, :response_message => "something wrong"}
		end
	end

	def remove_bookmark
		@book=Bookmark.find_by_id(params[:bookmark_id])
		if @book.present?
			@bookmrk=@book.destroy
		  render :json => { :response_code => 200, :response_message => "Bookmark deleted"}
	  else
	  	render :json => { :response_code => 500, :response_message => "This Bookmark not exist"}
	  end
	end
end
